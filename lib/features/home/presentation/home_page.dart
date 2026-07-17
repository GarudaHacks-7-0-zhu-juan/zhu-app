import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/relationships/controller/relationships_controller.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/safety/controller/protect_me_controller.dart';
import 'package:zhu_app/features/safety/data/safety_repository.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var _submittingFall = false;

  @override
  Widget build(BuildContext context) {
    final protection = ref.watch(protectMeControllerProvider);
    final guardians = ref.watch(
      relationshipsControllerProvider(RelationshipKind.guardians),
    );

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppSpacing.screen.copyWith(
            top: AppSpacing.lg,
            bottom: AppSpacing.xxxl,
          ),
          children: [
            const _Header(),
            const SizedBox(height: AppSpacing.xl),
            _ProtectionHero(protection: protection),
            const SizedBox(height: AppSpacing.xl),
            _StatusGrid(protection: protection, guardians: guardians),
            const SizedBox(height: AppSpacing.xl),
            _ActionStrip(
              onGuardians: () => context.go('/guardians'),
              onSettings: () => context.go('/profile'),
            ),
            const SizedBox(height: AppSpacing.xxl),
            _DemoFallCard(
              submitting: _submittingFall,
              onReport: _confirmAndReportFall,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    ref.invalidate(protectMeControllerProvider);
    await Future.wait([
      ref.read(protectMeControllerProvider.future),
      ref
          .read(
            relationshipsControllerProvider(
              RelationshipKind.guardians,
            ).notifier,
          )
          .refresh(),
    ]);
  }

  Future<void> _confirmAndReportFall() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Simulate fall detection?'),
        content: const Text(
          'This demo submits a fall event to Zhu. The backend processes it asynchronously.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Submit event'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _submittingFall = true);
    try {
      await ref.read(safetyRepositoryProvider).reportFall();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fall event submitted for processing.')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to submit fall event. Try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _submittingFall = false);
    }
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ZHU / SAFETY NETWORK', style: theme.textTheme.technical),
        const SizedBox(height: AppSpacing.xs),
        Text('Your safety, in view.', style: theme.textTheme.h1),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Location monitoring stays active while you are signed in.',
          style: theme.textTheme.muted,
        ),
      ],
    );
  }
}

class _ProtectionHero extends StatelessWidget {
  const _ProtectionHero({required this.protection});

  final AsyncValue<List<ProtectMeStatus>> protection;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    final statuses = switch (protection) {
      AsyncData(:final value) => value,
      _ => const <ProtectMeStatus>[],
    };
    final enabledCount = statuses.where((status) => status.isEnabled).length;
    final statusLabel = switch (protection) {
      AsyncLoading() => 'SYNCING',
      AsyncError() => 'UNAVAILABLE',
      _ when enabledCount == 0 => 'STANDBY',
      _ => 'PROTECTED',
    };

    return Semantics(
      label: 'Protection status: $statusLabel',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          border: Border.all(color: colors.draftingBlue.withValues(alpha: .35)),
          borderRadius: const BorderRadius.all(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              const SizedBox(width: 116, height: 116, child: _SafetyBeacon()),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PROTECTION STATUS', style: theme.textTheme.technical),
                    const SizedBox(height: AppSpacing.xs),
                    Text(statusLabel, style: theme.textTheme.h2),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      protection.isLoading
                          ? 'Checking your safety settings.'
                          : enabledCount == 0
                          ? 'No recurring check-ins are active.'
                          : '$enabledCount active ${enabledCount == 1 ? 'check-in' : 'check-ins'} every minute.',
                      style: theme.textTheme.small.copyWith(
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusGrid extends StatelessWidget {
  const _StatusGrid({required this.protection, required this.guardians});

  final AsyncValue<List<ProtectMeStatus>> protection;
  final AsyncValue<dynamic> guardians;

  @override
  Widget build(BuildContext context) {
    final activeProtection = switch (protection) {
      AsyncData(:final value) =>
        value.where((status) => status.isEnabled).length,
      _ => null,
    };
    final guardianCount = switch (guardians) {
      AsyncData(:final value) => value.accepted.length,
      _ => null,
    };
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        final cards = [
          _StatusCard(
            icon: Icons.my_location_outlined,
            label: 'LOCATION',
            value: 'ACTIVE',
            detail: 'Updates every 20 seconds',
            color: ShadTheme.of(context).colorScheme.draftingBlue,
          ),
          _StatusCard(
            icon: Icons.shield_outlined,
            label: 'CHECK-INS',
            value: activeProtection == null
                ? '...'
                : '$activeProtection ACTIVE',
            detail: 'Independent protection types',
            color: activeProtection == 0
                ? ShadTheme.of(context).colorScheme.pencilGrey
                : ShadTheme.of(context).colorScheme.success,
          ),
          _StatusCard(
            icon: Icons.people_outline,
            label: 'GUARDIANS',
            value: guardianCount == null ? '...' : '$guardianCount LINKED',
            detail: 'People in your safety network',
            color: guardianCount == 0
                ? ShadTheme.of(context).colorScheme.warning
                : ShadTheme.of(context).colorScheme.draftingBlue,
          ),
        ];
        return isNarrow
            ? Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    if (card != cards.last)
                      const SizedBox(height: AppSpacing.sm),
                  ],
                ],
              )
            : Row(
                children: [
                  for (final card in cards) ...[
                    Expanded(child: card),
                    if (card != cards.last)
                      const SizedBox(width: AppSpacing.sm),
                  ],
                ],
              );
      },
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: AppSpacing.md),
          Text(label, style: theme.textTheme.technical),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: theme.textTheme.large),
          const SizedBox(height: AppSpacing.xs),
          Text(detail, style: theme.textTheme.muted),
        ],
      ),
    );
  }
}

class _ActionStrip extends StatelessWidget {
  const _ActionStrip({required this.onGuardians, required this.onSettings});

  final VoidCallback onGuardians;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        ShadButton.outline(
          onPressed: onGuardians,
          child: const Text('Manage guardians'),
        ),
        ShadButton.outline(
          onPressed: onSettings,
          child: const Text('Protect Me settings'),
        ),
      ],
    );
  }
}

class _DemoFallCard extends StatelessWidget {
  const _DemoFallCard({required this.submitting, required this.onReport});

  final bool submitting;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        border: Border.all(color: colors.destructive.withValues(alpha: .32)),
        borderRadius: const BorderRadius.all(AppRadius.large),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DEMO / ACCIDENT DETECTION', style: theme.textTheme.technical),
            const SizedBox(height: AppSpacing.xs),
            Text('Simulate a fall', style: theme.textTheme.h3),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Temporary demo control. It records a fall event; backend processing and alerts happen separately.',
              style: theme.textTheme.muted,
            ),
            const SizedBox(height: AppSpacing.md),
            ShadButton.destructive(
              onPressed: submitting ? null : onReport,
              child: submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Simulate fall detection'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyBeacon extends StatelessWidget {
  const _SafetyBeacon();

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return CustomPaint(
      painter: _SafetyBeaconPainter(
        lineColor: colors.draftingBlue.withValues(alpha: .42),
        coreColor: colors.draftingBlue,
      ),
    );
  }
}

class _SafetyBeaconPainter extends CustomPainter {
  const _SafetyBeaconPainter({
    required this.lineColor,
    required this.coreColor,
  });

  final Color lineColor;
  final Color coreColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final line = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.25;
    for (final factor in [0.2, 0.42, 0.68]) {
      canvas.drawCircle(center, size.width * factor, line);
    }
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), line);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), line);
    canvas.drawCircle(center, 9, Paint()..color = coreColor);
    canvas.drawCircle(center, 18, line);
  }

  @override
  bool shouldRepaint(covariant _SafetyBeaconPainter oldDelegate) {
    return lineColor != oldDelegate.lineColor ||
        coreColor != oldDelegate.coreColor;
  }
}
