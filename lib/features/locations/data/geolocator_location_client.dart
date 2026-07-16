import 'package:geolocator/geolocator.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';

class GeolocatorLocationClient implements LocationClient {
  static const reportingInterval = Duration(seconds: 20);

  @override
  Stream<LocationPoint> get positions {
    final settings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
      intervalDuration: reportingInterval,
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationTitle: 'ProtectMe location sharing',
        notificationText: 'Your location is being shared for your safety.',
        notificationChannelName: 'ProtectMe location sharing',
        enableWakeLock: true,
        setOngoing: true,
      ),
    );
    return Geolocator.getPositionStream(locationSettings: settings).map(
      (position) => LocationPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
  }
}
