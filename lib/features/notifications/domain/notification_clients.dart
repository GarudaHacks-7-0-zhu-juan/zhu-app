class NotificationMessage {
  const NotificationMessage({required this.data, this.title, this.body});

  final Map<String, dynamic> data;
  final String? title;
  final String? body;
}

abstract interface class PushMessagingClient {
  Future<void> activate();

  Future<void> deactivate();

  Stream<void> get tokenRefreshes;

  Stream<NotificationMessage> get foregroundMessages;

  Stream<NotificationMessage> get openedMessages;

  Future<NotificationMessage?> getInitialMessage();
}

abstract interface class InstallationIdSource {
  Future<String> getId();

  Future<void> delete();
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
  Future<void> register(String installationId);

  Future<void> unregister(String installationId);
}
