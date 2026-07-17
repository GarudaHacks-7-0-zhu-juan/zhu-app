import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/guardian_notifications/controller/guardian_notifications_controller.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification_page.dart';

void main() {
  GuardianNotification notification({
    required String id,
    String? displayName,
    String? email,
  }) {
    return GuardianNotification(
      id: id,
      guardianId: 'guardian-id',
      guardeeId: 'guardee-id',
      riskType: GuardianNotificationRiskType.disaster,
      trigger: GuardianNotificationTrigger.negativeResponse,
      sentAt: DateTime.utc(2026, 1, 2),
      guardee: GuardianNotificationGuardee(
        id: 'guardee-id',
        displayName: displayName,
        email: email,
      ),
    );
  }

  test('parses guardian notification JSON and readable trigger copy', () {
    final item = GuardianNotification.fromJson({
      'id': 'notification-id',
      'guardianId': 'guardian-id',
      'guardeeId': 'guardee-id',
      'riskType': 'DISASTER',
      'trigger': 'LIVENESS_TIMEOUT',
      'responseEventId': null,
      'sentAt': '2026-01-02T03:04:05.000Z',
      'guardee': {
        'id': 'guardee-id',
        'displayName': null,
        'email': 'guardee@example.com',
      },
    });

    expect(item.triggerCopy, 'Did not respond to a safety check');
    expect(item.guardeeLabel, 'guardee@example.com');
  });

  test('uses display name, email, then unknown guardee as fallback', () {
    expect(
      notification(
        id: '1',
        displayName: 'Rani',
        email: 'rani@example.com',
      ).guardeeLabel,
      'Rani',
    );
    expect(
      notification(id: '2', email: 'rani@example.com').guardeeLabel,
      'rani@example.com',
    );
    expect(notification(id: '3').guardeeLabel, 'Unknown guardee');
  });

  test('merges cursor pages without duplicate notification items', () {
    final current = GuardianNotificationPage(
      items: [notification(id: 'one')],
      nextCursor: 'one',
    );
    final next = GuardianNotificationPage(
      items: [
        notification(id: 'one'),
        notification(id: 'two'),
      ],
      nextCursor: null,
    );

    final merged = mergeGuardianNotificationPages(current, next);

    expect(merged.items.map((item) => item.id), ['one', 'two']);
    expect(merged.nextCursor, isNull);
  });
}
