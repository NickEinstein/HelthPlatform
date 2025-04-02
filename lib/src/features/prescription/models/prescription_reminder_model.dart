// To parse this JSON data, do
//
//     final prescriptionReminderModel = prescriptionReminderModelFromJson(jsonString);

import 'dart:convert';

PrescriptionReminderModel prescriptionReminderModelFromJson(String str) =>
    PrescriptionReminderModel.fromJson(json.decode(str));

String prescriptionReminderModelToJson(PrescriptionReminderModel data) =>
    json.encode(data.toJson());

class PrescriptionReminderModel {
  int? id;
  bool? isReminderActive;
  String? reminderTime;
  DateTime? startDate;
  DateTime? endDate;

  PrescriptionReminderModel({
    this.id,
    this.isReminderActive,
    this.reminderTime,
    this.startDate,
    this.endDate,
  });

  PrescriptionReminderModel copyWith({
    int? id,
    bool? isReminderActive,
    String? reminderTime,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      PrescriptionReminderModel(
        id: id ?? this.id,
        isReminderActive: isReminderActive ?? this.isReminderActive,
        reminderTime: reminderTime ?? this.reminderTime,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory PrescriptionReminderModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionReminderModel(
        id: json["id"],
        isReminderActive: json["isReminderActive"],
        reminderTime: json["reminderTime"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isReminderActive": isReminderActive,
        "reminderTime": reminderTime,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };
}
