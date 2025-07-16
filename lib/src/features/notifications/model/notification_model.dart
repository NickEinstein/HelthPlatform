class NotificationResponse {
  final int id;
  final int userId;
  final String title;
  final String message;
  final String type;
  final int referenceId;
  final DateTime createdAt;
  final bool isRead;

  NotificationResponse({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    required this.referenceId,
    required this.createdAt,
    required this.isRead,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      referenceId: json['referenceId'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
    );
  }
}

class PushNotificationItemOnTap {
  final String title;
  final String body;
  final String timeStamp;

  PushNotificationItemOnTap({
    required this.title,
    required this.body,
    String? timeStamp,
  }) : timeStamp = timeStamp ?? DateTime.now().toIso8601String();
}

class UnreadNotificationResponse {
  final int unreadCount;

  UnreadNotificationResponse({required this.unreadCount});

  factory UnreadNotificationResponse.fromJson(Map<String, dynamic> json) {
    return UnreadNotificationResponse(
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unreadCount': unreadCount,
    };
  }
}
