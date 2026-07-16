import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';
import 'package:zhu_app/features/auth/domain/auth_submission_state.dart';

part 'auth_submission_controller.g.dart';

@riverpod
class AuthSubmissionController extends _$AuthSubmissionController {
  @override
  AuthSubmissionState build() => const AuthSubmissionState();

  Future<void> signIn({required String email, required String password}) async {
    state = const AuthSubmissionState(isSubmitting: true);
    try {
      await ref
          .read(authSessionControllerProvider.notifier)
          .signIn(email: email, password: password);
      ref.read(authDraftEmailProvider.notifier).clear();
      state = const AuthSubmissionState();
    } on AuthFailure catch (failure) {
      state = AuthSubmissionState(failure: failure);
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AuthSubmissionState(isSubmitting: true);
    try {
      await ref
          .read(authSessionControllerProvider.notifier)
          .register(email: email, password: password);
      ref.read(authDraftEmailProvider.notifier).clear();
      state = const AuthSubmissionState();
    } on AuthFailure catch (failure) {
      state = AuthSubmissionState(failure: failure);
    }
  }

  void clearFailure() {
    state = const AuthSubmissionState();
  }
}

@Riverpod(keepAlive: true)
class AuthDraftEmail extends _$AuthDraftEmail {
  @override
  String build() => '';

  void update(String value) => state = value;

  void clear() => state = '';
}
