class LoginResponse {
  final int userId;
  final String name;
  final String email;
  // final String clinic;
  // final int clinicId;
  final String token;

  LoginResponse({
    required this.userId,
    required this.name,
    required this.email,
    // required this.clinic,
    // required this.clinicId,
    required this.token,
  });

  // Convert JSON to LoginResponse object
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['userID'],
      name: json['name'],
      email: json['email'],
      // clinic: json['clinic'],
      // clinicId: json['clinicId'],
      token: json['token'],
    );
  }

  // Convert LoginResponse object to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      'userID': userId,
      'name': name,
      'email': email,
      // 'clinic': clinic,
      // 'clinicId': clinicId,
      'token': token,
    };
  }
}
