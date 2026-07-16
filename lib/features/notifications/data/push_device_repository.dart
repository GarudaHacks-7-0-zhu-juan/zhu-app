import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

class PushDeviceRepository implements PushDeviceClient {
  const PushDeviceRepository(this._client);

  final AuthenticatedApiClient _client;

  @override
  Future<void> register(String installationId) {
    return _client.postJson('/push/devices', {
      'firebaseInstallationId': installationId,
      'platform': 'android',
    });
  }

  @override
  Future<void> unregister(String installationId) {
    final encodedId = Uri.encodeComponent(installationId);
    return _client.delete('/push/devices/$encodedId');
  }
}
