import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';

class AuthLoadingPage extends StatelessWidget {
  const AuthLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Semantics(
            label: 'Restoring your session',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('RESTORING SESSION', style: theme.textTheme.technical),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
