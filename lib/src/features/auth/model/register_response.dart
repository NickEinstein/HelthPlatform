class RegisterResponse {
  final bool isSuccess;
  final int statusCode;
  final RegisterData? data;
  final dynamic error;

  RegisterResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.data,
    this.error,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      isSuccess: json['isSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
      error: json['error'],
    );
  }
}

class RegisterData {
  final String message;
  final int patientId;
  final EmailResult? emailResult;

  RegisterData({
    required this.message,
    required this.patientId,
    this.emailResult,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      message: json['message'] ?? '',
      patientId: json['patientId'] ?? 0,
      emailResult: json['emailResult'] != null
          ? EmailResult.fromJson(json['emailResult'])
          : null,
    );
  }
}

class EmailResult {
  final bool isSuccess;
  final String? message;

  EmailResult({
    required this.isSuccess,
    this.message,
  });

  factory EmailResult.fromJson(Map<String, dynamic> json) {
    return EmailResult(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'],
    );
  }
}
