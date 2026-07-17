import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/features/guardian_notifications/controller/guardian_notifications_controller.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification_page.dart';

class GuardianNotificationsPage extends ConsumerStatefulWidget {
  const GuardianNotificationsPage({super.key});

  @override
  ConsumerState<GuardianNotificationsPage> createState() =>
      _GuardianNotificationsPageState();
}

class _GuardianNotificationsPageState
    extends ConsumerState<GuardianNotificationsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreIfNeeded);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMoreIfNeeded)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(guardianNotificationsControllerProvider);
    final controller = ref.read(
      guardianNotificationsControllerProvider.notifier,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Guardian alerts')),
      body: SafeArea(
        child: switch (notifications) {
          AsyncData(:final value) => RefreshIndicator(
            onRefresh: controller.refresh,
            child: _NotificationList(
              scrollController: _scrollController,
              page: value,
            ),
          ),
          AsyncError() => _LoadError(onRetry: controller.refresh),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }

  void _loadMoreIfNeeded() {
    if (!_scrollController.hasClients ||
        _scrollController.position.extentAfter > 240) {
      return;
    }
    ref.read(guardianNotificationsControllerProvider.notifier).loadMore();
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList({required this.scrollController, required this.page});

  final ScrollController scrollController;
  final GuardianNotificationPage page;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    if (page.items.isEmpty) {
      return ListView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: AppSpacing.screen,
        children: [
          const SizedBox(height: AppSpacing.xxl),
          Icon(
            Icons.notifications_none,
            size: 48,
            color: theme.colorScheme.pencilGrey,
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text('No guardian alerts yet', style: theme.textTheme.h3),
          ),
          const SizedBox(height: AppSpacing.xs),
          Center(
            child: Text(
              'Safety alerts for people you support will appear here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.muted,
            ),
          ),
        ],
      );
    }
    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.screen.copyWith(
        top: AppSpacing.lg,
        bottom: AppSpacing.xxl,
      ),
      itemCount: page.items.length + (page.nextCursor == null ? 0 : 1),
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        if (index == page.items.length && page.isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (index == page.items.length) return const SizedBox.shrink();
        return _NotificationCard(notification: page.items[index]);
      },
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final GuardianNotification notification;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Semantics(
      button: true,
      label: 'View alert for ${notification.guardeeLabel}',
      child: ShadCard(
        child: InkWell(
          onTap: () => context.go('/guardees/${notification.guardeeId}'),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: theme.colorScheme.warning,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.guardeeLabel,
                        style: theme.textTheme.large,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(notification.triggerCopy),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _sentAtLabel(notification.sentAt),
                        style: theme.textTheme.muted,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Center(
      child: Padding(
        padding: AppSpacing.screen,
        child: ShadCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Unable to load guardian alerts', style: theme.textTheme.h3),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Check your connection and try again.',
                style: theme.textTheme.muted,
              ),
              const SizedBox(height: AppSpacing.md),
              ShadButton.outline(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _sentAtLabel(DateTime sentAt) {
  final local = sentAt.toLocal();
  return '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
}
