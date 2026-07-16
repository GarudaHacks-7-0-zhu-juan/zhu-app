import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/permissions/data/app_permissions_gateway.dart';
import 'package:zhu_app/features/permissions/domain/app_permission_requirement.dart';

part 'app_permissions_controller.g.dart';

@Riverpod(keepAlive: true)
class AppPermissionsController extends _$AppPermissionsController {
  bool _checking = false;

  @override
  Future<AppPermissionRequirement> build() async {
    _checking = true;
    try {
      return await _checkAndRequest();
    } finally {
      _checking = false;
    }
  }

  Future<void> recheck() async {
    if (_checking) {
      return;
    }

    _checking = true;
    state = const AsyncLoading();
    try {
      state = AsyncData(await _checkAndRequest());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    } finally {
      _checking = false;
    }
  }

  Future<AppPermissionRequirement> _checkAndRequest() async {
    final gateway = ref.read(appPermissionsGatewayProvider);
    var notificationStatus = await gateway.notificationStatus();

    if (!_notificationGranted(notificationStatus)) {
      notificationStatus = await gateway.requestNotificationPermission();
      if (!_notificationGranted(notificationStatus)) {
        return notificationStatus == PermissionStatus.permanentlyDenied
            ? AppPermissionRequirement.notificationPermanentlyDenied
            : AppPermissionRequirement.notificationDenied;
      }
    }

    var locationPermission = await gateway.locationPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await gateway.requestLocationPermission();
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return AppPermissionRequirement.locationPermanentlyDenied;
    }
    if (locationPermission != LocationPermission.always &&
        locationPermission != LocationPermission.whileInUse) {
      return AppPermissionRequirement.locationDenied;
    }

    if (gateway.requiresBackgroundLocationPermission) {
      var backgroundLocationStatus = await gateway.backgroundLocationStatus();
      if (!backgroundLocationStatus.isGranted) {
        backgroundLocationStatus = await gateway
            .requestBackgroundLocationPermission();
      }
      if (!backgroundLocationStatus.isGranted) {
        return backgroundLocationStatus.isPermanentlyDenied
            ? AppPermissionRequirement.backgroundLocationPermanentlyDenied
            : AppPermissionRequirement.backgroundLocationDenied;
      }
    }

    if (!await gateway.isLocationServiceEnabled()) {
      return AppPermissionRequirement.locationServicesDisabled;
    }

    return AppPermissionRequirement.ready;
  }

  bool _notificationGranted(PermissionStatus status) {
    return status == PermissionStatus.granted ||
        status == PermissionStatus.provisional;
  }
}
