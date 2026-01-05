import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/model/safe_json.dart';

class MyAppModel {
  final int id;
  final int appId;
  final int userId;
  final String goal;
  final String startDate;
  final String timeOfDay;
  final String createdAt;
  final bool isDelete;
  final List<dynamic> routines;
  final RegularAppModel? app;

  const MyAppModel({
    required this.id,
    this.app,
    required this.appId,
    required this.userId,
    required this.goal,
    required this.startDate,
    required this.timeOfDay,
    required this.createdAt,
    required this.isDelete,
    required this.routines,
  });

  MyAppModel copyWith({
    int? id,
    int? appId,
    int? userId,
    String? goal,
    String? startDate,
    String? timeOfDay,
    String? createdAt,
    bool? isDelete,
    List<dynamic>? routines,
    RegularAppModel? app,
  }) {
    return MyAppModel(
      id: id ?? this.id,
      appId: appId ?? this.appId,
      userId: userId ?? this.userId,
      goal: goal ?? this.goal,
      startDate: startDate ?? this.startDate,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      createdAt: createdAt ?? this.createdAt,
      isDelete: isDelete ?? this.isDelete,
      routines: routines ?? this.routines,
      app: app ?? this.app,
    );
  }

  factory MyAppModel.fromJson(Map<String, dynamic> json) {
    return MyAppModel(
      id: SafeJson.asInt(json['id']),
      appId: SafeJson.asInt(json['appId']),
      userId: SafeJson.asInt(json['userId']),
      goal: SafeJson.asString(json['goal']),
      startDate: SafeJson.asString(json['startDate']),
      timeOfDay: SafeJson.asString(json['timeOfDay']),
      createdAt: SafeJson.asString(json['createdAt']),
      isDelete: SafeJson.asBool(json['isDelete']),
      routines: SafeJson.asList(json['routines']),
    );
  }
}
