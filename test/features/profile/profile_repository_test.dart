import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';
import 'package:zhu_app/features/auth/data/auth_token_manager.dart';
import 'package:zhu_app/features/auth/data/auth_token_store.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/profile/data/profile_repository.dart';

void main() {
  test(
    'loads the current user from the authenticated profile endpoint',
    () async {
      final client = _FakeAuthenticatedApiClient();

      final profile = await ProfileRepository(client).load();

      expect(client.requestedPath, '/users/me');
      expect(profile.email, 'person@example.com');
    },
  );

  test('propagates API errors for the profile UI to handle', () async {
    final client = _FakeAuthenticatedApiClient()..error = Exception('offline');

    expect(ProfileRepository(client).load(), throwsA(isA<Exception>()));
  });
}

class _FakeAuthenticatedApiClient extends AuthenticatedApiClient {
  _FakeAuthenticatedApiClient()
    : super(
        dio: Dio(),
        tokenManager: AuthTokenManager(
          dataSource: AuthDataSource(Dio()),
          store: AuthTokenStore(),
        ),
      );

  String? requestedPath;
  Object? error;

  @override
  Future<Map<String, dynamic>> getJson(String path) async {
    requestedPath = path;
    if (error != null) throw error!;
    return {
      'id': 'user-id',
      'displayName': 'Person',
      'email': 'person@example.com',
      'phoneNumber': '+628123456789',
      'createdAt': '2026-01-02T03:04:05.000Z',
      'updatedAt': '2026-02-03T04:05:06.000Z',
    };
  }
}
