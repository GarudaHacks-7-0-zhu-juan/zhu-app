import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.email, required this.onSignOut});

  final String email;
  final Future<void> Function() onSignOut;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return SafeArea(
      child: Padding(
        padding: AppSpacing.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ACCOUNT', style: theme.textTheme.technical),
            const SizedBox(height: AppSpacing.md),
            Text('Profile', style: theme.textTheme.h1),
            const SizedBox(height: AppSpacing.xxl),
            ShadCard(
              title: Text('Signed in as', style: theme.textTheme.h4),
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(widget.email, style: theme.textTheme.p),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ShadButton.outline(
                onPressed: _isSigningOut ? null : _signOut,
                child: _isSigningOut
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Sign out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    await widget.onSignOut();
    if (mounted) setState(() => _isSigningOut = false);
  }
}
