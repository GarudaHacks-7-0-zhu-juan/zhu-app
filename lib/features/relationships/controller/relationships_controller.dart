import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/relationships/data/relationships_repository.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';

part 'relationships_controller.g.dart';

@riverpod
class RelationshipsController extends _$RelationshipsController {
  @override
  Future<RelationshipData> build(RelationshipKind kind) {
    return ref.read(relationshipsRepositoryProvider).load(kind);
  }

  Future<void> refresh() => _run(() async {});

  Future<void> addRequest(String phoneNumber) {
    return _run(
      () => ref
          .read(relationshipsRepositoryProvider)
          .addRequest(kind, phoneNumber),
    );
  }

  Future<void> accept(String counterpartId) {
    return _run(
      () => ref
          .read(relationshipsRepositoryProvider)
          .updateRequest(kind, counterpartId, accepted: true),
    );
  }

  Future<void> decline(String counterpartId) {
    return _run(
      () => ref
          .read(relationshipsRepositoryProvider)
          .updateRequest(kind, counterpartId, accepted: false),
    );
  }

  Future<void> remove(String counterpartId) {
    return _run(
      () =>
          ref.read(relationshipsRepositoryProvider).remove(kind, counterpartId),
    );
  }

  Future<void> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    try {
      await action();
      state = AsyncData(
        await ref.read(relationshipsRepositoryProvider).load(kind),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}

@riverpod
Future<GuardeeDetail> guardeeDetail(Ref ref, String guardeeId) {
  return ref.read(relationshipsRepositoryProvider).guardeeDetail(guardeeId);
}
