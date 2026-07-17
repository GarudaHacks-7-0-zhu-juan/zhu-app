enum ProtectMeRiskType {
  highRiskArea,
  disaster;

  String get apiValue => switch (this) {
    ProtectMeRiskType.highRiskArea => 'HIGH_RISK_AREA',
    ProtectMeRiskType.disaster => 'DISASTER',
  };

  String get label => switch (this) {
    ProtectMeRiskType.highRiskArea => 'High-risk area',
    ProtectMeRiskType.disaster => 'Disaster',
  };

  String get description => switch (this) {
    ProtectMeRiskType.highRiskArea =>
      'Check in every minute when location safety monitoring is active.',
    ProtectMeRiskType.disaster =>
      'Check in every minute after an affecting disaster alert.',
  };

  static ProtectMeRiskType fromApiValue(String value) => switch (value) {
    'HIGH_RISK_AREA' => ProtectMeRiskType.highRiskArea,
    'DISASTER' => ProtectMeRiskType.disaster,
    _ => throw FormatException('Unknown Protect Me risk type: $value'),
  };
}

enum ProtectMeActivationMode {
  off,
  manual,
  auto;

  bool get isEnabled => this != ProtectMeActivationMode.off;

  static ProtectMeActivationMode fromApiValue(String value) => switch (value) {
    'OFF' => ProtectMeActivationMode.off,
    'MANUAL' => ProtectMeActivationMode.manual,
    'AUTO' => ProtectMeActivationMode.auto,
    _ => throw FormatException('Unknown Protect Me activation mode: $value'),
  };
}

class ProtectMeStatus {
  const ProtectMeStatus({
    required this.riskType,
    required this.riskLevel,
    required this.activationMode,
  });

  final ProtectMeRiskType riskType;
  final String riskLevel;
  final ProtectMeActivationMode activationMode;

  bool get isEnabled => activationMode.isEnabled;

  String get modeLabel => switch (activationMode) {
    ProtectMeActivationMode.auto => 'AUTO ENABLED',
    ProtectMeActivationMode.manual => 'MANUALLY ENABLED',
    ProtectMeActivationMode.off => 'OFF',
  };

  factory ProtectMeStatus.fromJson(Map<String, dynamic> json) {
    final riskType = json['riskType'];
    final riskLevel = json['riskLevel'];
    final activationMode = json['livenessCheckActivationMode'];
    if (riskType is! String ||
        riskLevel is! String ||
        activationMode is! String) {
      throw const FormatException('Invalid Protect Me status.');
    }
    return ProtectMeStatus(
      riskType: ProtectMeRiskType.fromApiValue(riskType),
      riskLevel: riskLevel,
      activationMode: ProtectMeActivationMode.fromApiValue(activationMode),
    );
  }
}
