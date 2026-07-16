import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/app/app_router.dart';
import 'package:zhu_app/core/diagnostics/app_logarte.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/locations/location_providers.dart';
import 'package:zhu_app/features/notifications/notification_providers.dart';
import 'package:zhu_app/features/permissions/controller/app_permissions_controller.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  OverlayEntry? _logarteHostEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(locationLifecycleProvider);
    ref.read(notificationLifecycleProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!kDebugMode) return;
      final overlay = appNavigatorKey.currentState?.overlay;
      if (overlay == null) return;
      _logarteHostEntry = OverlayEntry(
        builder: (_) => const _LogarteOverlayHost(),
      );
      overlay.insert(_logarteHostEntry!);
    });
  }

  @override
  void dispose() {
    _logarteHostEntry?.remove();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    ref.read(appPermissionsControllerProvider.notifier).recheck();
    final session = ref.read(authSessionControllerProvider);
    if (session is AuthenticatedAuthSessionState) {
      unawaited(
        ref
            .read(notificationCoordinatorProvider)
            .syncForSession(authenticated: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppShadTheme.light,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}

class _LogarteOverlayHost extends StatefulWidget {
  const _LogarteOverlayHost();

  @override
  State<_LogarteOverlayHost> createState() => _LogarteOverlayHostState();
}

class _LogarteOverlayHostState extends State<_LogarteOverlayHost> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      appLogarte.attach(context: context, visible: true);
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
