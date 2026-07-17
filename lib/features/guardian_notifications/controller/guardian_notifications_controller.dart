import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/guardian_notifications/data/guardian_notifications_repository.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification_page.dart';

part 'guardian_notifications_controller.g.dart';

@riverpod
class GuardianNotificationsController
    extends _$GuardianNotificationsController {
  bool _loadingMore = false;

  @override
  Future<GuardianNotificationPage> build() {
    return ref.read(guardianNotificationsRepositoryProvider).load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(guardianNotificationsRepositoryProvider).load(),
    );
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (_loadingMore || current == null || current.nextCursor == null) return;

    _loadingMore = true;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final next = await ref
          .read(guardianNotificationsRepositoryProvider)
          .load(cursor: current.nextCursor);
      state = AsyncData(mergeGuardianNotificationPages(current, next));
    } catch (_) {
      // Retain loaded notifications so a transient paging failure is non-destructive.
      state = AsyncData(current.copyWith(isLoadingMore: false));
    } finally {
      _loadingMore = false;
    }
  }
}

GuardianNotificationPage mergeGuardianNotificationPages(
  GuardianNotificationPage current,
  GuardianNotificationPage next,
) {
  final ids = current.items.map((item) => item.id).toSet();
  return current.copyWith(
    items: [...current.items, ...next.items.where((item) => ids.add(item.id))],
    nextCursor: next.nextCursor,
    isLoadingMore: false,
  );
}
