import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
sealed class AuthFailure with _$AuthFailure implements Exception {
  const factory AuthFailure.validation() = ValidationAuthFailure;
  const factory AuthFailure.invalidCredentials() =
      InvalidCredentialsAuthFailure;
  const factory AuthFailure.emailAlreadyRegistered() =
      EmailAlreadyRegisteredAuthFailure;
  const factory AuthFailure.unauthorizedSession() =
      UnauthorizedSessionAuthFailure;
  const factory AuthFailure.network() = NetworkAuthFailure;
  const factory AuthFailure.timeout() = TimeoutAuthFailure;
  const factory AuthFailure.unexpected() = UnexpectedAuthFailure;
}
