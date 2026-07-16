abstract interface class LocationClient {
  Stream<LocationPoint> get positions;
}

abstract interface class LocationReporter {
  Future<void> report(LocationPoint point);
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
