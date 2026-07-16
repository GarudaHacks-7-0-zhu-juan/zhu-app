// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationships_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RelationshipsController)
final relationshipsControllerProvider = RelationshipsControllerFamily._();

final class RelationshipsControllerProvider
    extends $AsyncNotifierProvider<RelationshipsController, RelationshipData> {
  RelationshipsControllerProvider._({
    required RelationshipsControllerFamily super.from,
    required RelationshipKind super.argument,
  }) : super(
         retry: null,
         name: r'relationshipsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$relationshipsControllerHash();

  @override
  String toString() {
    return r'relationshipsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RelationshipsController create() => RelationshipsController();

  @override
  bool operator ==(Object other) {
    return other is RelationshipsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$relationshipsControllerHash() =>
    r'689f935c1ff9fc46a5ccc2ff56a29a4fa5146ef5';

final class RelationshipsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          RelationshipsController,
          AsyncValue<RelationshipData>,
          RelationshipData,
          FutureOr<RelationshipData>,
          RelationshipKind
        > {
  RelationshipsControllerFamily._()
    : super(
        retry: null,
        name: r'relationshipsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RelationshipsControllerProvider call(RelationshipKind kind) =>
      RelationshipsControllerProvider._(argument: kind, from: this);

  @override
  String toString() => r'relationshipsControllerProvider';
}

abstract class _$RelationshipsController
    extends $AsyncNotifier<RelationshipData> {
  late final _$args = ref.$arg as RelationshipKind;
  RelationshipKind get kind => _$args;

  FutureOr<RelationshipData> build(RelationshipKind kind);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RelationshipData>, RelationshipData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RelationshipData>, RelationshipData>,
              AsyncValue<RelationshipData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(guardeeDetail)
final guardeeDetailProvider = GuardeeDetailFamily._();

final class GuardeeDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<GuardeeDetail>,
          GuardeeDetail,
          FutureOr<GuardeeDetail>
        >
    with $FutureModifier<GuardeeDetail>, $FutureProvider<GuardeeDetail> {
  GuardeeDetailProvider._({
    required GuardeeDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'guardeeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$guardeeDetailHash();

  @override
  String toString() {
    return r'guardeeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<GuardeeDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GuardeeDetail> create(Ref ref) {
    final argument = this.argument as String;
    return guardeeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GuardeeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$guardeeDetailHash() => r'cb135cc0e7d00b81963bee1d0547d772bc5277be';

final class GuardeeDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<GuardeeDetail>, String> {
  GuardeeDetailFamily._()
    : super(
        retry: null,
        name: r'guardeeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GuardeeDetailProvider call(String guardeeId) =>
      GuardeeDetailProvider._(argument: guardeeId, from: this);

  @override
  String toString() => r'guardeeDetailProvider';
}
