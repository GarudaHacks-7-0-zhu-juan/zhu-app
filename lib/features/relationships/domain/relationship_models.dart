import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';

part 'relationship_models.freezed.dart';
part 'relationship_models.g.dart';

@freezed
abstract class RelationshipUser with _$RelationshipUser {
  const factory RelationshipUser({
    required String id,
    String? email,
    String? phoneNumber,
    GuardeeLocation? location,
    GuardeeSafety? safety,
  }) = _RelationshipUser;

  factory RelationshipUser.fromJson(Map<String, dynamic> json) =>
      _$RelationshipUserFromJson(json);
}

@freezed
abstract class RelationshipRequest with _$RelationshipRequest {
  const RelationshipRequest._();

  const factory RelationshipRequest({
    required RelationshipUser counterpart,
    @JsonKey(
      fromJson: relationshipRequestStatusFromJson,
      toJson: relationshipRequestStatusToJson,
    )
    required RelationshipRequestStatus status,
    @JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson)
    required RequestedByRole requestedByRole,
  }) = _RelationshipRequest;

  factory RelationshipRequest.fromJson(Map<String, dynamic> json) =>
      _$RelationshipRequestFromJson(_withCounterpart(json));

  bool get isPending => status == RelationshipRequestStatus.pending;
  bool get isDeclined => status == RelationshipRequestStatus.declined;

  static Map<String, dynamic> _withCounterpart(Map<String, dynamic> json) {
    final counterpart =
        json['counterpart'] ??
        json['guardian'] ??
        json['guardee'] ??
        json['user'];
    return {
      ...json,
      'counterpart': counterpart,
      'requestedByRole': json['requestedByRole'] ?? json['initiatorRole'],
    };
  }
}

enum RelationshipRequestStatus { pending, accepted, declined }

RelationshipRequestStatus relationshipRequestStatusFromJson(Object? value) {
  return switch (value) {
    'PENDING' => RelationshipRequestStatus.pending,
    'ACCEPTED' => RelationshipRequestStatus.accepted,
    'DECLINED' => RelationshipRequestStatus.declined,
    _ => throw FormatException('Unknown relationship status: $value'),
  };
}

String relationshipRequestStatusToJson(RelationshipRequestStatus value) {
  return switch (value) {
    RelationshipRequestStatus.pending => 'PENDING',
    RelationshipRequestStatus.accepted => 'ACCEPTED',
    RelationshipRequestStatus.declined => 'DECLINED',
  };
}

RequestedByRole requestedByRoleFromJson(Object? value) {
  return switch (value) {
    'GUARDIAN' => RequestedByRole.guardian,
    'GUARDEE' => RequestedByRole.guardee,
    _ => throw FormatException('Unknown requester role: $value'),
  };
}

String requestedByRoleToJson(RequestedByRole value) {
  return switch (value) {
    RequestedByRole.guardian => 'GUARDIAN',
    RequestedByRole.guardee => 'GUARDEE',
  };
}

@freezed
abstract class RelationshipData with _$RelationshipData {
  const factory RelationshipData({
    required List<RelationshipUser> accepted,
    required List<RelationshipRequest> requests,
  }) = _RelationshipData;
}

@freezed
abstract class GuardeeDetail with _$GuardeeDetail {
  const factory GuardeeDetail({
    required RelationshipUser guardee,
    GuardeeLocation? location,
  }) = _GuardeeDetail;

  factory GuardeeDetail.fromJson(Map<String, dynamic> json) =>
      _$GuardeeDetailFromJson(_withEmbeddedLocation(json));

  static Map<String, dynamic> _withEmbeddedLocation(Map<String, dynamic> json) {
    final guardee = json['guardee'];
    if (guardee is! Map<dynamic, dynamic>) return json;
    final guardeeJson = Map<String, dynamic>.from(guardee);
    return {
      ...json,
      'guardee': {
        ...guardeeJson,
        'location': json['location'] ?? guardeeJson['location'],
        'safety': _safetyFromResponse(json),
      },
      'location': json['location'] ?? guardeeJson['location'],
    };
  }
}

enum GuardeeSafetyStatus { needsHelp, checkInOverdue, atRisk, protected, ok }

GuardeeSafetyStatus guardeeSafetyStatusFromJson(Object? value) {
  return switch (value) {
    'NEEDS_HELP' => GuardeeSafetyStatus.needsHelp,
    'CHECK_IN_OVERDUE' => GuardeeSafetyStatus.checkInOverdue,
    'AT_RISK' => GuardeeSafetyStatus.atRisk,
    'PROTECTED' => GuardeeSafetyStatus.protected,
    'OK' => GuardeeSafetyStatus.ok,
    _ => throw FormatException('Unknown guardee safety status: $value'),
  };
}

String guardeeSafetyStatusToJson(GuardeeSafetyStatus value) {
  return switch (value) {
    GuardeeSafetyStatus.needsHelp => 'NEEDS_HELP',
    GuardeeSafetyStatus.checkInOverdue => 'CHECK_IN_OVERDUE',
    GuardeeSafetyStatus.atRisk => 'AT_RISK',
    GuardeeSafetyStatus.protected => 'PROTECTED',
    GuardeeSafetyStatus.ok => 'OK',
  };
}

@freezed
abstract class GuardeeSafety with _$GuardeeSafety {
  const factory GuardeeSafety({
    @JsonKey(
      fromJson: guardeeSafetyStatusFromJson,
      toJson: guardeeSafetyStatusToJson,
    )
    required GuardeeSafetyStatus status,
    String? riskType,
    String? riskLevel,
    String? trigger,
    DateTime? updatedAt,
  }) = _GuardeeSafety;

  factory GuardeeSafety.fromJson(Map<String, dynamic> json) =>
      _$GuardeeSafetyFromJson(json);
}

@freezed
abstract class GuardeeLocation with _$GuardeeLocation {
  const factory GuardeeLocation({
    @JsonKey(fromJson: coordinateFromJson) double? latitude,
    @JsonKey(fromJson: coordinateFromJson) double? longitude,
    DateTime? updatedAt,
  }) = _GuardeeLocation;

  factory GuardeeLocation.fromJson(Map<String, dynamic> json) =>
      _$GuardeeLocationFromJson(json);
}

double? coordinateFromJson(Object? value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) {
    final coordinate = double.tryParse(value);
    if (coordinate != null) return coordinate;
  }
  throw FormatException('Invalid coordinate: $value');
}

Map<String, dynamic>? _safetyFromResponse(Map<String, dynamic> json) {
  final status = json['safetyStatus'];
  if (status is! String) return null;
  return {
    'status': status,
    'riskType': json['riskType'],
    'riskLevel': json['riskLevel'],
    'trigger': json['trigger'],
    'updatedAt': json['updatedAt'],
  };
}
