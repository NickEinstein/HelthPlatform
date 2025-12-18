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
