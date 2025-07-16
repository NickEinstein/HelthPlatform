class LoginResponse {
  final int userId;
  final String name;
  final String email;
  final String token;
  final String? deviceToken;
  final int userType;

  LoginResponse({
    required this.userId,
    required this.name,
    required this.email,
    required this.token,
    this.deviceToken,
    required this.userType,
  });

  // Convert JSON to LoginResponse object
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['userID'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      deviceToken: json['deviceToken'],
      userType: json['userType'],
    );
  }

  // Convert LoginResponse object to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      'userID': userId,
      'name': name,
      'email': email,
      'token': token,
      'deviceToken': deviceToken,
      'userType': userType,
    };
  }
}
