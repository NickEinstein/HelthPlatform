// {"id":7622,"userId":18727,"userName":"Damilare  Adefemiwa ","module":"Authentication","message":"Patient logged into the system","timeCreated":"2025-12-19T03:15:06.437"}
class AccountActivityModel {
  final int id;
  final int userId;
  final String userName;
  final String module;
  final String message;
  final String timeCreated;

  const AccountActivityModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.module,
    required this.message,
    required this.timeCreated,
  });

  factory AccountActivityModel.fromJson(Map<String, dynamic> json) {
    return AccountActivityModel(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      module: json['module'],
      message: json['message'],
      timeCreated: json['timeCreated'],
    );
  }
}