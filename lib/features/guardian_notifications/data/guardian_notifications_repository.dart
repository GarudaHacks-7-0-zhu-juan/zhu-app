import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zhu_app/features/auth/auth_providers.dart';
import 'package:zhu_app/features/auth/data/authenticated_api_client.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification.dart';
import 'package:zhu_app/features/guardian_notifications/domain/guardian_notification_page.dart';

part 'guardian_notifications_repository.g.dart';

@Riverpod(keepAlive: true)
GuardianNotificationsRepository guardianNotificationsRepository(Ref ref) {
  return GuardianNotificationsRepository(
    ref.watch(authenticatedApiClientProvider),
  );
}

class GuardianNotificationsRepository {
  const GuardianNotificationsRepository(this._client);

  final AuthenticatedApiClient _client;

  Future<GuardianNotificationPage> load({String? cursor}) async {
    final query = <String>['limit=20'];
    if (cursor != null) query.add('cursor=${Uri.encodeQueryComponent(cursor)}');
    final json = await _client.getJson(
      '/guardian-notifications?${query.join('&')}',
    );
    final items = json['items'];
    if (items is! List<dynamic>) {
      throw const FormatException(
        'Guardian notifications response has no items.',
      );
    }
    final nextCursor = json['nextCursor'];
    if (nextCursor != null && nextCursor is! String) {
      throw const FormatException(
        'Guardian notifications response has an invalid cursor.',
      );
    }
    return GuardianNotificationPage(
      items: items
          .map((item) {
            if (item is! Map<dynamic, dynamic>) {
              throw const FormatException('Guardian notification is invalid.');
            }
            return GuardianNotification.fromJson(
              Map<String, dynamic>.from(item),
            );
          })
          .toList(growable: false),
      nextCursor: nextCursor as String?,
    );
  }
}
