import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

final safetyRepositoryProvider = Provider<SafetyRepository>(
  (ref) => SafetyRepository(ref.watch(authenticatedApiClientProvider)),
);

class SafetyRepository {
  const SafetyRepository(this._client);

  final AuthenticatedApiClient _client;

  Future<List<ProtectMeStatus>> loadProtectMeStatuses() async {
    final statuses = await _client.getJsonList('/user-risks/liveness-check');
    return statuses.map(ProtectMeStatus.fromJson).toList(growable: false);
  }

  Future<ProtectMeStatus> setProtectMeEnabled(
    ProtectMeRiskType riskType, {
    required bool enabled,
  }) async {
    final json = await _client.patchJson(
      '/user-risks/${riskType.apiValue}/liveness-check',
      {'enabled': enabled},
    );
    return ProtectMeStatus.fromJson(json);
  }

  Future<void> reportFall() {
    return _client.postJson('/accidents', {'eventType': 'FALL_DETECTED'});
  }
}
