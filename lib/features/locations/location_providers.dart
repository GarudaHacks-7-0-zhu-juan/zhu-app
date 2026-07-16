import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/locations/controller/location_polling_coordinator.dart';
import 'package:zhu_app/features/locations/data/geolocator_location_client.dart';
import 'package:zhu_app/features/locations/data/location_repository.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';
import 'package:zhu_app/features/permissions/controller/app_permissions_controller.dart';
import 'package:zhu_app/features/permissions/domain/app_permission_requirement.dart';

final locationClientProvider = Provider<LocationClient>(
  (ref) => GeolocatorLocationClient(),
);

final locationReporterProvider = Provider<LocationReporter>(
  (ref) => LocationRepository(ref.watch(authenticatedApiClientProvider)),
);

final locationPollingCoordinatorProvider = Provider<LocationPollingCoordinator>(
  (ref) => LocationPollingCoordinator(
    locations: ref.watch(locationClientProvider),
    reporter: ref.watch(locationReporterProvider),
  ),
);

final locationLifecycleProvider = Provider<void>((ref) {
  final coordinator = ref.watch(locationPollingCoordinatorProvider);
  final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  void sync() {
    final session = ref.read(authSessionControllerProvider);
    final permissions = ref.read(appPermissionsControllerProvider);
    final shouldTrack =
        isAndroid &&
        session is AuthenticatedAuthSessionState &&
        permissions.value == AppPermissionRequirement.ready;
    unawaited(coordinator.syncForSession(authenticated: shouldTrack));
  }

  ref.listen(
    authSessionControllerProvider,
    (_, _) => sync(),
    fireImmediately: true,
  );
  ref.listen(appPermissionsControllerProvider, (_, _) => sync());
  ref.onDispose(() => unawaited(coordinator.stop()));
});
