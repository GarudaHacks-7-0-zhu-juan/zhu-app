// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GuardianNotification _$GuardianNotificationFromJson(
  Map<String, dynamic> json,
) => _GuardianNotification(
  id: json['id'] as String,
  guardianId: json['guardianId'] as String,
  guardeeId: json['guardeeId'] as String,
  riskType: $enumDecode(
    _$GuardianNotificationRiskTypeEnumMap,
    json['riskType'],
  ),
  trigger: $enumDecode(_$GuardianNotificationTriggerEnumMap, json['trigger']),
  responseEventId: json['responseEventId'] as String?,
  sentAt: DateTime.parse(json['sentAt'] as String),
  guardee: GuardianNotificationGuardee.fromJson(
    json['guardee'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GuardianNotificationToJson(
  _GuardianNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'guardianId': instance.guardianId,
  'guardeeId': instance.guardeeId,
  'riskType': _$GuardianNotificationRiskTypeEnumMap[instance.riskType]!,
  'trigger': _$GuardianNotificationTriggerEnumMap[instance.trigger]!,
  'responseEventId': instance.responseEventId,
  'sentAt': instance.sentAt.toIso8601String(),
  'guardee': instance.guardee,
};

const _$GuardianNotificationRiskTypeEnumMap = {
  GuardianNotificationRiskType.disaster: 'DISASTER',
  GuardianNotificationRiskType.highRiskArea: 'HIGH_RISK_AREA',
  GuardianNotificationRiskType.accident: 'ACCIDENT',
};

const _$GuardianNotificationTriggerEnumMap = {
  GuardianNotificationTrigger.negativeResponse: 'NEGATIVE_RESPONSE',
  GuardianNotificationTrigger.livenessTimeout: 'LIVENESS_TIMEOUT',
  GuardianNotificationTrigger.fallDetected: 'FALL_DETECTED',
};

_GuardianNotificationGuardee _$GuardianNotificationGuardeeFromJson(
  Map<String, dynamic> json,
) => _GuardianNotificationGuardee(
  id: json['id'] as String,
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$GuardianNotificationGuardeeToJson(
  _GuardianNotificationGuardee instance,
) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'email': instance.email,
};
