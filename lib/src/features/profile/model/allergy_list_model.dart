import 'package:greenzone_medical/src/model/safe_json.dart';

class AllergyListModel {
  final int id;
  final String allergyOrIntolleranceSource;
  final String description;

  AllergyListModel({
    required this.id,
    required this.allergyOrIntolleranceSource,
    required this.description,
  });

  factory AllergyListModel.fromJson(Map<String, dynamic> json) {
    return AllergyListModel(
      id: SafeJson.asInt(json['id']),
      allergyOrIntolleranceSource:
          SafeJson.asString(json['allergyOrIntolleranceSource']),
      description: SafeJson.asString(json['description']),
    );
  }

  toJson() => {
        'allergyId': id,
      };
}

class UserAllergyModel {
  final int id;
  final int userId;
  final int allergyId;
  final String allergy;
  final String createdAt;

  UserAllergyModel({
    required this.id,
    required this.userId,
    required this.allergyId,
    required this.allergy,
    required this.createdAt,
  });

  factory UserAllergyModel.fromJson(Map<String, dynamic> json) {
    return UserAllergyModel(
      id: SafeJson.asInt(json['id']),
      userId: SafeJson.asInt(json['userId']),
      allergyId: SafeJson.asInt(json['allergy']['id']),
      allergy: SafeJson.asString(json['allergy']['allergy']),
      createdAt: SafeJson.asString(json['createdAt']),
    );
  }
}

class AllergyOtherModel {
  final int id;
  final String allergicTo;
  final int userId;
  final String createdAt;
  final String? updatedAt;

  AllergyOtherModel({
    required this.id,
    required this.allergicTo,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
  });

  factory AllergyOtherModel.fromJson(Map<String, dynamic> json) {
    return AllergyOtherModel(
      id: SafeJson.asInt(json['id']),
      allergicTo: SafeJson.asString(json['allergicTo']),
      userId: SafeJson.asInt(json['userId']),
      createdAt: SafeJson.asString(json['createdAt']),
      updatedAt: SafeJson.asString(json['updatedAt']),
    );
  }
}
