import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/relationships/controller/relationships_controller.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';

class GuardeeDetailPage extends ConsumerWidget {
  const GuardeeDetailPage({super.key, required this.guardeeId});

  final String guardeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(guardeeDetailProvider(guardeeId));

    return Scaffold(
      appBar: AppBar(title: const Text('Guardee details')),
      body: SafeArea(
        child: switch (detail) {
          AsyncData(:final value) => _DetailContent(
            detail: value,
            onRefresh: () async {
              ref.invalidate(guardeeDetailProvider(guardeeId));
              await ref.read(guardeeDetailProvider(guardeeId).future);
            },
          ),
          AsyncError() => Center(
            child: Padding(
              padding: AppSpacing.screen,
              child: ShadCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guardee unavailable',
                      style: ShadTheme.of(context).textTheme.h3,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'This relationship may no longer be available. Check your connection and try again.',
                      style: ShadTheme.of(context).textTheme.muted,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ShadButton.outline(
                      onPressed: () =>
                          ref.invalidate(guardeeDetailProvider(guardeeId)),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.detail, required this.onRefresh});

  final GuardeeDetail detail;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final guardee = detail.guardee;
    final location = detail.location ?? guardee.location;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: AppSpacing.screen.copyWith(
          top: AppSpacing.lg,
          bottom: AppSpacing.xxl,
        ),
        children: [
          Text('GUARDEE', style: theme.textTheme.technical),
          const SizedBox(height: AppSpacing.xs),
          Text(_displayName(guardee), style: theme.textTheme.h1),
          const SizedBox(height: AppSpacing.xl),
          _SafetyBanner(safety: guardee.safety),
          const SizedBox(height: AppSpacing.md),
          _LocationCard(location: location),
          const SizedBox(height: AppSpacing.md),
          _ContactCard(guardee: guardee),
        ],
      ),
    );
  }
}

class _SafetyBanner extends StatelessWidget {
  const _SafetyBanner({required this.safety});

  final GuardeeSafety? safety;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final status = safety?.status ?? GuardeeSafetyStatus.ok;
    final presentation = _SafetyPresentation.from(status, theme);
    final detail = safety == null
        ? 'Safety status has not been reported yet.'
        : _safetyDetail(safety!);
    return Semantics(
      label: 'Safety status: ${presentation.label}. $detail',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: presentation.background,
          border: Border.all(
            color: presentation.foreground.withValues(alpha: .45),
          ),
          borderRadius: const BorderRadius.all(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(presentation.icon, color: presentation.foreground, size: 28),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SAFETY STATUS', style: theme.textTheme.technical),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      presentation.label,
                      style: theme.textTheme.h3.copyWith(
                        color: presentation.foreground,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(detail, style: theme.textTheme.small),
                    if (safety?.updatedAt != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Updated ${_relativeTime(safety!.updatedAt!)}',
                        style: theme.textTheme.muted,
                      ),
                    ],
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

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.location});

  final GuardeeLocation? location;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final point = _mapPoint(location);
    return ShadCard(
      title: Text('Last location', style: theme.textTheme.h4),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: point == null
            ? Text(
                location == null
                    ? 'No location has been shared yet.'
                    : 'Location data is unavailable.',
                style: theme.textTheme.muted,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(AppRadius.medium),
                    child: SizedBox(
                      height: 240,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: point,
                          initialZoom: 15,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.zhujuan.zhu_app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: point,
                                width: 48,
                                height: 48,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: AppColors.error,
                                  size: 48,
                                  semanticLabel: 'Guardee last known location',
                                ),
                              ),
                            ],
                          ),
                          RichAttributionWidget(
                            attributions: const [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (location?.updatedAt != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Last updated ${_relativeTime(location!.updatedAt!)}',
                      style: theme.textTheme.muted,
                    ),
                    if (_isStale(location!.updatedAt!)) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Location may be stale. Ask your guardee to open Zhu.',
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.warning,
                        ),
                      ),
                    ],
                  ],
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${location!.latitude!.toStringAsFixed(5)}, '
                    '${location!.longitude!.toStringAsFixed(5)}',
                    style: theme.textTheme.technical,
                  ),
                ],
              ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.guardee});

  final RelationshipUser guardee;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      title: Text('Contact', style: theme.textTheme.h4),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (guardee.email != null) Text(guardee.email!),
            if (guardee.phoneNumber != null) ...[
              if (guardee.email != null) const SizedBox(height: AppSpacing.xs),
              Text(guardee.phoneNumber!, style: theme.textTheme.muted),
            ],
          ],
        ),
      ),
    );
  }
}

class _SafetyPresentation {
  const _SafetyPresentation({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;

  factory _SafetyPresentation.from(
    GuardeeSafetyStatus status,
    ShadThemeData theme,
  ) {
    return switch (status) {
      GuardeeSafetyStatus.needsHelp => const _SafetyPresentation(
        label: 'NEEDS HELP',
        icon: Icons.warning_amber_rounded,
        background: AppColors.errorContainer,
        foreground: AppColors.error,
      ),
      GuardeeSafetyStatus.checkInOverdue => _SafetyPresentation(
        label: 'CHECK-IN OVERDUE',
        icon: Icons.timer_outlined,
        background: theme.colorScheme.warning.withValues(alpha: .12),
        foreground: theme.colorScheme.warning,
      ),
      GuardeeSafetyStatus.atRisk => _SafetyPresentation(
        label: 'AT RISK',
        icon: Icons.shield_outlined,
        background: theme.colorScheme.warning.withValues(alpha: .12),
        foreground: theme.colorScheme.warning,
      ),
      GuardeeSafetyStatus.protected => _SafetyPresentation(
        label: 'PROTECTED',
        icon: Icons.verified_user_outlined,
        background: theme.colorScheme.success.withValues(alpha: .12),
        foreground: theme.colorScheme.success,
      ),
      GuardeeSafetyStatus.ok => _SafetyPresentation(
        label: 'OK',
        icon: Icons.check_circle_outline,
        background: theme.colorScheme.primaryContainer,
        foreground: theme.colorScheme.draftingBlue,
      ),
    };
  }
}

String _displayName(RelationshipUser user) {
  return user.displayName ??
      user.email ??
      user.phoneNumber ??
      'Unknown guardee';
}

String _safetyDetail(GuardeeSafety safety) {
  return switch (safety.status) {
    GuardeeSafetyStatus.needsHelp =>
      safety.trigger == 'FALL_DETECTED'
          ? 'A fall was detected. Check on them now.'
          : 'They reported that they are not safe.',
    GuardeeSafetyStatus.checkInOverdue =>
      'They have not answered a safety check-in.',
    GuardeeSafetyStatus.atRisk =>
      'Current risk level: ${safety.riskLevel ?? 'unknown'}.',
    GuardeeSafetyStatus.protected => 'Recurring safety check-ins are active.',
    GuardeeSafetyStatus.ok => 'No current safety concern is reported.',
  };
}

LatLng? _mapPoint(GuardeeLocation? location) {
  final latitude = location?.latitude;
  final longitude = location?.longitude;
  if (latitude == null || longitude == null) return null;
  if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
    return null;
  }
  return LatLng(latitude, longitude);
}

bool _isStale(DateTime updatedAt) {
  return DateTime.now().difference(updatedAt.toLocal()) >
      const Duration(minutes: 5);
}

String _relativeTime(DateTime updatedAt) {
  final elapsed = DateTime.now().difference(updatedAt.toLocal());
  if (elapsed.isNegative || elapsed < const Duration(minutes: 1)) {
    return 'just now';
  }
  if (elapsed < const Duration(hours: 1)) return '${elapsed.inMinutes} min ago';
  if (elapsed < const Duration(days: 1)) return '${elapsed.inHours} hr ago';
  return '${elapsed.inDays} d ago';
}
