import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';
import 'package:zhu_app/features/auth/domain/auth_user.dart';

part 'auth_session_state.freezed.dart';

@freezed
sealed class AuthSessionState with _$AuthSessionState {
  const factory AuthSessionState.initializing() = InitializingAuthSessionState;
  const factory AuthSessionState.unauthenticated({String? notice}) =
      UnauthenticatedAuthSessionState;
  const factory AuthSessionState.unavailable(AuthFailure failure) =
      UnavailableAuthSessionState;
  const factory AuthSessionState.authenticated(AuthUser user) =
      AuthenticatedAuthSessionState;
}
