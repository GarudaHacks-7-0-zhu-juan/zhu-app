import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/relationships/controller/relationships_controller.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';

class GuardeeDetailPage extends ConsumerWidget {
  const GuardeeDetailPage({super.key, required this.guardee});

  final RelationshipUser guardee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(guardeeDetailProvider(guardee.id));

    return Scaffold(
      appBar: AppBar(title: const Text('Guardee details')),
      body: SafeArea(
        child: switch (detail) {
          AsyncData(:final value) => _DetailContent(detail: value),
          AsyncError() => Center(
            child: ShadButton.outline(
              onPressed: () =>
                  ref.invalidate(guardeeDetailProvider(guardee.id)),
              child: const Text('Retry'),
            ),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.detail});

  final GuardeeDetail detail;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final location = detail.location ?? detail.guardee.location;
    return ListView(
      padding: AppSpacing.screen.copyWith(
        top: AppSpacing.lg,
        bottom: AppSpacing.xxl,
      ),
      children: [
        Text('GUARDEE', style: theme.textTheme.technical),
        const SizedBox(height: AppSpacing.xs),
        Text(detail.guardee.email ?? 'Guardee', style: theme.textTheme.h1),
        const SizedBox(height: AppSpacing.xl),
        ShadCard(
          title: Text('Contact', style: theme.textTheme.h4),
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (detail.guardee.email != null) Text(detail.guardee.email!),
                if (detail.guardee.phoneNumber != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    detail.guardee.phoneNumber!,
                    style: theme.textTheme.muted,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ShadCard(
          title: Text('Last location', style: theme.textTheme.h4),
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child:
                location == null ||
                    location.latitude == null ||
                    location.longitude == null
                ? Text(
                    'No location has been shared yet.',
                    style: theme.textTheme.muted,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${location.latitude}, ${location.longitude}'),
                      if (location.updatedAt != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Updated ${location.updatedAt!.toLocal()}',
                          style: theme.textTheme.muted,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
