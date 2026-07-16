import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logarte/logarte.dart';
import 'package:zhu_app/app/app_config.dart';
import 'package:zhu_app/core/diagnostics/app_logarte.dart';

Dio createApiDio(AppConfig config) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl.toString(),
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(LogarteDioInterceptor(appLogarte));
  }
  return dio;
}
