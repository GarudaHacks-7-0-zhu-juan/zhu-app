import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';

class LocationRepository implements LocationReporter {
  const LocationRepository(this._client);

  final AuthenticatedApiClient _client;

  @override
  Future<LocationSafetyStatus> report(LocationPoint point) async {
    final json = await _client.postJsonResponse('/locations', {
      'latitude': point.latitude,
      'longitude': point.longitude,
    });
    final risk = json['risk'];
    if (risk is! Map<dynamic, dynamic>) {
      throw const FormatException('Location response has no risk status.');
    }
    return LocationSafetyStatus.fromJson(Map<String, dynamic>.from(risk));
  }
}
