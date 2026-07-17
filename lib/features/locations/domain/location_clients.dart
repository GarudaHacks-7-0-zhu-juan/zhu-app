abstract interface class LocationClient {
  Stream<LocationPoint> get positions;
}

abstract interface class LocationReporter {
  Future<LocationSafetyStatus> report(LocationPoint point);
}

class LocationPoint {
  const LocationPoint({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  bool operator ==(Object other) {
    return other is LocationPoint &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => Object.hash(latitude, longitude);
}

class LocationSafetyStatus {
  const LocationSafetyStatus({
    required this.riskLevel,
    required this.activationMode,
  });

  final String riskLevel;
  final String activationMode;

  factory LocationSafetyStatus.fromJson(Map<String, dynamic> json) {
    final riskLevel = json['riskLevel'];
    final activationMode = json['livenessCheckActivationMode'];
    if (riskLevel is! String || activationMode is! String) {
      throw const FormatException('Invalid location safety status.');
    }
    return LocationSafetyStatus(
      riskLevel: riskLevel,
      activationMode: activationMode,
    );
  }
}
