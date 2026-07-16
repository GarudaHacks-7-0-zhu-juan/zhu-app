import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/notifications/data/firebase_notification_clients.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('test/firebase_installations');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('reads installation ID through the Android channel', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'getId');
      return 'test-fid';
    });
    final source = AndroidFirebaseInstallationIdSource(channel);

    await expectLater(source.getId(), completion('test-fid'));
  });

  test('deletes installation through the Android channel', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'delete');
      return null;
    });
    final source = AndroidFirebaseInstallationIdSource(channel);

    await source.delete();
  });

  test('rejects a missing installation ID', () async {
    messenger.setMockMethodCallHandler(channel, (_) async => null);
    final source = AndroidFirebaseInstallationIdSource(channel);

    await expectLater(source.getId(), throwsStateError);
  });
}
