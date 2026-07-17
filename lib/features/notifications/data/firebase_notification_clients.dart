import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zhu_app/features/notifications/domain/notification_clients.dart';

const highImportanceChannelId = 'high_importance_channel';

Future<void> showBackgroundRemoteNotification(
  RemoteMessage remoteMessage,
) async {
  final message = _toNotificationMessage(remoteMessage);
  final riskType = message.data['riskType'];
  if (message.data['eventType'] != livenessCheckEventType ||
      riskType is! String ||
      !supportedLivenessRiskTypes.contains(riskType)) {
    return;
  }

  final notifications = AndroidLocalNotificationClient();
  await notifications.initializeForBackground();
  await notifications.show(
    id: 1001,
    title: message.title,
    body: message.body,
    payload: jsonEncode({
      'eventType': livenessCheckEventType,
      'riskType': riskType,
    }),
    actions: const [
      LocalNotificationAction(
        id: livenessCheckYesActionId,
        label: "Yes, I'm safe",
      ),
      LocalNotificationAction(
        id: livenessCheckNoActionId,
        label: "No, I'm not safe",
      ),
    ],
  );
}

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
      FirebaseMessaging.onMessage.map(_toNotificationMessage);

  @override
  Stream<NotificationMessage> get openedMessages =>
      FirebaseMessaging.onMessageOpenedApp.map(_toNotificationMessage);

  @override
  Future<NotificationMessage?> getInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    return message == null ? null : _toNotificationMessage(message);
  }
}

NotificationMessage _toNotificationMessage(RemoteMessage message) {
  return NotificationMessage(
    data: message.data,
    title: message.notification?.title ?? message.data['title'] as String?,
    body: message.notification?.body ?? message.data['body'] as String?,
  );
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
  static const _initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('ic_stat_zhu_notification'),
  );

  final FlutterLocalNotificationsPlugin _notifications;
  Future<void> Function(LocalNotificationResponse response)? _onResponse;
  bool _initialized = false;

  @override
  Future<bool> initializeAndRequestPermission({
    required Future<void> Function(LocalNotificationResponse response)
    onResponse,
  }) async {
    _onResponse = onResponse;
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (!_initialized) {
      await _notifications.initialize(
        settings: _initializationSettings,
        onDidReceiveNotificationResponse: (response) {
          unawaited(_dispatchResponse(response));
        },
      );
      await android?.createNotificationChannel(_channel);
      final launchDetails = await _notifications
          .getNotificationAppLaunchDetails();
      _initialized = true;
      final launchResponse = launchDetails?.notificationResponse;
      if ((launchDetails?.didNotificationLaunchApp ?? false) &&
          launchResponse != null) {
        await _dispatchResponse(launchResponse);
      }
    }
    return await android?.requestNotificationsPermission() ?? false;
  }

  Future<void> initializeForBackground() async {
    if (_initialized) return;
    await _notifications.initialize(settings: _initializationSettings);
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(_channel);
    _initialized = true;
  }

  @override
  Future<void> show({
    required int id,
    required String? title,
    required String? body,
    required String? payload,
    List<LocalNotificationAction> actions = const [],
  }) {
    return _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          highImportanceChannelId,
          'High importance notifications',
          channelDescription: 'Important notifications from ProtectMe',
          importance: Importance.high,
          priority: Priority.high,
          icon: 'ic_stat_zhu_notification',
          actions: actions
              .map(
                (action) => AndroidNotificationAction(
                  action.id,
                  action.label,
                  showsUserInterface: true,
                ),
              )
              .toList(),
        ),
      ),
      payload: payload,
    );
  }

  @override
  Future<void> cancelAll() => _notifications.cancelAll();

  Future<void> _dispatchResponse(NotificationResponse response) async {
    final onResponse = _onResponse;
    if (onResponse == null) return;
    await onResponse(
      LocalNotificationResponse(
        actionId: response.actionId,
        payload: response.payload,
      ),
    );
  }
}
