class UnreadMessageResponse {
  final String status;
  final int userId;
  final int unreadMessages;

  UnreadMessageResponse({
    required this.status,
    required this.userId,
    required this.unreadMessages,
  });

  factory UnreadMessageResponse.fromJson(Map<String, dynamic> json) {
    return UnreadMessageResponse(
      status: json['status'] as String,
      userId: json['userId'] as int,
      unreadMessages: json['unreadMessages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'userId': userId,
      'unreadMessages': unreadMessages,
    };
  }
}
