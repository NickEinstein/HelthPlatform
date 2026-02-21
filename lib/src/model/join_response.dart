class JoinCommunityResponse {
  bool? isSuccess;
  int? statusCode;
  Data? data;
  String? error;

  JoinCommunityResponse(
      {this.isSuccess, this.statusCode, this.data, this.error});

  JoinCommunityResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  String? message;
  int? communityId;

  Data({this.message, this.communityId});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    communityId = json['communityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['communityId'] = communityId;
    return data;
  }
}
