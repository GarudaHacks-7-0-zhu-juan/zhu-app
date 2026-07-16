import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/features/permissions/controller/app_permissions_controller.dart';
import 'package:zhu_app/features/permissions/data/app_permissions_gateway.dart';
import 'package:zhu_app/features/permissions/domain/app_permission_requirement.dart';

void main() {
  test('requests missing permissions and becomes ready', () async {
    final gateway = FakeAppPermissionsGateway(
      notification: PermissionStatus.denied,
      requestedNotification: PermissionStatus.granted,
      location: LocationPermission.denied,
      requestedLocation: LocationPermission.whileInUse,
    );
    final container = _createContainer(gateway);
    addTearDown(container.dispose);

    final result = await container.read(
      appPermissionsControllerProvider.future,
    );

    expect(result, AppPermissionRequirement.ready);
    expect(gateway.notificationRequestCount, 1);
    expect(gateway.locationRequestCount, 1);
  });

  test('blocks when notification permission is permanently denied', () async {
    final gateway = FakeAppPermissionsGateway(
      notification: PermissionStatus.permanentlyDenied,
      requestedNotification: PermissionStatus.permanentlyDenied,
    );
    final container = _createContainer(gateway);
    addTearDown(container.dispose);

    final result = await container.read(
      appPermissionsControllerProvider.future,
    );

    expect(result, AppPermissionRequirement.notificationPermanentlyDenied);
    expect(gateway.locationRequestCount, 0);
  });

  test('blocks when location permission is permanently denied', () async {
    final gateway = FakeAppPermissionsGateway(
      notification: PermissionStatus.granted,
      location: LocationPermission.deniedForever,
    );
    final container = _createContainer(gateway);
    addTearDown(container.dispose);

    final result = await container.read(
      appPermissionsControllerProvider.future,
    );

    expect(result, AppPermissionRequirement.locationPermanentlyDenied);
  });

  test('blocks when device location services are disabled', () async {
    final gateway = FakeAppPermissionsGateway(
      notification: PermissionStatus.granted,
      location: LocationPermission.whileInUse,
      locationServiceEnabled: false,
    );
    final container = _createContainer(gateway);
    addTearDown(container.dispose);

    final result = await container.read(
      appPermissionsControllerProvider.future,
    );

    expect(result, AppPermissionRequirement.locationServicesDisabled);
  });

  test('requires background location access on Android', () async {
    final gateway = FakeAppPermissionsGateway(
      notification: PermissionStatus.granted,
      location: LocationPermission.whileInUse,
      requiresBackgroundLocation: true,
      backgroundLocation: PermissionStatus.denied,
      requestedBackgroundLocation: PermissionStatus.granted,
    );
    final container = _createContainer(gateway);
    addTearDown(container.dispose);

    final result = await container.read(
      appPermissionsControllerProvider.future,
    );

    expect(result, AppPermissionRequirement.ready);
    expect(gateway.backgroundLocationRequestCount, 1);
  });
}

ProviderContainer _createContainer(FakeAppPermissionsGateway gateway) {
  return ProviderContainer(
    overrides: [appPermissionsGatewayProvider.overrideWithValue(gateway)],
  );
}

class FakeAppPermissionsGateway extends AppPermissionsGateway {
  FakeAppPermissionsGateway({
    required this.notification,
    this.requestedNotification,
    this.location = LocationPermission.denied,
    this.requestedLocation,
    this.locationServiceEnabled = true,
    this.requiresBackgroundLocation = false,
    this.backgroundLocation = PermissionStatus.denied,
    this.requestedBackgroundLocation,
  });

  PermissionStatus notification;
  PermissionStatus? requestedNotification;
  LocationPermission location;
  LocationPermission? requestedLocation;
  bool locationServiceEnabled;
  bool requiresBackgroundLocation;
  PermissionStatus backgroundLocation;
  PermissionStatus? requestedBackgroundLocation;
  int notificationRequestCount = 0;
  int locationRequestCount = 0;
  int backgroundLocationRequestCount = 0;

  @override
  bool get requiresBackgroundLocationPermission => requiresBackgroundLocation;

  @override
  Future<PermissionStatus> notificationStatus() async => notification;

  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    notificationRequestCount++;
    return requestedNotification ?? notification;
  }

  @override
  Future<LocationPermission> locationPermission() async => location;

  @override
  Future<LocationPermission> requestLocationPermission() async {
    locationRequestCount++;
    return requestedLocation ?? location;
  }

  @override
  Future<PermissionStatus> backgroundLocationStatus() async =>
      backgroundLocation;

  @override
  Future<PermissionStatus> requestBackgroundLocationPermission() async {
    backgroundLocationRequestCount++;
    return requestedBackgroundLocation ?? backgroundLocation;
  }

  @override
  Future<bool> isLocationServiceEnabled() async => locationServiceEnabled;
}
