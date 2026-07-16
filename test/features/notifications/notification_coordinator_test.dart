import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/notifications/controller/notification_coordinator.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

void main() {
  group('NotificationCoordinator', () {
    late FakeMessaging messaging;
    late FakeLocalNotifications localNotifications;
    late FakeDevices devices;
    late FakeLivenessResponses livenessResponses;
    late List<String> openedRoutes;

    setUp(() {
      messaging = FakeMessaging();
      localNotifications = FakeLocalNotifications();
      devices = FakeDevices();
      livenessResponses = FakeLivenessResponses();
      openedRoutes = [];
    });

    tearDown(() async {
      await messaging.dispose();
    });

    NotificationCoordinator createCoordinator({bool isAndroid = true}) {
      return NotificationCoordinator(
        isAndroid: isAndroid,
        messaging: messaging,
        localNotifications: localNotifications,
        devices: devices,
        livenessResponses: livenessResponses,
        openRoute: openedRoutes.add,
        delay: (_) async {},
      );
    }

    test('does nothing for an unauthenticated session', () async {
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: false);

      expect(localNotifications.initializeCalls, 0);
      expect(messaging.activateCalls, 0);
      expect(devices.registeredTokens, isEmpty);
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
      expect(devices.registeredTokens, isEmpty);
    });

    test('activates and registers token after authentication', () async {
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: true);

      expect(messaging.activateCalls, 1);
      expect(devices.registeredTokens, ['test-token']);
    });

    test('registers replacement token after refresh', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      messaging.tokenRefreshController.add('refreshed-token');
      await pumpEventQueue();

      expect(devices.registeredTokens, ['test-token', 'refreshed-token']);
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

    test('shows liveness action and submits allowlisted risk type', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      messaging.foregroundController.add(
        const NotificationMessage(
          title: 'Are you safe?',
          body: 'Confirm that you are safe.',
          data: {
            'eventType': livenessCheckEventType,
            'riskType': highRiskAreaRiskType,
          },
        ),
      );
      await pumpEventQueue();

      final shown = localNotifications.shown.single;
      expect(shown.actions, const [
        LocalNotificationAction(
          id: livenessCheckYesActionId,
          label: "Yes, I'm safe",
        ),
      ]);

      localNotifications.respond(
        actionId: livenessCheckYesActionId,
        payload: shown.payload,
      );
      await pumpEventQueue();

      expect(livenessResponses.riskTypes, [highRiskAreaRiskType]);
    });

    test('ignores liveness action with an untrusted risk type', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      localNotifications.respond(
        actionId: livenessCheckYesActionId,
        payload: '{"riskType":"ADMIN"}',
      );
      await pumpEventQueue();

      expect(livenessResponses.riskTypes, isEmpty);
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
        devices.registeredTokens.clear();

        await coordinator.syncForSession(authenticated: false);
        messaging.tokenRefreshController.add('ignored-token');
        await pumpEventQueue();

        expect(devices.registeredTokens, isEmpty);
        expect(devices.unregisteredTokens, isEmpty);
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
      expect(messaging.activateCalls, 2);
      expect(devices.registeredTokens, ['test-token', 'test-token']);
    });

    test('retries registration after a temporary failure', () async {
      devices.registerFailuresRemaining = 1;
      final coordinator = createCoordinator();

      await coordinator.syncForSession(authenticated: true);

      expect(devices.registerAttempts, 2);
      expect(devices.registeredTokens, ['test-token']);
    });

    test(
      'retries on resume after registration retries are exhausted',
      () async {
        devices.registerFailuresRemaining = 3;
        final coordinator = createCoordinator();
        await coordinator.syncForSession(authenticated: true);

        await coordinator.syncForSession(authenticated: true);

        expect(devices.registerAttempts, 4);
        expect(devices.registeredTokens, ['test-token']);
      },
    );

    test('explicit logout keeps push identity and signs out', () async {
      final events = <String>[];
      devices.events = events;
      messaging.events = events;
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
      expect(devices.unregisteredTokens, isEmpty);
      expect(localNotifications.cancelAllCalls, 0);
    });

    test('logout does not wait for an in-flight registration', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);
      final events = <String>[];
      devices
        ..events = events
        ..registerCompleter = Completer<void>();
      messaging.tokenRefreshController.add('refreshed-token');
      await pumpEventQueue();
      final logout = SessionLogoutCoordinator(
        notifications: coordinator,
        authSignOut: () async => events.add('auth-sign-out'),
      );

      await logout.signOut();

      expect(events, ['register-start', 'auth-sign-out']);
      expect(devices.unregisteredTokens, isEmpty);

      devices.registerCompleter!.complete();
      await pumpEventQueue();
      expect(events, ['register-start', 'auth-sign-out', 'register-end']);
    });

    test('logout does not request a token only to unregister it', () async {
      final coordinator = createCoordinator();
      var authSignedOut = false;
      final logout = SessionLogoutCoordinator(
        notifications: coordinator,
        authSignOut: () async => authSignedOut = true,
      );

      await logout.signOut();

      expect(authSignedOut, isTrue);
      expect(messaging.activateCalls, 0);
      expect(devices.unregisteredTokens, isEmpty);
    });
  });
}

class FakeMessaging implements PushMessagingClient {
  final tokenRefreshController = StreamController<String>.broadcast(sync: true);
  final foregroundController = StreamController<NotificationMessage>.broadcast(
    sync: true,
  );
  final openedController = StreamController<NotificationMessage>.broadcast(
    sync: true,
  );

  int activateCalls = 0;
  List<String>? events;
  NotificationMessage? initialMessage;

  @override
  Future<String> activate() async {
    activateCalls++;
    return 'test-token';
  }

  @override
  Stream<NotificationMessage> get foregroundMessages =>
      foregroundController.stream;

  @override
  Future<NotificationMessage?> getInitialMessage() async => initialMessage;

  @override
  Stream<NotificationMessage> get openedMessages => openedController.stream;

  @override
  Stream<String> get tokenRefreshes => tokenRefreshController.stream;

  Future<void> dispose() async {
    await tokenRefreshController.close();
    await foregroundController.close();
    await openedController.close();
  }
}

class FakeLocalNotifications implements LocalNotificationClient {
  bool permissionGranted = true;
  int initializeCalls = 0;
  int cancelAllCalls = 0;
  final shown = <ShownNotification>[];
  List<String>? events;
  Future<void> Function(LocalNotificationResponse response)? _onResponse;

  @override
  Future<bool> initializeAndRequestPermission({
    required Future<void> Function(LocalNotificationResponse response)
    onResponse,
  }) async {
    initializeCalls++;
    _onResponse = onResponse;
    return permissionGranted;
  }

  @override
  Future<void> show({
    required int id,
    required String? title,
    required String? body,
    required String? payload,
    List<LocalNotificationAction> actions = const [],
  }) async {
    shown.add(
      ShownNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
        actions: actions,
      ),
    );
  }

  @override
  Future<void> cancelAll() async {
    cancelAllCalls++;
    events?.add('cancel-notifications');
  }

  void tap(String? payload) => respond(payload: payload);

  void respond({String? actionId, String? payload}) {
    final onResponse = _onResponse;
    if (onResponse == null) return;
    unawaited(
      onResponse(
        LocalNotificationResponse(actionId: actionId, payload: payload),
      ),
    );
  }
}

class FakeLivenessResponses implements LivenessCheckResponseClient {
  final riskTypes = <String>[];

  @override
  Future<void> respond(String riskType) async {
    riskTypes.add(riskType);
  }
}

class FakeDevices implements PushDeviceClient {
  final registeredTokens = <String>[];
  final unregisteredTokens = <String>[];
  List<String>? events;
  Completer<void>? registerCompleter;
  Completer<void>? unregisterCompleter;
  int registerAttempts = 0;
  int registerFailuresRemaining = 0;

  @override
  Future<void> register(String registrationToken) async {
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
    registeredTokens.add(registrationToken);
  }

  @override
  Future<void> unregister(String registrationToken) async {
    unregisteredTokens.add(registrationToken);
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
    required this.actions,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
  final List<LocalNotificationAction> actions;
}

Future<void> pumpEventQueue() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}
