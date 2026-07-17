// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthSessionController)
final authSessionControllerProvider = AuthSessionControllerProvider._();

final class AuthSessionControllerProvider
    extends $NotifierProvider<AuthSessionController, AuthSessionState> {
  AuthSessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionControllerHash();

  @$internal
  @override
  AuthSessionController create() => AuthSessionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSessionState>(value),
    );
  }
}

String _$authSessionControllerHash() =>
    r'8aa4086a047e317d4542e05cc59b413e88e1e899';

abstract class _$AuthSessionController extends $Notifier<AuthSessionState> {
  AuthSessionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthSessionState, AuthSessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthSessionState, AuthSessionState>,
              AuthSessionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
