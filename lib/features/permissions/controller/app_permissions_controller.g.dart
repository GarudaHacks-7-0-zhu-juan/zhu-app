// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_permissions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppPermissionsController)
final appPermissionsControllerProvider = AppPermissionsControllerProvider._();

final class AppPermissionsControllerProvider
    extends
        $AsyncNotifierProvider<
          AppPermissionsController,
          AppPermissionRequirement
        > {
  AppPermissionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appPermissionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appPermissionsControllerHash();

  @$internal
  @override
  AppPermissionsController create() => AppPermissionsController();
}

String _$appPermissionsControllerHash() =>
    r'9b67e64e75ced0434b338f35e4d4887e4d60de58';

abstract class _$AppPermissionsController
    extends $AsyncNotifier<AppPermissionRequirement> {
  FutureOr<AppPermissionRequirement> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<AppPermissionRequirement>,
              AppPermissionRequirement
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AppPermissionRequirement>,
                AppPermissionRequirement
              >,
              AsyncValue<AppPermissionRequirement>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
