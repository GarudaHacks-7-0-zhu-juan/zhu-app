import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

class NotificationCoordinator {
  NotificationCoordinator({
    required bool isAndroid,
    required PushMessagingClient messaging,
    required InstallationIdSource installations,
    required LocalNotificationClient localNotifications,
    required PushDeviceClient devices,
    required void Function(String route) openRoute,
    Future<void> Function(Duration duration)? delay,
  }) : _isAndroid = isAndroid,
       _messaging = messaging,
       _installations = installations,
       _localNotifications = localNotifications,
       _devices = devices,
       _openRoute = openRoute,
       _delay = delay ?? ((duration) => Future<void>.delayed(duration));

  static const allowedRoute = '/workspace';

  final bool _isAndroid;
  final PushMessagingClient _messaging;
  final InstallationIdSource _installations;
  final LocalNotificationClient _localNotifications;
  final PushDeviceClient _devices;
  final void Function(String route) _openRoute;
  final Future<void> Function(Duration duration) _delay;

  StreamSubscription<void>? _tokenRefreshSubscription;
  StreamSubscription<NotificationMessage>? _foregroundSubscription;
  StreamSubscription<NotificationMessage>? _openedSubscription;
  final Set<Future<void>> _pendingRegistrations = {};
  final Set<Future<void>> _pendingDisplays = {};
  Future<void> _transition = Future.value();
  Future<void>? _identityCleanup;
  bool _active = false;
  bool _identityCleared = false;
  bool _logoutRequested = false;
  bool _desiredAuthenticated = false;
  bool _checkedInitialMessage = false;
  int _generation = 0;
  int _nextNotificationId = 1;
  String? _installationId;

  Future<void> syncForSession({required bool authenticated}) {
    if (_logoutRequested && authenticated) return Future.value();
    _desiredAuthenticated = authenticated;
    return _queueTransition(() async {
      if (authenticated) {
        if (!_desiredAuthenticated) return;
        await _start();
      } else {
        await _stop(clearIdentity: true);
      }
    });
  }

  Future<void> signOut(Future<void> Function() authSignOut) {
    _logoutRequested = true;
    _desiredAuthenticated = false;
    return _queueTransition(() async {
      try {
        await _unregisterForLogout();
        await authSignOut();
      } finally {
        await _stop(clearIdentity: true);
        _logoutRequested = false;
      }
    });
  }

  Future<void> _unregisterForLogout() async {
    if (!_isAndroid) return;
    await _deactivate();
    await Future.wait(_pendingRegistrations.toList());
    try {
      final installationId = _installationId ?? await _installations.getId();
      await _devices.unregister(installationId);
    } catch (error, stackTrace) {
      _log('Could not unregister push device.', error, stackTrace);
    }
  }

  Future<void> stop({bool clearIdentity = false}) {
    if (clearIdentity) _desiredAuthenticated = false;
    return _queueTransition(() => _stop(clearIdentity: clearIdentity));
  }

  Future<void> _stop({bool clearIdentity = false}) async {
    await _deactivate();
    await Future.wait(_pendingRegistrations.toList());
    if (clearIdentity && _isAndroid) {
      await Future.wait(_pendingDisplays.toList());
      try {
        await _localNotifications.cancelAll();
      } catch (error, stackTrace) {
        _log('Could not clear displayed notifications.', error, stackTrace);
      }
      await _clearLocalIdentity();
    }
    _installationId = null;
  }

  Future<void> _queueTransition(Future<void> Function() action) {
    final operation = _transition.then((_) => action());
    _transition = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }

  Future<void> _clearLocalIdentity() {
    if (_identityCleared) return Future.value();
    return _identityCleanup ??= _performIdentityCleanup().whenComplete(
      () => _identityCleanup = null,
    );
  }

  Future<void> _performIdentityCleanup() async {
    var succeeded = true;
    try {
      await _messaging.deactivate();
    } catch (error, stackTrace) {
      succeeded = false;
      _log('Could not deactivate push messaging.', error, stackTrace);
    }
    try {
      await _installations.delete();
    } catch (error, stackTrace) {
      succeeded = false;
      _log('Could not delete Firebase installation.', error, stackTrace);
    }
    if (succeeded) _identityCleared = true;
  }

  Future<void> _deactivate() async {
    _active = false;
    _generation++;
    final subscriptions = [
      _tokenRefreshSubscription?.cancel(),
      _foregroundSubscription?.cancel(),
      _openedSubscription?.cancel(),
    ].whereType<Future<void>>();
    _tokenRefreshSubscription = null;
    _foregroundSubscription = null;
    _openedSubscription = null;
    await Future.wait(subscriptions);
  }

  Future<void> _start() async {
    if (!_isAndroid || _active) return;
    _active = true;
    final generation = ++_generation;

    try {
      final permissionGranted = await _localNotifications
          .initializeAndRequestPermission(onTap: _handleLocalTap);
      if (!_isCurrent(generation)) return;
      if (!permissionGranted) {
        await _stop(clearIdentity: true);
        return;
      }

      _tokenRefreshSubscription = _messaging.tokenRefreshes.listen(
        (_) => _registerCurrentId(),
      );
      _foregroundSubscription = _messaging.foregroundMessages.listen(
        _showForegroundMessage,
      );
      _openedSubscription = _messaging.openedMessages.listen(
        _handleOpenedMessage,
      );

      _identityCleared = false;
      await _messaging.activate();
      if (!_isCurrent(generation)) return;
      await _registerCurrentId();
      if (!_isCurrent(generation) || _checkedInitialMessage) return;
      _checkedInitialMessage = true;
      final initialMessage = await _messaging.getInitialMessage();
      if (_isCurrent(generation) && initialMessage != null) {
        _handleOpenedMessage(initialMessage);
      }
    } catch (error, stackTrace) {
      _log('Could not start push notification sync.', error, stackTrace);
      await _stop(clearIdentity: true);
    }
  }

  bool _isCurrent(int generation) => _active && _generation == generation;

  Future<void> _registerCurrentId() {
    if (!_active) return Future.value();
    final generation = _generation;
    final operation = _performRegistration(generation);
    _pendingRegistrations.add(operation);
    return operation.whenComplete(
      () => _pendingRegistrations.remove(operation),
    );
  }

  Future<void> _performRegistration(int generation) async {
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        final installationId = await _installations.getId();
        if (!_isCurrent(generation)) return;
        await _devices.register(installationId);
        if (_isCurrent(generation)) _installationId = installationId;
        return;
      } catch (error, stackTrace) {
        if (attempt == 2) {
          _log('Could not register push device.', error, stackTrace);
          await _deactivate();
          return;
        }
      }
      await _delay(Duration(seconds: 1 << attempt));
      if (!_isCurrent(generation)) return;
    }
  }

  Future<void> _showForegroundMessage(NotificationMessage message) {
    if (!_active || (message.title == null && message.body == null)) {
      return Future.value();
    }
    final operation = _performForegroundDisplay(message);
    _pendingDisplays.add(operation);
    return operation.whenComplete(() => _pendingDisplays.remove(operation));
  }

  Future<void> _performForegroundDisplay(NotificationMessage message) async {
    final route = routeFromData(message.data);
    try {
      await _localNotifications.show(
        id: _nextNotificationId++,
        title: message.title,
        body: message.body,
        payload: route == null ? null : jsonEncode({'route': route}),
      );
    } catch (error, stackTrace) {
      _log('Could not show foreground notification.', error, stackTrace);
    }
  }

  void _handleOpenedMessage(NotificationMessage message) {
    final route = routeFromData(message.data);
    if (route != null) _openRoute(route);
  }

  void _handleLocalTap(String? payload) {
    final route = routeFromPayload(payload);
    if (route != null) _openRoute(route);
  }

  static String? routeFromData(Map<String, dynamic> data) {
    final route = data['route'];
    return route == allowedRoute ? allowedRoute : null;
  }

  static String? routeFromPayload(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    try {
      final decoded = jsonDecode(payload);
      if (decoded is! Map<String, dynamic>) return null;
      return routeFromData(decoded);
    } on FormatException {
      return null;
    }
  }

  void _log(String message, Object error, StackTrace stackTrace) {
    developer.log(
      message,
      name: 'zhu_app.notifications',
      error: error.runtimeType,
      stackTrace: stackTrace,
    );
  }
}

class SessionLogoutCoordinator {
  const SessionLogoutCoordinator({
    required NotificationCoordinator notifications,
    required Future<void> Function() authSignOut,
  }) : _notifications = notifications,
       _authSignOut = authSignOut;

  final NotificationCoordinator _notifications;
  final Future<void> Function() _authSignOut;

  Future<void> signOut() => _notifications.signOut(_authSignOut);
}
