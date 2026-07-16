// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationships_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(relationshipsRepository)
final relationshipsRepositoryProvider = RelationshipsRepositoryProvider._();

final class RelationshipsRepositoryProvider
    extends
        $FunctionalProvider<
          RelationshipsRepository,
          RelationshipsRepository,
          RelationshipsRepository
        >
    with $Provider<RelationshipsRepository> {
  RelationshipsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'relationshipsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$relationshipsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RelationshipsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RelationshipsRepository create(Ref ref) {
    return relationshipsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RelationshipsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RelationshipsRepository>(value),
    );
  }
}

String _$relationshipsRepositoryHash() =>
    r'ea15a00c7754930d74d018b6993779635a475b7e';
