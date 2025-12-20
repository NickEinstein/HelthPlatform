import 'package:greenzone_medical/src/model/safe_json.dart';

class MyAppModel {
  final int id;
  final String title;
  final int categoryId;
  final String category;
  final String description;
  final String benefits;
  final String? installs;

  MyAppModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.category,
    required this.description,
    required this.benefits,
    this.installs,
  });

  factory MyAppModel.fromJson(Map<String, dynamic> json) {
    return MyAppModel(
      id: SafeJson.asInt(json['id']),
      title: SafeJson.asString(json['title']),
      categoryId: SafeJson.asInt(json['categoryId']),
      category: SafeJson.asString(json['category']),
      description: SafeJson.asString(json['description']),
      benefits: SafeJson.asString(json['benefits']),
      installs: SafeJson.asString(json['installs']),
    );
  }
}
