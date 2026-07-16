import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:zhu_app/features/auth/data/auth_data_source.dart';
import 'package:zhu_app/features/auth/data/auth_token_store.dart';
import 'package:zhu_app/features/auth/data/auth_tokens.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';

class AuthTokenManager {
  AuthTokenManager({
    required AuthDataSource dataSource,
    required AuthTokenStore store,
  }) : _dataSource = dataSource,
       _store = store;

  final AuthDataSource _dataSource;
  final AuthTokenStore _store;
  final StreamController<void> _sessionInvalidations =
      StreamController<void>.broadcast();

  String? _accessToken;
  Future<String>? _refreshing;

  Stream<void> get sessionInvalidations => _sessionInvalidations.stream;

  String? get accessToken => _accessToken;

  Future<void> accept(AuthTokens tokens) async {
    try {
      await _store.writeRefreshToken(tokens.refreshToken);
      _accessToken = tokens.accessToken;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        developer.log(
          'Could not persist refresh token.',
          name: 'zhu_app.auth',
          error: error.runtimeType,
          stackTrace: stackTrace,
        );
      }
      throw const AuthFailure.unexpected();
    }
  }

  Future<String?> restoreAccessToken() async {
    try {
      final refreshToken = await _store.readRefreshToken();
      if (refreshToken == null) return null;
      return refreshAccessToken();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        developer.log(
          'Could not read refresh token.',
          name: 'zhu_app.auth',
          error: error.runtimeType,
          stackTrace: stackTrace,
        );
      }
      throw const AuthFailure.unexpected();
    }
  }

  Future<String> refreshAccessToken() {
    return _refreshing ??= _refreshAccessToken().whenComplete(() {
      _refreshing = null;
    });
  }

  Future<void> clear({bool notify = false}) async {
    _accessToken = null;
    try {
      await _store.clear();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        developer.log(
          'Could not clear refresh token.',
          name: 'zhu_app.auth',
          error: error.runtimeType,
          stackTrace: stackTrace,
        );
      }
    }
    if (notify && !_sessionInvalidations.isClosed) {
      _sessionInvalidations.add(null);
    }
  }

  void dispose() {
    _sessionInvalidations.close();
  }

  Future<String> _refreshAccessToken() async {
    try {
      final refreshToken = await _store.readRefreshToken();
      if (refreshToken == null) {
        throw const AuthFailure.unauthorizedSession();
      }
      final tokens = await _dataSource.refresh(refreshToken);
      await accept(tokens);
      return tokens.accessToken;
    } on UnauthorizedSessionAuthFailure {
      await clear(notify: true);
      rethrow;
    } catch (error, stackTrace) {
      if (error is AuthFailure) rethrow;
      if (kDebugMode) {
        developer.log(
          'Refresh token operation failed unexpectedly.',
          name: 'zhu_app.auth',
          error: error.runtimeType,
          stackTrace: stackTrace,
        );
      }
      throw const AuthFailure.unexpected();
    }
  }
}
