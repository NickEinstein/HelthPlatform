class AllAlergyResponse {
  int? id;
  String? allergyOrIntolleranceSource;
  String? description;

  AllAlergyResponse(
      {this.id, this.allergyOrIntolleranceSource, this.description});

  AllAlergyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergyOrIntolleranceSource = json['allergyOrIntolleranceSource'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['allergyOrIntolleranceSource'] = this.allergyOrIntolleranceSource;
    data['description'] = this.description;
    return data;
  }
}

class UserAllegiesResponse {
  int? id;
  String? allergicTo;
  int? userId;
  int? allergyId;
  String? createdAt;
  String? updatedAt;

  UserAllegiesResponse(
      {this.id,
      this.allergicTo,
      this.userId,
      this.allergyId,
      this.createdAt,
      this.updatedAt});

  UserAllegiesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergicTo = json['allergicTo'];
    userId = json['userId'];
    allergyId = json['allergyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['allergicTo'] = this.allergicTo;
    data['userId'] = this.userId;
    data['allergyId'] = this.allergyId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
