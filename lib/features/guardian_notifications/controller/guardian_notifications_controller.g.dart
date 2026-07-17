// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian_notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GuardianNotificationsController)
final guardianNotificationsControllerProvider =
    GuardianNotificationsControllerProvider._();

final class GuardianNotificationsControllerProvider
    extends
        $AsyncNotifierProvider<
          GuardianNotificationsController,
          GuardianNotificationPage
        > {
  GuardianNotificationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guardianNotificationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guardianNotificationsControllerHash();

  @$internal
  @override
  GuardianNotificationsController create() => GuardianNotificationsController();
}

String _$guardianNotificationsControllerHash() =>
    r'2440f2b309c923fbae09163ec24771d66be74f64';

abstract class _$GuardianNotificationsController
    extends $AsyncNotifier<GuardianNotificationPage> {
  FutureOr<GuardianNotificationPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<GuardianNotificationPage>,
              GuardianNotificationPage
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<GuardianNotificationPage>,
                GuardianNotificationPage
              >,
              AsyncValue<GuardianNotificationPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
