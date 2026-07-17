// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RelationshipUser _$RelationshipUserFromJson(Map<String, dynamic> json) =>
    _RelationshipUser(
      id: json['id'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location: json['location'] == null
          ? null
          : GuardeeLocation.fromJson(json['location'] as Map<String, dynamic>),
      safety: json['safety'] == null
          ? null
          : GuardeeSafety.fromJson(json['safety'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelationshipUserToJson(_RelationshipUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'safety': instance.safety,
    };

_RelationshipRequest _$RelationshipRequestFromJson(Map<String, dynamic> json) =>
    _RelationshipRequest(
      counterpart: RelationshipUser.fromJson(
        json['counterpart'] as Map<String, dynamic>,
      ),
      status: relationshipRequestStatusFromJson(json['status']),
      requestedByRole: requestedByRoleFromJson(json['requestedByRole']),
    );

Map<String, dynamic> _$RelationshipRequestToJson(
  _RelationshipRequest instance,
) => <String, dynamic>{
  'counterpart': instance.counterpart,
  'status': relationshipRequestStatusToJson(instance.status),
  'requestedByRole': requestedByRoleToJson(instance.requestedByRole),
};

_GuardeeDetail _$GuardeeDetailFromJson(Map<String, dynamic> json) =>
    _GuardeeDetail(
      guardee: RelationshipUser.fromJson(
        json['guardee'] as Map<String, dynamic>,
      ),
      location: json['location'] == null
          ? null
          : GuardeeLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GuardeeDetailToJson(_GuardeeDetail instance) =>
    <String, dynamic>{
      'guardee': instance.guardee,
      'location': instance.location,
    };

_GuardeeSafety _$GuardeeSafetyFromJson(Map<String, dynamic> json) =>
    _GuardeeSafety(
      status: guardeeSafetyStatusFromJson(json['status']),
      riskType: json['riskType'] as String?,
      riskLevel: json['riskLevel'] as String?,
      trigger: json['trigger'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GuardeeSafetyToJson(_GuardeeSafety instance) =>
    <String, dynamic>{
      'status': guardeeSafetyStatusToJson(instance.status),
      'riskType': instance.riskType,
      'riskLevel': instance.riskLevel,
      'trigger': instance.trigger,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_GuardeeLocation _$GuardeeLocationFromJson(Map<String, dynamic> json) =>
    _GuardeeLocation(
      latitude: coordinateFromJson(json['latitude']),
      longitude: coordinateFromJson(json['longitude']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GuardeeLocationToJson(_GuardeeLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
