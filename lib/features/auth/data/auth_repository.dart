import 'package:dio/dio.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';
import 'package:zhu_app/features/auth/data/auth_token_manager.dart';
import 'package:zhu_app/features/auth/data/auth_tokens.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';
import 'package:zhu_app/features/auth/domain/auth_user.dart';

class AuthRepository {
  const AuthRepository({
    required AuthDataSource dataSource,
    required AuthTokenManager tokenManager,
    required AuthenticatedApiClient authenticatedApiClient,
  }) : _dataSource = dataSource,
       _tokenManager = tokenManager,
       _authenticatedApiClient = authenticatedApiClient;

  final AuthDataSource _dataSource;
  final AuthTokenManager _tokenManager;
  final AuthenticatedApiClient _authenticatedApiClient;

  Future<AuthUser> register({
    required String email,
    required String password,
    required String phoneNumber,
    String? displayName,
  }) async {
    final tokens = await _dataSource.register(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      displayName: displayName,
    );
    return _completeAuthentication(tokens);
  }

  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    final tokens = await _dataSource.login(email: email, password: password);
    return _completeAuthentication(tokens);
  }

  Future<AuthUser?> restoreSession() async {
    final accessToken = await _tokenManager.restoreAccessToken();
    if (accessToken == null) return null;
    return _getCurrentUser();
  }

  Future<void> signOut() async {
    try {
      if (_tokenManager.accessToken != null) {
        await _authenticatedApiClient.post('/auth/logout');
      }
    } catch (_) {
      // Local sign-out must complete even when the network is unavailable.
    } finally {
      await _tokenManager.clear();
    }
  }

  Future<void> clearSession() => _tokenManager.clear();

  Future<AuthUser> _completeAuthentication(AuthTokens tokens) async {
    await _tokenManager.accept(tokens);
    try {
      return await _getCurrentUser();
    } on AuthFailure {
      await _tokenManager.clear();
      rethrow;
    }
  }

  Future<AuthUser> _getCurrentUser() async {
    try {
      final json = await _authenticatedApiClient.getJson('/auth/me');
      return AuthUser.fromJson(json);
    } on DioException catch (error) {
      final failure = error.error;
      if (failure is AuthFailure) {
        if (failure is UnauthorizedSessionAuthFailure) {
          await _tokenManager.clear(notify: true);
        }
        throw failure;
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const AuthFailure.timeout();
      }
      if (error.type == DioExceptionType.connectionError) {
        throw const AuthFailure.network();
      }
      if (error.response?.statusCode == 401) {
        await _tokenManager.clear(notify: true);
        throw const AuthFailure.unauthorizedSession();
      }
      throw const AuthFailure.unexpected();
    }
  }
}
