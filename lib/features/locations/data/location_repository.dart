import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';

class LocationRepository implements LocationReporter {
  const LocationRepository(this._client);

  final AuthenticatedApiClient _client;

  @override
  Future<void> report(LocationPoint point) {
    return _client.postJson('/locations', {
      'latitude': point.latitude,
      'longitude': point.longitude,
    });
  }
}
