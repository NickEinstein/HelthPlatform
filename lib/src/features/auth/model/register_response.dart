class RegisterResponse {
  final bool isSuccess;
  final int statusCode;
  final RegisterData? data;
  final RegisterError? error; // 👈 add this
  final String? message;

  RegisterResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.error,
    this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      isSuccess: json['isSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
      error:
          json['error'] != null ? RegisterError.fromJson(json['error']) : null,
      message: json['message'],
    );
  }

  /// 👇 Helper to always return the right error message
  String get errorMessage {
    if (error?.emailResult?.message != null &&
        error!.emailResult!.message!.isNotEmpty) {
      return error!.emailResult!.message!;
    }
    if (error?.message != null && error!.message!.isNotEmpty) {
      return error!.message!;
    }
    if (message != null && message!.isNotEmpty) {
      return message!;
    }
    return "Something went wrong";
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

/// 👇 New class for the `error` object
class RegisterError {
  final String? message;
  final int? patientId;
  final EmailResult? emailResult;

  RegisterError({
    this.message,
    this.patientId,
    this.emailResult,
  });

  factory RegisterError.fromJson(Map<String, dynamic> json) {
    return RegisterError(
      message: json['message'],
      patientId: json['patientId'],
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
