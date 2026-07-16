import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

class PushDeviceRepository implements PushDeviceClient {
  const PushDeviceRepository(this._client);

  final AuthenticatedApiClient _client;

  @override
  Future<void> register(String registrationToken) {
    return _client.postJson('/push/devices', {
      'registrationToken': registrationToken,
      'platform': 'android',
    });
  }

  @override
  Future<void> unregister(String registrationToken) {
    final encodedToken = Uri.encodeComponent(registrationToken);
    return _client.delete('/push/devices/$encodedToken');
  }
}
