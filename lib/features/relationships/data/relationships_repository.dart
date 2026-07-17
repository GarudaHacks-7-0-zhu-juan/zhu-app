import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';

part 'relationships_repository.g.dart';

@Riverpod(keepAlive: true)
RelationshipsRepository relationshipsRepository(Ref ref) {
  return RelationshipsRepository(ref.watch(authenticatedApiClientProvider));
}

class RelationshipsRepository {
  const RelationshipsRepository(this._client);

  final AuthenticatedApiClient _client;

  Future<RelationshipData> load(RelationshipKind kind) async {
    final results = await Future.wait([
      _client.getJsonList('/${kind.path}'),
      _client.getJsonList('/${kind.path}/requests'),
    ]);
    return RelationshipData(
      accepted: results[0].map(_userFromListItem).toList(growable: false),
      requests: results[1]
          .map(RelationshipRequest.fromJson)
          .toList(growable: false),
    );
  }

  Future<void> addRequest(RelationshipKind kind, String phoneNumber) async {
    await _client.postJsonResponse('/${kind.path}/requests', {
      'phoneNumber': phoneNumber,
    });
  }

  Future<void> updateRequest(
    RelationshipKind kind,
    String counterpartId, {
    required bool accepted,
  }) async {
    await _client.patchJson('/${kind.path}/requests/$counterpartId', {
      'status': accepted ? 'ACCEPTED' : 'DECLINED',
    });
  }

  Future<void> remove(RelationshipKind kind, String counterpartId) {
    return _client.delete('/${kind.path}/$counterpartId');
  }

  Future<GuardeeDetail> guardeeDetail(String guardeeId) async {
    final json = await _client.getJson('/guardees/$guardeeId');
    return GuardeeDetail.fromJson(json);
  }

  RelationshipUser _userFromListItem(Map<String, dynamic> json) {
    final user =
        json['counterpart'] ??
        json['guardian'] ??
        json['guardee'] ??
        json['user'] ??
        json;
    if (user is! Map<dynamic, dynamic>) {
      throw const FormatException('Relationship response has no user summary.');
    }
    final userJson = Map<String, dynamic>.from(user);
    return RelationshipUser.fromJson({
      ...userJson,
      'location': userJson['location'] ?? json['location'],
      'safety': _safetyFromResponse(json),
    });
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
}
