// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_submission_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthSubmissionController)
final authSubmissionControllerProvider = AuthSubmissionControllerProvider._();

final class AuthSubmissionControllerProvider
    extends $NotifierProvider<AuthSubmissionController, AuthSubmissionState> {
  AuthSubmissionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSubmissionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSubmissionControllerHash();

  @$internal
  @override
  AuthSubmissionController create() => AuthSubmissionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSubmissionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSubmissionState>(value),
    );
  }
}

String _$authSubmissionControllerHash() =>
    r'121223d37301764e7375156a99e12cef5ab7b2a5';

abstract class _$AuthSubmissionController
    extends $Notifier<AuthSubmissionState> {
  AuthSubmissionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthSubmissionState, AuthSubmissionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthSubmissionState, AuthSubmissionState>,
              AuthSubmissionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(AuthDraftEmail)
final authDraftEmailProvider = AuthDraftEmailProvider._();

final class AuthDraftEmailProvider
    extends $NotifierProvider<AuthDraftEmail, String> {
  AuthDraftEmailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authDraftEmailProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authDraftEmailHash();

  @$internal
  @override
  AuthDraftEmail create() => AuthDraftEmail();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$authDraftEmailHash() => r'0f04cf4596dd5ab7a92ff7a23900b3046863b0d1';

abstract class _$AuthDraftEmail extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
