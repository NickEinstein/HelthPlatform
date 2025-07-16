class ChatSummary {
  final String name;
  final String lastMessage;
  final String date;
  final String avatarUrl;
  final String status;

  ChatSummary({
    required this.name,
    required this.lastMessage,
    required this.date,
    required this.avatarUrl,
    required this.status,
  });
}

class Message {
  final String? text;
  final String? image;
  final String time;
  final bool isSentByMe;

  Message(
      {this.text, this.image, required this.time, required this.isSentByMe});
}
