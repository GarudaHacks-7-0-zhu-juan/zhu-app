import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';
import 'package:zhu_app/features/auth/data/auth_token_manager.dart';
import 'package:zhu_app/features/auth/data/auth_token_store.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';
import 'package:zhu_app/features/safety/controller/protect_me_controller.dart';
import 'package:zhu_app/features/safety/data/safety_repository.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

void main() {
  test(
    'updates a manual toggle and applies immediate location status',
    () async {
      final repository = _FakeSafetyRepository();
      final container = ProviderContainer(
        overrides: [safetyRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      await container.read(protectMeControllerProvider.future);
      await container
          .read(protectMeControllerProvider.notifier)
          .setEnabled(ProtectMeRiskType.disaster, true);
      container
          .read(protectMeControllerProvider.notifier)
          .applyLocationStatus(
            const LocationSafetyStatus(
              riskLevel: 'HIGH',
              activationMode: 'AUTO',
            ),
          );

      final statuses = container.read(protectMeControllerProvider).requireValue;
      expect(repository.updatedRiskType, ProtectMeRiskType.disaster);
      expect(repository.updatedEnabled, isTrue);
      expect(statuses[0].riskType, ProtectMeRiskType.highRiskArea);
      expect(statuses[0].riskLevel, 'HIGH');
      expect(statuses[0].activationMode, ProtectMeActivationMode.auto);
      expect(statuses[1].riskType, ProtectMeRiskType.disaster);
      expect(statuses[1].activationMode, ProtectMeActivationMode.manual);
    },
  );
}

class _FakeSafetyRepository extends SafetyRepository {
  _FakeSafetyRepository() : super(_unusedClient());

  ProtectMeRiskType? updatedRiskType;
  bool? updatedEnabled;

  @override
  Future<List<ProtectMeStatus>> loadProtectMeStatuses() async {
    return const [
      ProtectMeStatus(
        riskType: ProtectMeRiskType.highRiskArea,
        riskLevel: 'NONE',
        activationMode: ProtectMeActivationMode.off,
      ),
      ProtectMeStatus(
        riskType: ProtectMeRiskType.disaster,
        riskLevel: 'NONE',
        activationMode: ProtectMeActivationMode.off,
      ),
    ];
  }

  @override
  Future<ProtectMeStatus> setProtectMeEnabled(
    ProtectMeRiskType riskType, {
    required bool enabled,
  }) async {
    updatedRiskType = riskType;
    updatedEnabled = enabled;
    return ProtectMeStatus(
      riskType: riskType,
      riskLevel: 'NONE',
      activationMode: enabled
          ? ProtectMeActivationMode.manual
          : ProtectMeActivationMode.off,
    );
  }
}

AuthenticatedApiClient _unusedClient() {
  final dio = Dio();
  return AuthenticatedApiClient(
    dio: dio,
    tokenManager: AuthTokenManager(
      dataSource: AuthDataSource(dio),
      store: AuthTokenStore(),
    ),
  );
}
