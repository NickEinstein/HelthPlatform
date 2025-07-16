class ConversationResponse {
  final int id;
  final int senderId;
  final int receiverId;
  final int senderType;
  final int receiverType;
  final String? text;
  final String? imageUrl;
  final DateTime sentAt;
  final bool isRead;
  final dynamic sender; // Replace with actual sender model if available
  final dynamic receiver; // Replace with actual receiver model if available

  ConversationResponse({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderType,
    required this.receiverType,
    this.text,
    this.imageUrl,
    required this.sentAt,
    required this.isRead,
    this.sender,
    this.receiver,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      id: json['id'] as int,
      senderId: json['senderId'] as int,
      receiverId: json['receiverId'] as int,
      senderType: json['senderType'] as int? ?? 0,
      receiverType: json['receiverType'] as int? ?? 0,
      text: json['text'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isRead: json['isRead'] as bool,
      sender:
          json['sender'], // keep as dynamic or deserialize if you have models
      receiver: json['receiver'], // same as above
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderType': senderType,
      'receiverType': receiverType,
      'text': text,
      'imageUrl': imageUrl,
      'sentAt': sentAt.toIso8601String(),
      'isRead': isRead,
      'sender': sender, // replace with sender?.toJson() if model exists
      'receiver': receiver, // replace with receiver?.toJson() if model exists
    };
  }
}
