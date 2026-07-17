import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';

part 'auth_session_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthSessionController extends _$AuthSessionController {
  @override
  AuthSessionState build() {
    ref.listen(sessionInvalidationsProvider, (_, next) {
      if (next.hasValue) {
        state = const AuthSessionState.unauthenticated(
          notice: 'Your session has expired. Sign in again.',
        );
      }
    });
    Future<void>.microtask(_restoreSession);
    return const AuthSessionState.initializing();
  }

  Future<void> retryRestore() {
    state = const AuthSessionState.initializing();
    return _restoreSession();
  }

  Future<void> signIn({required String email, required String password}) async {
    final user = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    state = AuthSessionState.authenticated(user);
  }

  Future<void> register({
    required String email,
    required String password,
    required String phoneNumber,
    String? displayName,
  }) async {
    final user = await ref
        .read(authRepositoryProvider)
        .register(
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          displayName: displayName,
        );
    state = AuthSessionState.authenticated(user);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthSessionState.unauthenticated();
  }

  Future<void> _restoreSession() async {
    try {
      final user = await ref.read(authRepositoryProvider).restoreSession();
      state = user == null
          ? const AuthSessionState.unauthenticated()
          : AuthSessionState.authenticated(user);
    } on AuthFailure catch (failure) {
      switch (failure) {
        case NetworkAuthFailure() || TimeoutAuthFailure():
          state = AuthSessionState.unavailable(failure);
        case UnauthorizedSessionAuthFailure():
          state = const AuthSessionState.unauthenticated(
            notice: 'Your session has expired. Sign in again.',
          );
        default:
          state = const AuthSessionState.unauthenticated();
      }
    }
  }
}
