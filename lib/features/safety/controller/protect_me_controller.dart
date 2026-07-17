import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';
import 'package:zhu_app/features/safety/data/safety_repository.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

final protectMeControllerProvider =
    AsyncNotifierProvider<ProtectMeController, List<ProtectMeStatus>>(
      ProtectMeController.new,
    );

class ProtectMeController extends AsyncNotifier<List<ProtectMeStatus>> {
  @override
  Future<List<ProtectMeStatus>> build() {
    return ref.read(safetyRepositoryProvider).loadProtectMeStatuses();
  }

  Future<void> setEnabled(ProtectMeRiskType riskType, bool enabled) async {
    final previous = _currentStatuses();
    if (previous == null) return;

    final index = previous.indexWhere((status) => status.riskType == riskType);
    if (index == -1) return;

    final updated = await ref
        .read(safetyRepositoryProvider)
        .setProtectMeEnabled(riskType, enabled: enabled);
    state = AsyncData(_replace(previous, updated));
  }

  void applyLocationStatus(LocationSafetyStatus locationStatus) {
    final previous = _currentStatuses();
    if (previous == null) return;
    state = AsyncData(
      _replace(
        previous,
        ProtectMeStatus(
          riskType: ProtectMeRiskType.highRiskArea,
          riskLevel: locationStatus.riskLevel,
          activationMode: ProtectMeActivationMode.fromApiValue(
            locationStatus.activationMode,
          ),
        ),
      ),
    );
  }

  List<ProtectMeStatus> _replace(
    List<ProtectMeStatus> previous,
    ProtectMeStatus updated,
  ) {
    return [
      for (final status in previous)
        if (status.riskType == updated.riskType) updated else status,
    ];
  }

  List<ProtectMeStatus>? _currentStatuses() {
    return switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
  }
}
