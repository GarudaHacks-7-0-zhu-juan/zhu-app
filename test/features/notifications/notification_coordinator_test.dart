import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/notifications/controller/notification_coordinator.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

void main() {
  group('NotificationCoordinator', () {
    late FakeMessaging messaging;
    late FakeInstallations installations;
    late FakeLocalNotifications localNotifications;
    late FakeDevices devices;
    late List<String> openedRoutes;

    setUp(() {
      messaging = FakeMessaging();
      installations = FakeInstallations();
      localNotifications = FakeLocalNotifications();
      devices = FakeDevices();
      openedRoutes = [];
    });

    tearDown(() async {
      await messaging.dispose();
    });

    NotificationCoordinator createCoordinator({bool isAndroid = true}) {
      return NotificationCoordinator(
        isAndroid: isAndroid,
        messaging: messaging,
        installations: installations,
        localNotifications: localNotifications,
        devices: devices,
        openRoute: openedRoutes.add,
        delay: (_) async {},
      );
    }

    test('does nothing for an unauthenticated session', () async {
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: false);

      expect(localNotifications.initializeCalls, 0);
      expect(messaging.activateCalls, 0);
      expect(devices.registeredIds, isEmpty);
    });

    test('does nothing on non-Android platforms', () async {
      final coordinator = createCoordinator(isAndroid: false);

      await coordinator.syncForSession(authenticated: true);

      expect(localNotifications.initializeCalls, 0);
      expect(messaging.activateCalls, 0);
    });

    test('does not activate or register when permission is denied', () async {
      localNotifications.permissionGranted = false;
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: true);

      expect(localNotifications.initializeCalls, 1);
      expect(messaging.activateCalls, 0);
      expect(devices.registeredIds, isEmpty);
    });

    test('activates and registers installation after authentication', () async {
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: true);

      expect(messaging.activateCalls, 1);
      expect(devices.registeredIds, ['test-fid']);
    });

    test('re-registers current installation after token refresh', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      messaging.tokenRefreshController.add(null);
      await pumpEventQueue();

      expect(devices.registeredIds, ['test-fid', 'test-fid']);
      expect(installations.getIdCalls, 2);
    });

    test('shows foreground notification on high-level client', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      messaging.foregroundController.add(
        const NotificationMessage(
          title: 'Test title',
          body: 'Test body',
          data: {'route': '/workspace'},
        ),
      );
      await pumpEventQueue();

      expect(localNotifications.shown, hasLength(1));
      expect(localNotifications.shown.single.title, 'Test title');
      expect(localNotifications.shown.single.body, 'Test body');
      expect(jsonDecode(localNotifications.shown.single.payload!), {
        'route': '/workspace',
      });
    });

    test('opens only allowlisted routes from remote and local taps', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      messaging.openedController
        ..add(const NotificationMessage(data: {'route': '/workspace'}))
        ..add(const NotificationMessage(data: {'route': '/admin'}));
      localNotifications.tap('{"route":"/workspace"}');
      localNotifications.tap('{"route":"/admin"}');
      localNotifications.tap('not-json');
      await pumpEventQueue();

      expect(openedRoutes, ['/workspace', '/workspace']);
      expect(NotificationCoordinator.routeFromPayload('{"route":42}'), isNull);
    });

    test(
      'forced session loss stops listeners without clearing identity',
      () async {
        final coordinator = createCoordinator();
        await coordinator.syncForSession(authenticated: true);
        devices.registeredIds.clear();

        await coordinator.syncForSession(authenticated: false);
        messaging.tokenRefreshController.add(null);
        await pumpEventQueue();

        expect(devices.registeredIds, isEmpty);
        expect(devices.unregisteredIds, isEmpty);
        expect(messaging.deactivateCalls, 0);
        expect(installations.deleteCalls, 0);
        expect(localNotifications.cancelAllCalls, 0);
      },
    );

    test('reuses identity after rapid reauthentication', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      final signedOut = coordinator.syncForSession(authenticated: false);
      final signedBackIn = coordinator.syncForSession(authenticated: true);
      await Future.wait([signedOut, signedBackIn]);

      expect(localNotifications.cancelAllCalls, 0);
      expect(messaging.deactivateCalls, 0);
      expect(installations.deleteCalls, 0);
      expect(messaging.activateCalls, 2);
      expect(devices.registeredIds, ['test-fid', 'test-fid']);
    });

    test('retries registration after a temporary failure', () async {
      devices.registerFailuresRemaining = 1;
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: true);

      expect(devices.registerAttempts, 2);
      expect(devices.registeredIds, ['test-fid']);
    });

    test(
      'retries on resume after registration retries are exhausted',
      () async {
        devices.registerFailuresRemaining = 3;
        final coordinator = createCoordinator();
        await coordinator.syncForSession(authenticated: true);

        await coordinator.syncForSession(authenticated: true);

        expect(devices.registerAttempts, 4);
        expect(devices.registeredIds, ['test-fid']);
      },
    );

    test('explicit logout keeps push identity and signs out', () async {
      final events = <String>[];
      devices.events = events;
      messaging.events = events;
      installations.events = events;
      localNotifications.events = events;
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);
      events.clear();
      final logout = SessionLogoutCoordinator(
        notifications: coordinator,
        authSignOut: () async => events.add('auth-sign-out'),
      );

      await logout.signOut();

      expect(events, ['auth-sign-out']);
      expect(devices.unregisteredIds, isEmpty);
      expect(messaging.deactivateCalls, 0);
      expect(installations.deleteCalls, 0);
      expect(localNotifications.cancelAllCalls, 0);
    });

    test('logout does not wait for an in-flight registration', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);
      final events = <String>[];
      devices
        ..events = events
        ..registerCompleter = Completer<void>();
      messaging.tokenRefreshController.add(null);
      await pumpEventQueue();
      final logout = SessionLogoutCoordinator(
        notifications: coordinator,
        authSignOut: () async => events.add('auth-sign-out'),
      );

      await logout.signOut();

      expect(events, ['register-start', 'auth-sign-out']);
      expect(devices.unregisteredIds, isEmpty);

      devices.registerCompleter!.complete();
      await pumpEventQueue();
      expect(events, ['register-start', 'auth-sign-out', 'register-end']);
    });

    test(
      'logout does not create an installation only to unregister it',
      () async {
        final coordinator = createCoordinator();
        var authSignedOut = false;
        final logout = SessionLogoutCoordinator(
          notifications: coordinator,
          authSignOut: () async => authSignedOut = true,
        );

        await logout.signOut();

        expect(authSignedOut, isTrue);
        expect(installations.getIdCalls, 0);
        expect(devices.unregisteredIds, isEmpty);
      },
    );
  });
}

class FakeMessaging implements PushMessagingClient {
  final tokenRefreshController = StreamController<void>.broadcast(sync: true);
  final foregroundController = StreamController<NotificationMessage>.broadcast(
    sync: true,
  );
  final openedController = StreamController<NotificationMessage>.broadcast(
    sync: true,
  );

  int activateCalls = 0;
  int deactivateCalls = 0;
  List<String>? events;
  NotificationMessage? initialMessage;

  @override
  Future<void> activate() async {
    activateCalls++;
  }

  @override
  Future<void> deactivate() async {
    deactivateCalls++;
    events?.add('deactivate');
  }

  @override
  Stream<NotificationMessage> get foregroundMessages =>
      foregroundController.stream;

  @override
  Future<NotificationMessage?> getInitialMessage() async => initialMessage;

  @override
  Stream<NotificationMessage> get openedMessages => openedController.stream;

  @override
  Stream<void> get tokenRefreshes => tokenRefreshController.stream;

  Future<void> dispose() async {
    await tokenRefreshController.close();
    await foregroundController.close();
    await openedController.close();
  }
}

class FakeInstallations implements InstallationIdSource {
  int getIdCalls = 0;
  int deleteCalls = 0;
  List<String>? events;
  Completer<void>? deleteCompleter;

  @override
  Future<void> delete() async {
    deleteCalls++;
    events?.add('delete-installation');
    await deleteCompleter?.future;
  }

  @override
  Future<String> getId() async {
    getIdCalls++;
    return 'test-fid';
  }
}

class FakeLocalNotifications implements LocalNotificationClient {
  bool permissionGranted = true;
  int initializeCalls = 0;
  int cancelAllCalls = 0;
  final shown = <ShownNotification>[];
  List<String>? events;
  void Function(String? payload)? _onTap;

  @override
  Future<bool> initializeAndRequestPermission({
    required void Function(String? payload) onTap,
  }) async {
    initializeCalls++;
    _onTap = onTap;
    return permissionGranted;
  }

  @override
  Future<void> show({
    required int id,
    required String? title,
    required String? body,
    required String? payload,
  }) async {
    shown.add(
      ShownNotification(id: id, title: title, body: body, payload: payload),
    );
  }

  @override
  Future<void> cancelAll() async {
    cancelAllCalls++;
    events?.add('cancel-notifications');
  }

  void tap(String? payload) => _onTap?.call(payload);
}

class FakeDevices implements PushDeviceClient {
  final registeredIds = <String>[];
  final unregisteredIds = <String>[];
  List<String>? events;
  Completer<void>? registerCompleter;
  Completer<void>? unregisterCompleter;
  int registerAttempts = 0;
  int registerFailuresRemaining = 0;

  @override
  Future<void> register(String installationId) async {
    registerAttempts++;
    if (registerFailuresRemaining > 0) {
      registerFailuresRemaining--;
      throw Exception('temporary registration failure');
    }
    if (registerCompleter != null) {
      events?.add('register-start');
      await registerCompleter!.future;
      events?.add('register-end');
    }
    registeredIds.add(installationId);
  }

  @override
  Future<void> unregister(String installationId) async {
    unregisteredIds.add(installationId);
    events?.add('unregister');
    await unregisterCompleter?.future;
  }
}

class ShownNotification {
  const ShownNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

Future<void> pumpEventQueue() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}
