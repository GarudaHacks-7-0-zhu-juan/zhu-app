import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zhu_app/app/app_config.dart';
import 'package:zhu_app/app/app_config_provider.dart';
import 'package:zhu_app/app/config_error_app.dart';
import 'package:zhu_app/app/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final config = await AppConfig.load();
    runApp(
      ProviderScope(
        overrides: [appConfigProvider.overrideWithValue(config)],
        child: const MainApp(),
      ),
    );
  } catch (error) {
    runApp(ConfigErrorApp(error: error));
  }
}
