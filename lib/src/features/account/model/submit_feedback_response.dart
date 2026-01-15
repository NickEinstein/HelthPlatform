// {"isSuccess":true,"statusCode":200,"data":{"message":"CitizenFeedback Created Successfully","citizenFeedbackTrackId":"TCK2026011511442518727KHG745DF"},"error":null}
class SubmitFeedbackResponse {
  final bool isSuccess;
  final int statusCode;
  final Data? data;
  final dynamic error;

  SubmitFeedbackResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.data,
    required this.error,
  });

  factory SubmitFeedbackResponse.fromJson(Map<String, dynamic> json) {
    return SubmitFeedbackResponse(
      isSuccess: json['isSuccess'] ,
      statusCode: json['statusCode'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      error: json['error'],
    );
  }
}

class Data {
  final String message;
  final String citizenFeedbackTrackId;

  Data({
    required this.message,
    required this.citizenFeedbackTrackId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json['message'],
      citizenFeedbackTrackId: json['citizenFeedbackTrackId'],
    );
  }
}
