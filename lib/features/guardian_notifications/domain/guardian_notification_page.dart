import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification.dart';

part 'guardian_notification_page.freezed.dart';

@freezed
abstract class GuardianNotificationPage with _$GuardianNotificationPage {
  const factory GuardianNotificationPage({
    required List<GuardianNotification> items,
    String? nextCursor,
    @Default(false) bool isLoadingMore,
  }) = _GuardianNotificationPage;
}
