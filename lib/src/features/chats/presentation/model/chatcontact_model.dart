class ChatContact {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? pictureUrl;
  final int userType;
  final String lastMessage;
  final DateTime lastMessageDate;
  final int unreadCount;

  ChatContact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pictureUrl,
    required this.userType,
    required this.lastMessage,
    required this.lastMessageDate,
    required this.unreadCount,
  });

  factory ChatContact.fromJson(Map<String, dynamic> json) {
    return ChatContact(
      id: json['id'] as int,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      pictureUrl: json['pictureUrl'] as String?, // nullable
      userType: json['userType'] as int? ?? 0,
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageDate:
          DateTime.tryParse(json['lastMessageSentAt'] ?? '') ?? DateTime.now(),
      unreadCount: json['unreadMessagesCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'pictureUrl': pictureUrl,
        'userType': userType,
        'lastMessage': lastMessage,
        'lastMessageSentAt': lastMessageDate.toIso8601String(),
        'unreadMessagesCount': unreadCount,
      };

  String get fullName => '$firstName $lastName';
}
