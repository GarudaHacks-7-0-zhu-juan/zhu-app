import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

class LivenessCheckResponseRepository implements LivenessCheckResponseClient {
  const LivenessCheckResponseRepository(this._client);

  final AuthenticatedApiClient _client;

  @override
  Future<void> respond(String riskType) {
    final encodedRiskType = Uri.encodeComponent(riskType);
    return _client.post('/user-risks/$encodedRiskType/liveness-check/respond');
  }
}
