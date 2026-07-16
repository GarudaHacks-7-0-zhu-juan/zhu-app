import 'package:dio/dio.dart';
import 'package:zhu_app/features/auth/data/auth_token_manager.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';

class AuthenticatedApiClient {
  AuthenticatedApiClient({
    required Dio dio,
    required AuthTokenManager tokenManager,
  }) : _dio = dio {
    _dio.interceptors.add(_AuthenticationInterceptor(_dio, tokenManager));
  }

  final Dio _dio;

  Future<Map<String, dynamic>> getJson(String path) async {
    final response = await _dio.get<dynamic>(path);
    return _asJsonMap(response.data);
  }

  Future<void> post(String path) async {
    await _dio.post<void>(path);
  }

  Future<void> postJson(String path, Map<String, Object> data) async {
    await _dio.post<void>(path, data: data);
  }

  Future<void> delete(String path) async {
    await _dio.delete<void>(path);
  }

  Map<String, dynamic> _asJsonMap(Object? data) {
    if (data case final Map<dynamic, dynamic> map) {
      return Map<String, dynamic>.from(map);
    }
    throw const AuthFailure.unexpected();
  }
}

class _AuthenticationInterceptor extends QueuedInterceptor {
  _AuthenticationInterceptor(this._dio, this._tokenManager);

  static const _retriedKey = 'auth_retried';

  final Dio _dio;
  final AuthTokenManager _tokenManager;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = _tokenManager.accessToken;
    if (accessToken == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const AuthFailure.unauthorizedSession(),
        ),
      );
    }
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final request = error.requestOptions;
    if (error.response?.statusCode != 401 ||
        request.extra[_retriedKey] == true) {
      return handler.next(error);
    }

    try {
      final accessToken = await _tokenManager.refreshAccessToken();
      request
        ..extra[_retriedKey] = true
        ..headers['Authorization'] = 'Bearer $accessToken';
      final response = await _dio.fetch<dynamic>(request);
      handler.resolve(response);
    } on AuthFailure catch (failure) {
      handler.reject(
        DioException(
          requestOptions: request,
          response: error.response,
          error: failure,
        ),
      );
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
