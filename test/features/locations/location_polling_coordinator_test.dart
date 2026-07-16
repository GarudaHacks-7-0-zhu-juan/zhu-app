import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/locations/controller/location_polling_coordinator.dart';
import 'package:zhu_app/features/locations/domain/location_clients.dart';

void main() {
  group('LocationPollingCoordinator', () {
    late FakeLocationClient locations;
    late FakeLocationReporter reporter;
    late DateTime now;

    setUp(() {
      locations = FakeLocationClient();
      reporter = FakeLocationReporter();
      now = DateTime(2026);
    });

    tearDown(() => locations.dispose());

    LocationPollingCoordinator createCoordinator() {
      return LocationPollingCoordinator(
        locations: locations,
        reporter: reporter,
        clock: () => now,
      );
    }

    test(
      'reports first position then throttles updates for 20 seconds',
      () async {
        final coordinator = createCoordinator();
        await coordinator.syncForSession(authenticated: true);

        locations.add(const LocationPoint(latitude: -10, longitude: -20));
        await pumpEventQueue();
        now = now.add(const Duration(seconds: 19));
        locations.add(const LocationPoint(latitude: -11, longitude: -21));
        await pumpEventQueue();
        now = now.add(const Duration(seconds: 1));
        locations.add(const LocationPoint(latitude: -12, longitude: -22));
        await pumpEventQueue();

        expect(reporter.points, [
          const LocationPoint(latitude: -10, longitude: -20),
          const LocationPoint(latitude: -12, longitude: -22),
        ]);
      },
    );

    test('continues reporting after an upload failure', () async {
      reporter.failuresRemaining = 1;
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);

      locations.add(const LocationPoint(latitude: -10, longitude: -20));
      await pumpEventQueue();
      now = now.add(const Duration(seconds: 20));
      locations.add(const LocationPoint(latitude: -11, longitude: -21));
      await pumpEventQueue();

      expect(reporter.attempts, 2);
      expect(reporter.points, [
        const LocationPoint(latitude: -11, longitude: -21),
      ]);
    });

    test('stops receiving positions after logout', () async {
      final coordinator = createCoordinator();
      await coordinator.syncForSession(authenticated: true);
      await coordinator.stop();

      locations.add(const LocationPoint(latitude: -10, longitude: -20));
      await pumpEventQueue();

      expect(reporter.points, isEmpty);
    });
  });
}

class FakeLocationClient implements LocationClient {
  final _controller = StreamController<LocationPoint>.broadcast(sync: true);

  @override
  Stream<LocationPoint> get positions => _controller.stream;

  void add(LocationPoint point) => _controller.add(point);

  Future<void> dispose() => _controller.close();
}

class FakeLocationReporter implements LocationReporter {
  final points = <LocationPoint>[];
  int attempts = 0;
  int failuresRemaining = 0;

  @override
  Future<void> report(LocationPoint point) async {
    attempts++;
    if (failuresRemaining > 0) {
      failuresRemaining--;
      throw StateError('network unavailable');
    }
    points.add(point);
  }
}

Future<void> pumpEventQueue() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}
