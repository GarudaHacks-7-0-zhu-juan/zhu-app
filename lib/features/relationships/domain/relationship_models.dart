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
    final embeddedLocation = guardee is Map<dynamic, dynamic>
        ? guardee['location']
        : null;
    return {...json, 'location': json['location'] ?? embeddedLocation};
  }
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
