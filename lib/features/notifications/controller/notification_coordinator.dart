import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

class NotificationCoordinator {
  NotificationCoordinator({
    required bool isAndroid,
    required PushMessagingClient messaging,
    required LocalNotificationClient localNotifications,
    required PushDeviceClient devices,
    required LivenessCheckResponseClient livenessResponses,
    required void Function(String route) openRoute,
    Future<void> Function(Duration duration)? delay,
  }) : _isAndroid = isAndroid,
       _messaging = messaging,
       _localNotifications = localNotifications,
       _devices = devices,
       _livenessResponses = livenessResponses,
       _openRoute = openRoute,
       _delay = delay ?? ((duration) => Future<void>.delayed(duration));

  static const allowedRoute = '/workspace';

  final bool _isAndroid;
  final PushMessagingClient _messaging;
  final LocalNotificationClient _localNotifications;
  final PushDeviceClient _devices;
  final LivenessCheckResponseClient _livenessResponses;
  final void Function(String route) _openRoute;
  final Future<void> Function(Duration duration) _delay;

  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<NotificationMessage>? _foregroundSubscription;
  StreamSubscription<NotificationMessage>? _openedSubscription;
  Future<void> _transition = Future.value();
  bool _active = false;
  bool _logoutRequested = false;
  bool _desiredAuthenticated = false;
  bool _checkedInitialMessage = false;
  int _generation = 0;
  int _nextNotificationId = 1;

  Future<void> syncForSession({required bool authenticated}) {
    if (_logoutRequested && authenticated) return Future.value();
    _desiredAuthenticated = authenticated;
    return _queueTransition(() async {
      if (authenticated) {
        if (!_desiredAuthenticated) return;
        await _start();
      } else {
        await _stop();
      }
    });
  }

  Future<void> signOut(Future<void> Function() authSignOut) {
    _logoutRequested = true;
    _desiredAuthenticated = false;
    return _queueTransition(() async {
      try {
        await _deactivate();
      } finally {
        try {
          await authSignOut();
        } finally {
          _logoutRequested = false;
        }
      }
    });
  }

  Future<void> stop() {
    _desiredAuthenticated = false;
    return _queueTransition(_stop);
  }

  Future<void> _stop() => _deactivate();

  Future<void> _queueTransition(Future<void> Function() action) {
    final operation = _transition.then((_) => action());
    _transition = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
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
          .initializeAndRequestPermission(onResponse: _handleLocalResponse);
      if (!_isCurrent(generation)) return;
      if (!permissionGranted) {
        await _stop();
        return;
      }

      _tokenRefreshSubscription = _messaging.tokenRefreshes.listen(
        _registerToken,
      );
      _foregroundSubscription = _messaging.foregroundMessages.listen(
        _showForegroundMessage,
      );
      _openedSubscription = _messaging.openedMessages.listen(
        _handleOpenedMessage,
      );

      final registrationToken = await _messaging.activate();
      _logInfo('Push messaging activated.');
      if (!_isCurrent(generation)) return;
      await _registerToken(registrationToken);
      if (!_isCurrent(generation) || _checkedInitialMessage) return;
      _checkedInitialMessage = true;
      final initialMessage = await _messaging.getInitialMessage();
      if (_isCurrent(generation) && initialMessage != null) {
        _handleOpenedMessage(initialMessage);
      }
    } catch (error, stackTrace) {
      _log('Could not start push notification sync.', error, stackTrace);
      await _stop();
    }
  }

  bool _isCurrent(int generation) => _active && _generation == generation;

  Future<void> _registerToken(String registrationToken) {
    if (!_active) return Future.value();
    return _performRegistration(registrationToken, _generation);
  }

  Future<void> _performRegistration(
    String registrationToken,
    int generation,
  ) async {
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        if (!_isCurrent(generation)) return;
        await _devices.register(registrationToken);
        _logInfo('Push device registered.');
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
    return _performForegroundDisplay(message);
  }

  Future<void> _performForegroundDisplay(NotificationMessage message) async {
    final route = routeFromData(message.data);
    final riskType = riskTypeFromData(message.data);
    final isLivenessCheck =
        message.data['eventType'] == livenessCheckEventType && riskType != null;
    final payload = <String, dynamic>{
      'route': ?route,
      if (isLivenessCheck) 'eventType': livenessCheckEventType,
      'riskType': ?riskType,
    };
    try {
      await _localNotifications.show(
        id: _nextNotificationId++,
        title: message.title,
        body: message.body,
        payload: payload.isEmpty ? null : jsonEncode(payload),
        actions: isLivenessCheck
            ? const [
                LocalNotificationAction(
                  id: livenessCheckYesActionId,
                  label: "Yes, I'm safe",
                ),
                LocalNotificationAction(
                  id: livenessCheckNoActionId,
                  label: "No, I'm not safe",
                ),
              ]
            : const [],
      );
    } catch (error, stackTrace) {
      _log('Could not show foreground notification.', error, stackTrace);
    }
  }

  void _handleOpenedMessage(NotificationMessage message) {
    final route = routeFromData(message.data);
    if (route != null) _openRoute(route);
  }

  Future<void> _handleLocalResponse(LocalNotificationResponse response) async {
    final isLivenessResponse =
        response.actionId == livenessCheckYesActionId ||
        response.actionId == livenessCheckNoActionId;
    if (isLivenessResponse) {
      final riskType = riskTypeFromPayload(response.payload);
      if (riskType == null) return;
      try {
        await _livenessResponses.respond(
          riskType,
          isOkay: response.actionId == livenessCheckYesActionId,
        );
        _logInfo('Liveness check response submitted.');
      } catch (error, stackTrace) {
        _log('Could not submit liveness check response.', error, stackTrace);
      }
      return;
    }

    final route = routeFromPayload(response.payload);
    if (route != null) _openRoute(route);
  }

  static String? routeFromData(Map<String, dynamic> data) {
    final route = data['route'];
    return route == allowedRoute ? allowedRoute : null;
  }

  static String? riskTypeFromData(Map<String, dynamic> data) {
    final riskType = data['riskType'];
    return riskType == highRiskAreaRiskType ? highRiskAreaRiskType : null;
  }

  static String? routeFromPayload(String? payload) {
    final decoded = _decodePayload(payload);
    return decoded == null ? null : routeFromData(decoded);
  }

  static String? riskTypeFromPayload(String? payload) {
    final decoded = _decodePayload(payload);
    return decoded == null ? null : riskTypeFromData(decoded);
  }

  static Map<String, dynamic>? _decodePayload(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    try {
      final decoded = jsonDecode(payload);
      return decoded is Map<String, dynamic> ? decoded : null;
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

  void _logInfo(String message) {
    developer.log(message, name: 'zhu_app.notifications');
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
