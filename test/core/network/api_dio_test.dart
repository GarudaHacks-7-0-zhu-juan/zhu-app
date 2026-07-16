import 'package:flutter_test/flutter_test.dart';
import 'package:logarte/logarte.dart';
import 'package:zhu_app/app/app_config.dart';
import 'package:zhu_app/core/network/api_dio.dart';

void main() {
  test('adds Logarte request capture in debug builds', () {
    final dio = createApiDio(
      AppConfig(apiBaseUrl: Uri.parse('https://example.com/api')),
    );
    addTearDown(dio.close);

    expect(dio.interceptors.whereType<LogarteDioInterceptor>(), hasLength(1));
  });
}
