import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

final appPermissionsGatewayProvider = Provider<AppPermissionsGateway>(
  (ref) => AppPermissionsGateway(),
);

class AppPermissionsGateway {
  Future<PermissionStatus> notificationStatus() {
    return Permission.notification.status;
  }

  Future<PermissionStatus> requestNotificationPermission() {
    return Permission.notification.request();
  }

  Future<LocationPermission> locationPermission() {
    return Geolocator.checkPermission();
  }

  Future<LocationPermission> requestLocationPermission() {
    return Geolocator.requestPermission();
  }

  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }
}
