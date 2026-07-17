import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/auth/presentation/auth_loading_page.dart';
import 'package:zhu_app/features/auth/presentation/auth_page.dart';
import 'package:zhu_app/features/permissions/controller/app_permissions_controller.dart';
import 'package:zhu_app/features/permissions/domain/app_permission_requirement.dart';
import 'package:zhu_app/features/permissions/presentation/app_permissions_page.dart';
import 'package:zhu_app/features/navigation/presentation/app_shell.dart';
import 'package:zhu_app/features/guardian_notifications/presentation/guardian_notifications_page.dart';
import 'package:zhu_app/features/relationships/presentation/guardee_detail_page.dart';

final appNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: '/loading',
    redirect: (context, route) {
      final permissionState = ref.read(appPermissionsControllerProvider);
      if (permissionState.value != AppPermissionRequirement.ready) {
        return route.matchedLocation == '/permissions' ? null : '/permissions';
      }

      final session = ref.read(authSessionControllerProvider);
      final location = route.matchedLocation;
      final isAuthRoute = location == '/login' || location == '/register';
      final isGuardeeDetailRoute =
          route.uri.path.startsWith('/guardees/') &&
          (route.pathParameters['guardeeId']?.isNotEmpty ?? false);

      return switch (session) {
        InitializingAuthSessionState() =>
          location == '/loading' ? null : '/loading',
        AuthenticatedAuthSessionState() when isGuardeeDetailRoute => null,
        AuthenticatedAuthSessionState() => switch (location) {
          '/workspace' ||
          '/guardians' ||
          '/guardees' ||
          '/profile' ||
          '/guardian-notifications' ||
          '/liveness-check' => null,
          _ when location.startsWith('/guardees/') => null,
          _ => '/workspace',
        },
        UnauthenticatedAuthSessionState() ||
        UnavailableAuthSessionState() => isAuthRoute ? null : '/login',
      };
    },
    routes: [
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const AppPermissionsPage(),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const AuthLoadingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthPage(mode: AuthMode.signIn),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const AuthPage(mode: AuthMode.register),
      ),
      GoRoute(
        path: '/workspace',
        builder: (context, state) => const AppShell(),
      ),
      GoRoute(
        path: '/guardians',
        builder: (context, state) => const AppShell(selectedIndex: 1),
      ),
      GoRoute(
        path: '/guardees',
        builder: (context, state) => const AppShell(selectedIndex: 2),
      ),
      GoRoute(
        path: '/guardees/:guardeeId',
        builder: (context, state) =>
            GuardeeDetailPage(guardeeId: state.pathParameters['guardeeId']!),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const AppShell(selectedIndex: 3),
      ),
      GoRoute(
        path: '/liveness-check',
        builder: (context, state) => const AppShell(selectedIndex: 3),
      ),
      GoRoute(
        path: '/guardian-notifications',
        builder: (context, state) => const GuardianNotificationsPage(),
      ),
    ],
  );
  ref.listen(appPermissionsControllerProvider, (_, _) => router.refresh());
  ref.listen(authSessionControllerProvider, (_, _) => router.refresh());
  ref.onDispose(router.dispose);
  return router;
});
