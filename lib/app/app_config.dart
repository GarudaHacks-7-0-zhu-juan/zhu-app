import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class AppConfig {
  const AppConfig({required this.apiBaseUrl});

  final Uri apiBaseUrl;

  static Future<AppConfig> load() async {
    final source = await rootBundle.loadString('assets/config/app_config.yaml');
    final document = loadYaml(source);
    if (document is! YamlMap) {
      throw const AppConfigException('Configuration must be a YAML map.');
    }

    final api = document['api'];
    if (api is! YamlMap || api['base_url'] is! String) {
      throw const AppConfigException('Missing api.base_url configuration.');
    }

    final baseUrl = Uri.tryParse(api['base_url'] as String);
    if (baseUrl == null || !baseUrl.isAbsolute || baseUrl.scheme != 'https') {
      throw const AppConfigException(
        'api.base_url must be an absolute HTTPS URL.',
      );
    }
    if (!baseUrl.path.endsWith('/api')) {
      throw const AppConfigException('api.base_url must end with /api.');
    }

    return AppConfig(apiBaseUrl: baseUrl);
  }
}

class AppConfigException implements Exception {
  const AppConfigException(this.message);

  final String message;
}
