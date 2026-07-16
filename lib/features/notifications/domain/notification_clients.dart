class NotificationMessage {
  const NotificationMessage({required this.data, this.title, this.body});

  final Map<String, dynamic> data;
  final String? title;
  final String? body;
}

abstract interface class PushMessagingClient {
  Future<String> activate();

  Stream<String> get tokenRefreshes;

  Stream<NotificationMessage> get foregroundMessages;

  Stream<NotificationMessage> get openedMessages;

  Future<NotificationMessage?> getInitialMessage();
}

abstract interface class LocalNotificationClient {
  Future<bool> initializeAndRequestPermission({
    required void Function(String? payload) onTap,
  });

  Future<void> show({
    required int id,
    required String? title,
    required String? body,
    required String? payload,
  });

  Future<void> cancelAll();
}

abstract interface class PushDeviceClient {
  Future<void> register(String registrationToken);

  Future<void> unregister(String registrationToken);
}
