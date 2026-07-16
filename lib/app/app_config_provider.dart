import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/app/app_config.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError('AppConfig must be provided during bootstrap.');
});
