import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/app/app_router.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/notifications/controller/notification_coordinator.dart';
import 'package:zhu_app/features/notifications/data/firebase_notification_clients.dart';
import 'package:zhu_app/features/notifications/data/push_device_repository.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

final pushMessagingClientProvider = Provider<PushMessagingClient>(
  (ref) => FirebasePushMessagingClient(),
);

final localNotificationClientProvider = Provider<LocalNotificationClient>(
  (ref) => AndroidLocalNotificationClient(),
);

final pushDeviceClientProvider = Provider<PushDeviceClient>(
  (ref) => PushDeviceRepository(ref.watch(authenticatedApiClientProvider)),
);

final notificationCoordinatorProvider = Provider<NotificationCoordinator>(
  (ref) => NotificationCoordinator(
    isAndroid: !kIsWeb && defaultTargetPlatform == TargetPlatform.android,
    messaging: ref.watch(pushMessagingClientProvider),
    localNotifications: ref.watch(localNotificationClientProvider),
    devices: ref.watch(pushDeviceClientProvider),
    openRoute: ref.watch(appRouterProvider).go,
  ),
);

final notificationLifecycleProvider = Provider<void>((ref) {
  final coordinator = ref.watch(notificationCoordinatorProvider);
  ref.listen(authSessionControllerProvider, (_, next) {
    if (next is InitializingAuthSessionState) return;
    unawaited(
      next is AuthenticatedAuthSessionState
          ? coordinator.syncForSession(authenticated: true)
          : coordinator.stop(),
    );
  }, fireImmediately: true);
  ref.onDispose(() => unawaited(coordinator.stop()));
});

final sessionLogoutCoordinatorProvider = Provider<SessionLogoutCoordinator>(
  (ref) => SessionLogoutCoordinator(
    notifications: ref.watch(notificationCoordinatorProvider),
    authSignOut: ref.read(authSessionControllerProvider.notifier).signOut,
  ),
);
