class ResponseModel<T> {
  final int? statusCode;
  final ErrorModel? error;
  final bool valid;
  final String? message;
  final String? token;
  final T? data;

  ResponseModel({
    this.valid = false,
    this.message = '',
    this.statusCode,
    this.data,
    this.error,
    this.token,
  });
}

class ErrorModel {
  String? errorCode;
  String? message;
  dynamic errorField;
  String? token;

  ErrorModel({this.errorCode, this.message, this.errorField, this.token});

  @override
  String toString() {
    return '{errorCode: $errorCode, message: $message}';
  }

  factory ErrorModel.fromJson(dynamic data) {
    if (data is String) {
      return ErrorModel(
          errorCode: '', message: data, errorField: '', token: '');
    }
    return ErrorModel(
        errorCode: data['errorCode'] ?? '',
        message: data['message'] ?? '',
        errorField: data['errorField'] ?? '',
        token: data['token'] ?? '');
  }
}
