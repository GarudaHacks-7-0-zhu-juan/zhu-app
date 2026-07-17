// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian_notifications_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(guardianNotificationsRepository)
final guardianNotificationsRepositoryProvider =
    GuardianNotificationsRepositoryProvider._();

final class GuardianNotificationsRepositoryProvider
    extends
        $FunctionalProvider<
          GuardianNotificationsRepository,
          GuardianNotificationsRepository,
          GuardianNotificationsRepository
        >
    with $Provider<GuardianNotificationsRepository> {
  GuardianNotificationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guardianNotificationsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guardianNotificationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<GuardianNotificationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GuardianNotificationsRepository create(Ref ref) {
    return guardianNotificationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuardianNotificationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuardianNotificationsRepository>(
        value,
      ),
    );
  }
}

String _$guardianNotificationsRepositoryHash() =>
    r'3d5feb58cb22bd9bc281c6b730aae4153b6e95bf';
