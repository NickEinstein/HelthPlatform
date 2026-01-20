import 'package:greenzone_medical/src/model/my_app_model.dart';
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
      category: SafeJson.asString(json['category'], defaultValue: ''),
      description: SafeJson.asString(json['description']),
      benefits: SafeJson.asString(json['benefits']),
      installs: SafeJson.asString(json['installs']),
    );
  }

  factory RegularAppModel.fromApp(MyAppModel model) => RegularAppModel(
        id: model.appId,
        title: '',
        categoryId: 0,
        category: '',
        description: '',
        benefits: '',
        installs: null,
      );

  MyAppModel toMyApp() => MyAppModel(
        appId: id,
        userId: 0,
        goal: '',
        startDate: '',
        createdAt: '',
        timeOfDay: '',
        isDelete: false,
        routines: [],
        id: 0,
      );
}
