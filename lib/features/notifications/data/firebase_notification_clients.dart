import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

const highImportanceChannelId = 'high_importance_channel';

class FirebasePushMessagingClient implements PushMessagingClient {
  FirebasePushMessagingClient([FirebaseMessaging? messaging])
    : _injectedMessaging = messaging;

  final FirebaseMessaging? _injectedMessaging;

  FirebaseMessaging get _messaging =>
      _injectedMessaging ?? FirebaseMessaging.instance;

  @override
  Future<String> activate() async {
    await _messaging.setAutoInitEnabled(true);
    final registrationToken = await _messaging.getToken();
    if (registrationToken == null || registrationToken.isEmpty) {
      throw StateError('FCM registration token is unavailable.');
    }
    return registrationToken;
  }

  @override
  Stream<String> get tokenRefreshes => _messaging.onTokenRefresh;

  @override
  Stream<NotificationMessage> get foregroundMessages =>
      FirebaseMessaging.onMessage.map(_toMessage);

  @override
  Stream<NotificationMessage> get openedMessages =>
      FirebaseMessaging.onMessageOpenedApp.map(_toMessage);

  @override
  Future<NotificationMessage?> getInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    return message == null ? null : _toMessage(message);
  }

  NotificationMessage _toMessage(RemoteMessage message) {
    return NotificationMessage(
      data: message.data,
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }
}

class AndroidLocalNotificationClient implements LocalNotificationClient {
  AndroidLocalNotificationClient([
    FlutterLocalNotificationsPlugin? notifications,
  ]) : _notifications = notifications ?? FlutterLocalNotificationsPlugin();

  static const _channel = AndroidNotificationChannel(
    highImportanceChannelId,
    'High importance notifications',
    description: 'Important notifications from ProtectMe',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _notifications;
  void Function(String? payload)? _onTap;
  bool _initialized = false;

  @override
  Future<bool> initializeAndRequestPermission({
    required void Function(String? payload) onTap,
  }) async {
    _onTap = onTap;
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (!_initialized) {
      await _notifications.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('ic_stat_zhu_notification'),
        ),
        onDidReceiveNotificationResponse: (response) {
          _onTap?.call(response.payload);
        },
      );
      await android?.createNotificationChannel(_channel);
      final launchDetails = await _notifications
          .getNotificationAppLaunchDetails();
      _initialized = true;
      if (launchDetails?.didNotificationLaunchApp ?? false) {
        _onTap?.call(launchDetails?.notificationResponse?.payload);
      }
    }
    return await android?.requestNotificationsPermission() ?? false;
  }

  @override
  Future<void> show({
    required int id,
    required String? title,
    required String? body,
    required String? payload,
  }) {
    return _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          highImportanceChannelId,
          'High importance notifications',
          channelDescription: 'Important notifications from ProtectMe',
          importance: Importance.high,
          priority: Priority.high,
          icon: 'ic_stat_zhu_notification',
        ),
      ),
      payload: payload,
    );
  }

  @override
  Future<void> cancelAll() => _notifications.cancelAll();
}
