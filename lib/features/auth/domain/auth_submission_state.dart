import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';

part 'auth_submission_state.freezed.dart';

@freezed
abstract class AuthSubmissionState with _$AuthSubmissionState {
  const factory AuthSubmissionState({
    @Default(false) bool isSubmitting,
    AuthFailure? failure,
  }) = _AuthSubmissionState;
}
