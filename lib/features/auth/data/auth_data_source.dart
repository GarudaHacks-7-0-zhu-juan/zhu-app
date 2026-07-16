import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zhu_app/features/auth/data/auth_tokens.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';

class AuthDataSource {
  const AuthDataSource(this._dio);

  final Dio _dio;

  Future<AuthTokens> register({
    required String email,
    required String password,
    required String phoneNumber,
  }) {
    return _tokensRequest(
      '/auth/register',
      data: {'email': email, 'password': password, 'phoneNumber': phoneNumber},
      failureForStatus: (status) => status == 409
          ? const AuthFailure.accountAlreadyRegistered()
          : const AuthFailure.unexpected(),
    );
  }

  Future<AuthTokens> login({required String email, required String password}) {
    return _tokensRequest(
      '/auth/login',
      data: {'email': email, 'password': password},
      failureForStatus: (status) => status == 401
          ? const AuthFailure.invalidCredentials()
          : const AuthFailure.unexpected(),
    );
  }

  Future<AuthTokens> refresh(String refreshToken) {
    return _tokensRequest(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
      failureForStatus: (status) => status == 401
          ? const AuthFailure.unauthorizedSession()
          : const AuthFailure.unexpected(),
    );
  }

  Future<AuthTokens> _tokensRequest(
    String path, {
    required Map<String, String> data,
    required AuthFailure Function(int? status) failureForStatus,
  }) async {
    try {
      final response = await _dio.post<dynamic>(path, data: data);
      return AuthTokens.fromJson(_asJsonMap(response.data));
    } on DioException catch (error) {
      throw _failureFromDio(error, failureForStatus: failureForStatus);
    } on AuthFailure {
      rethrow;
    } catch (error, stackTrace) {
      _logUnexpected(path, error, stackTrace);
      throw const AuthFailure.unexpected();
    }
  }

  AuthFailure _failureFromDio(
    DioException error, {
    required AuthFailure Function(int? status) failureForStatus,
  }) {
    final failure = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const AuthFailure.timeout(),
      DioExceptionType.connectionError => const AuthFailure.network(),
      _ when error.response?.statusCode == 400 =>
        const AuthFailure.validation(),
      _ => failureForStatus(error.response?.statusCode),
    };
    if (kDebugMode) {
      developer.log(
        'Authentication request failed: ${error.type}, status '
        '${error.response?.statusCode}',
        name: 'zhu_app.auth',
      );
    }
    return failure;
  }

  Map<String, dynamic> _asJsonMap(Object? data) {
    if (data case final Map<dynamic, dynamic> map) {
      return Map<String, dynamic>.from(map);
    }
    throw const AuthFailure.unexpected();
  }

  void _logUnexpected(String operation, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      developer.log(
        'Authentication $operation failed unexpectedly.',
        name: 'zhu_app.auth',
        error: error.runtimeType,
        stackTrace: stackTrace,
      );
    }
  }
}
