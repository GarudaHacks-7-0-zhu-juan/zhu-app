import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/features/permissions/controller/app_permissions_controller.dart';
import 'package:zhu_app/features/permissions/data/app_permissions_gateway.dart';
import 'package:zhu_app/features/permissions/domain/app_permission_requirement.dart';

class AppPermissionsPage extends ConsumerWidget {
  const AppPermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(appPermissionsControllerProvider);
    final requirement = permissionState.value;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: _PermissionContent(
                requirement: requirement,
                isLoading: permissionState.isLoading,
                hasError: permissionState.hasError,
                onAction: () => _handleAction(ref, requirement),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleAction(
    WidgetRef ref,
    AppPermissionRequirement? requirement,
  ) async {
    final gateway = ref.read(appPermissionsGatewayProvider);
    switch (requirement) {
      case AppPermissionRequirement.notificationPermanentlyDenied:
      case AppPermissionRequirement.locationPermanentlyDenied:
        await gateway.openAppSettings();
      case AppPermissionRequirement.locationServicesDisabled:
        await gateway.openLocationSettings();
      case null:
      case AppPermissionRequirement.notificationDenied:
      case AppPermissionRequirement.locationDenied:
      case AppPermissionRequirement.ready:
        await ref.read(appPermissionsControllerProvider.notifier).recheck();
    }
  }
}

class _PermissionContent extends StatelessWidget {
  const _PermissionContent({
    required this.requirement,
    required this.isLoading,
    required this.hasError,
    required this.onAction,
  });

  final AppPermissionRequirement? requirement;
  final bool isLoading;
  final bool hasError;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final copy = _copyFor(requirement, hasError);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(copy.title, style: theme.textTheme.h3),
        const SizedBox(height: AppSpacing.md),
        Text(copy.body, style: theme.textTheme.muted),
        const SizedBox(height: AppSpacing.lg),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ShadButton(onPressed: onAction, child: Text(copy.action)),
      ],
    );
  }

  _PermissionCopy _copyFor(
    AppPermissionRequirement? requirement,
    bool hasError,
  ) {
    if (hasError) {
      return const _PermissionCopy(
        title: 'Permissions required',
        body: 'We could not check your device settings. Try again to continue.',
        action: 'Try again',
      );
    }

    return switch (requirement) {
      AppPermissionRequirement.notificationDenied => const _PermissionCopy(
        title: 'Turn on notifications',
        body:
            'Notifications are required so ProtectMe can keep you up to date.',
        action: 'Allow notifications',
      ),
      AppPermissionRequirement.notificationPermanentlyDenied =>
        const _PermissionCopy(
          title: 'Notifications are off',
          body:
              'Enable notifications for ProtectMe in system settings to continue.',
          action: 'Open app settings',
        ),
      AppPermissionRequirement.locationDenied => const _PermissionCopy(
        title: 'Allow location access',
        body: 'Location access is required to use ProtectMe.',
        action: 'Allow location',
      ),
      AppPermissionRequirement.locationPermanentlyDenied => const _PermissionCopy(
        title: 'Location access is off',
        body:
            'Enable location access for ProtectMe in system settings to continue.',
        action: 'Open app settings',
      ),
      AppPermissionRequirement.locationServicesDisabled =>
        const _PermissionCopy(
          title: 'Turn on device location',
          body: 'Turn on location services in device settings to continue.',
          action: 'Open location settings',
        ),
      AppPermissionRequirement.ready || null => const _PermissionCopy(
        title: 'Checking permissions',
        body: 'ProtectMe needs notification and location access.',
        action: 'Try again',
      ),
    };
  }
}

class _PermissionCopy {
  const _PermissionCopy({
    required this.title,
    required this.body,
    required this.action,
  });

  final String title;
  final String body;
  final String action;
}
