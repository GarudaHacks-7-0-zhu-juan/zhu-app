import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';

class ConfigErrorApp extends StatelessWidget {
  const ConfigErrorApp({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final detail = kDebugMode ? error.toString() : 'Please try again later.';
    return ShadApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppShadTheme.light,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: AppSpacing.screen,
              child: ShadCard(
                title: const Text('App unavailable'),
                description: const Text(
                  'Required application services could not be initialized.',
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Text(detail),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
