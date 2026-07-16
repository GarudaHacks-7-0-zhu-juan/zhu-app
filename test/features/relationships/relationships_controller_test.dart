import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';
import 'package:zhu_app/features/auth/data/auth_token_manager.dart';
import 'package:zhu_app/features/auth/data/auth_token_store.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/relationships/controller/relationships_controller.dart';
import 'package:zhu_app/features/relationships/data/relationships_repository.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';

void main() {
  test('adds guardian request then reloads relationship data', () async {
    final repository = _FakeRelationshipsRepository();
    final container = ProviderContainer(
      overrides: [
        relationshipsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(
      relationshipsControllerProvider(RelationshipKind.guardians).future,
    );

    await container
        .read(
          relationshipsControllerProvider(RelationshipKind.guardians).notifier,
        )
        .addRequest('+628123456789');

    expect(repository.requestedPhoneNumber, '+628123456789');
    expect(repository.loadCalls, 2);
  });

  test('parses counterpart aliases and embedded guardee location', () {
    final request = RelationshipRequest.fromJson({
      'guardian': {'id': 'guardian-1', 'email': 'guardian@example.com'},
      'initiatorRole': 'GUARDIAN',
      'status': 'PENDING',
    });
    final detail = GuardeeDetail.fromJson({
      'guardee': {
        'id': 'guardee-1',
        'email': 'guardee@example.com',
        'location': {'latitude': -6.2, 'longitude': 106.8},
      },
      'location': null,
    });

    expect(request.counterpart.id, 'guardian-1');
    expect(request.requestedByRole, RequestedByRole.guardian);
    expect(request.isPending, isTrue);
    expect(detail.guardee.location?.latitude, -6.2);
    expect(detail.location?.longitude, 106.8);
  });
}

class _FakeRelationshipsRepository extends RelationshipsRepository {
  _FakeRelationshipsRepository() : super(_unusedClient());

  String? requestedPhoneNumber;
  var loadCalls = 0;

  @override
  Future<RelationshipData> load(RelationshipKind kind) async {
    loadCalls++;
    return const RelationshipData(accepted: [], requests: []);
  }

  @override
  Future<void> addRequest(RelationshipKind kind, String phoneNumber) async {
    requestedPhoneNumber = phoneNumber;
  }
}

AuthenticatedApiClient _unusedClient() {
  final dio = Dio();
  return AuthenticatedApiClient(
    dio: dio,
    tokenManager: AuthTokenManager(
      dataSource: AuthDataSource(dio),
      store: AuthTokenStore(),
    ),
  );
}
