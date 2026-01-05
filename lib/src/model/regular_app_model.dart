import 'package:greenzone_medical/src/model/safe_json.dart';

class RegularAppModel {
  final int id;
  final String title;
  final int categoryId;
  final String category;
  final String description;
  final String benefits;
  final String? installs;

  const RegularAppModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.category,
    required this.description,
    required this.benefits,
    this.installs,
  });

  factory RegularAppModel.fromJson(Map<String, dynamic> json) {
    return RegularAppModel(
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
