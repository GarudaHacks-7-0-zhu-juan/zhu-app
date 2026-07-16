import 'dart:async';
import 'dart:developer' as developer;

import 'package:zhu_app/features/locations/domain/location_clients.dart';

class LocationPollingCoordinator {
  LocationPollingCoordinator({
    required LocationClient locations,
    required LocationReporter reporter,
    DateTime Function()? clock,
  }) : _locations = locations,
       _reporter = reporter,
       _clock = clock ?? DateTime.now;

  static const reportingInterval = Duration(seconds: 20);

  final LocationClient _locations;
  final LocationReporter _reporter;
  final DateTime Function() _clock;

  StreamSubscription<LocationPoint>? _positionSubscription;
  DateTime? _lastReportAttempt;
  bool _active = false;
  bool _sending = false;

  Future<void> syncForSession({required bool authenticated}) {
    return authenticated ? _start() : stop();
  }

  Future<void> stop() async {
    _active = false;
    _lastReportAttempt = null;
    final subscription = _positionSubscription;
    _positionSubscription = null;
    await subscription?.cancel();
  }

  Future<void> _start() async {
    if (_active) return;
    _active = true;
    _positionSubscription = _locations.positions.listen(
      _handlePosition,
      onError: _handleLocationError,
    );
  }

  void _handlePosition(LocationPoint point) {
    if (!_active || _sending) return;

    final now = _clock();
    final lastReportAttempt = _lastReportAttempt;
    if (lastReportAttempt != null &&
        now.difference(lastReportAttempt) < reportingInterval) {
      return;
    }

    _lastReportAttempt = now;
    unawaited(_report(point));
  }

  Future<void> _report(LocationPoint point) async {
    _sending = true;
    try {
      await _reporter.report(point);
    } catch (error, stackTrace) {
      developer.log(
        'Could not report current location.',
        name: 'zhu_app.locations',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
    } finally {
      _sending = false;
    }
  }

  void _handleLocationError(Object error, StackTrace stackTrace) {
    developer.log(
      'Could not receive current location.',
      name: 'zhu_app.locations',
      error: error.runtimeType,
      stackTrace: stackTrace,
    );
  }
}
