// {"postId":6,"content":"<p>Hello World</p>","mediaUrl":"/uploads/469d26aa-c424-4138-997a-1cc6afd478ad.png","mediaType":"image/png","createdAt":"2025-12-21T14:37:46.39","posterFullName":"Damilare  Adefemiwa ","pictureUrl":"","userType":"Member","comments":[],"reactionsSummary":{}
class UserPostModel {
  final int postId;
  final String content;
  final String mediaUrl;
  final String mediaType;
  final String createdAt;
  final String posterFullName;
  final String pictureUrl;
  final String userType;
  final List<dynamic> comments;
  final Map<String, dynamic> reactionsSummary;

  UserPostModel({
    required this.postId,
    required this.content,
    required this.mediaUrl,
    required this.mediaType,
    required this.createdAt,
    required this.posterFullName,
    required this.pictureUrl,
    required this.userType,
    required this.comments,
    required this.reactionsSummary,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
        postId: json["postId"],
        content: json["content"],
        mediaUrl: json["mediaUrl"],
        mediaType: json["mediaType"],
        createdAt: json["createdAt"],
        posterFullName: json["posterFullName"],
        pictureUrl: json["pictureUrl"],
        userType: json["userType"],
        comments: json["comments"],
        reactionsSummary: json["reactionsSummary"],
      );
}