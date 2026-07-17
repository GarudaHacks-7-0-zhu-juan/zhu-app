import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/profile/controller/my_profile_controller.dart';
import 'package:zhu_app/features/profile/domain/user_profile.dart';
import 'package:zhu_app/features/safety/controller/protect_me_controller.dart';
import 'package:zhu_app/features/safety/domain/protect_me_status.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.onSignOut});

  final Future<void> Function() onSignOut;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _updating = <ProtectMeRiskType>{};
  var _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final profile = ref.watch(myProfileProvider);
    final statuses = ref.watch(protectMeControllerProvider);
    return SafeArea(
      child: ListView(
        padding: AppSpacing.screen.copyWith(
          top: AppSpacing.lg,
          bottom: AppSpacing.xxxl,
        ),
        children: [
          Text('ACCOUNT / SAFETY', style: theme.textTheme.technical),
          const SizedBox(height: AppSpacing.xs),
          Text('My Profile', style: theme.textTheme.h1),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Your account details and safety check-ins.',
            style: theme.textTheme.muted,
          ),
          const SizedBox(height: AppSpacing.xl),
          _ProtectMeCard(
            statuses: statuses,
            updating: _updating,
            onRetry: () => ref.invalidate(protectMeControllerProvider),
            onChanged: _setProtectMeEnabled,
          ),
          const SizedBox(height: AppSpacing.xl),
          switch (profile) {
            AsyncData(:final value) => _ProfileDetails(profile: value),
            AsyncError() => _ProfileError(
              onRetry: () => ref.invalidate(myProfileProvider),
            ),
            _ => const Center(child: CircularProgressIndicator()),
          },
          const SizedBox(height: AppSpacing.xxxl),
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
    );
  }

  Future<void> _setProtectMeEnabled(
    ProtectMeRiskType riskType,
    bool enabled,
  ) async {
    setState(() => _updating.add(riskType));
    try {
      await ref
          .read(protectMeControllerProvider.notifier)
          .setEnabled(riskType, enabled);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to update Protect Me. Try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _updating.remove(riskType));
    }
  }

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    await widget.onSignOut();
    if (mounted) setState(() => _isSigningOut = false);
  }
}

class _ProtectMeCard extends StatelessWidget {
  const _ProtectMeCard({
    required this.statuses,
    required this.updating,
    required this.onRetry,
    required this.onChanged,
  });

  final AsyncValue<List<ProtectMeStatus>> statuses;
  final Set<ProtectMeRiskType> updating;
  final VoidCallback onRetry;
  final Future<void> Function(ProtectMeRiskType riskType, bool enabled)
  onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      title: Row(
        children: [
          Expanded(child: Text('Protect Me', style: theme.textTheme.h4)),
          ShadBadge.outline(child: Text('1 MIN', style: theme.textTheme.label)),
        ],
      ),
      description: const Text(
        'Every active protection type sends its own check-in every minute.',
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: switch (statuses) {
          AsyncData(:final value) => Column(
            children: [
              for (final status in value) ...[
                _ProtectMeSwitch(
                  status: status,
                  updating: updating.contains(status.riskType),
                  onChanged: (enabled) => onChanged(status.riskType, enabled),
                ),
                if (status != value.last)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    child: ShadSeparator.horizontal(
                      color: ShadTheme.of(context).colorScheme.divider,
                    ),
                  ),
              ],
            ],
          ),
          AsyncError() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Protection settings are unavailable.',
                style: theme.textTheme.muted,
              ),
              const SizedBox(height: AppSpacing.md),
              ShadButton.outline(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _ProtectMeSwitch extends StatelessWidget {
  const _ProtectMeSwitch({
    required this.status,
    required this.updating,
    required this.onChanged,
  });

  final ProtectMeStatus status;
  final bool updating;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    return Semantics(
      label: 'Protect Me for ${status.riskType.label}',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            status.riskType == ProtectMeRiskType.highRiskArea
                ? Icons.location_searching_outlined
                : Icons.warning_amber_rounded,
            color: status.isEnabled ? colors.draftingBlue : colors.pencilGrey,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status.riskType.label, style: theme.textTheme.large),
                const SizedBox(height: AppSpacing.xs),
                Text(status.riskType.description, style: theme.textTheme.muted),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${status.modeLabel} / ${status.riskLevel}',
                  style: theme.textTheme.technical.copyWith(
                    color: status.isEnabled
                        ? colors.draftingBlue
                        : colors.pencilGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          updating
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : ShadSwitch(value: status.isEnabled, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(profile.name, style: theme.textTheme.h3),
          const SizedBox(height: AppSpacing.lg),
          _ProfileField(label: 'Email', value: profile.email),
          const SizedBox(height: AppSpacing.md),
          _ProfileField(label: 'Phone number', value: profile.phoneNumber),
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: theme.textTheme.technical),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: theme.textTheme.p),
      ],
    );
  }
}

class _ProfileError extends StatelessWidget {
  const _ProfileError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile unavailable', style: theme.textTheme.h4),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Check your connection and try again.',
            style: theme.textTheme.muted,
          ),
          const SizedBox(height: AppSpacing.md),
          ShadButton.outline(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
