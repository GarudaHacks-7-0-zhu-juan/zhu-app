import 'package:freezed_annotation/freezed_annotation.dart';

part 'guardian_notification.freezed.dart';
part 'guardian_notification.g.dart';

@freezed
abstract class GuardianNotification with _$GuardianNotification {
  const GuardianNotification._();

  const factory GuardianNotification({
    required String id,
    required String guardianId,
    required String guardeeId,
    required GuardianNotificationRiskType riskType,
    required GuardianNotificationTrigger trigger,
    String? responseEventId,
    required DateTime sentAt,
    required GuardianNotificationGuardee guardee,
  }) = _GuardianNotification;

  factory GuardianNotification.fromJson(Map<String, dynamic> json) =>
      _$GuardianNotificationFromJson(json);

  String get guardeeLabel => guardee.displayName?.trim().isNotEmpty == true
      ? guardee.displayName!
      : guardee.email?.trim().isNotEmpty == true
      ? guardee.email!
      : 'Unknown guardee';

  String get triggerCopy => switch (trigger) {
    GuardianNotificationTrigger.negativeResponse =>
      'Responded that they are not safe',
    GuardianNotificationTrigger.livenessTimeout =>
      'Did not respond to a safety check',
    GuardianNotificationTrigger.fallDetected => 'A fall was detected',
  };
}

@freezed
abstract class GuardianNotificationGuardee with _$GuardianNotificationGuardee {
  const factory GuardianNotificationGuardee({
    required String id,
    String? displayName,
    String? email,
  }) = _GuardianNotificationGuardee;

  factory GuardianNotificationGuardee.fromJson(Map<String, dynamic> json) =>
      _$GuardianNotificationGuardeeFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum GuardianNotificationRiskType { disaster, highRiskArea, accident }

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum GuardianNotificationTrigger {
  negativeResponse,
  livenessTimeout,
  fallDetected,
}
