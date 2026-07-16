import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: AppSpacing.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CONTACTS', style: theme.textTheme.technical),
            const SizedBox(height: AppSpacing.md),
            Text('Contacts', style: theme.textTheme.h1),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'People and collaborators will appear here.',
              style: theme.textTheme.muted,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ShadCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.people_outline, color: colors.pencilGrey),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No contacts yet', style: theme.textTheme.large),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Your contact list is empty.',
                          style: theme.textTheme.muted,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
