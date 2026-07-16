class NotificationMessage {
  const NotificationMessage({required this.data, this.title, this.body});

  final Map<String, dynamic> data;
  final String? title;
  final String? body;
}

class LocalNotificationAction {
  const LocalNotificationAction({required this.id, required this.label});

  final String id;
  final String label;
}

class LocalNotificationResponse {
  const LocalNotificationResponse({required this.actionId, this.payload});

  final String? actionId;
  final String? payload;
}

const livenessCheckEventType = 'LIVENESS_CHECK';
const highRiskAreaRiskType = 'HIGH_RISK_AREA';
const livenessCheckYesActionId = 'liveness_check_yes';
const livenessCheckNoActionId = 'liveness_check_no';

abstract interface class PushMessagingClient {
  Future<String> activate();

  Stream<String> get tokenRefreshes;

  Stream<NotificationMessage> get foregroundMessages;

  Stream<NotificationMessage> get openedMessages;

  Future<NotificationMessage?> getInitialMessage();
}

abstract interface class LocalNotificationClient {
  Future<bool> initializeAndRequestPermission({
    required Future<void> Function(LocalNotificationResponse response)
    onResponse,
  });

  Future<void> show({
    required int id,
    required String? title,
    required String? body,
    required String? payload,
    List<LocalNotificationAction> actions = const [],
  });

  Future<void> cancelAll();
}

abstract interface class LivenessCheckResponseClient {
  Future<void> respond(String riskType, {required bool isOkay});
}

abstract interface class PushDeviceClient {
  Future<void> register(String registrationToken);

  Future<void> unregister(String registrationToken);
}
