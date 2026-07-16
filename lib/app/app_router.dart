import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/auth/presentation/auth_loading_page.dart';
import 'package:zhu_app/features/auth/presentation/auth_page.dart';
import 'package:zhu_app/features/component_workspace/component_workspace_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/loading',
    redirect: (context, route) {
      final session = ref.read(authSessionControllerProvider);
      final location = route.matchedLocation;
      final isAuthRoute = location == '/login' || location == '/register';

      return switch (session) {
        InitializingAuthSessionState() =>
          location == '/loading' ? null : '/loading',
        AuthenticatedAuthSessionState() =>
          location == '/workspace' ? null : '/workspace',
        UnauthenticatedAuthSessionState() ||
        UnavailableAuthSessionState() => isAuthRoute ? null : '/login',
      };
    },
    routes: [
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
        builder: (context, state) => const ComponentWorkspacePage(),
      ),
    ],
  );
  ref.listen(authSessionControllerProvider, (_, _) => router.refresh());
  ref.onDispose(router.dispose);
  return router;
});
