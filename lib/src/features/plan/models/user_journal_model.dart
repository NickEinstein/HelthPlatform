// "id":8,"goalId":1,"entryDate":"2025-09-17T19:22:44.4748402","progress":40,"currentValue":80,"modifiedBy":3443,"dateCreated":"2025-09-17T19:22:44.4748874","dateModified":"0001-01-01T00:00:00"}
class UserJournalModel {
  final int? id;
  final int goalId;
  final DateTime entryDate;
  final int progress;
  final int currentValue;
  final int? modifiedBy;
  final DateTime? dateCreated;
  final DateTime? dateModified;

  UserJournalModel({
    this.id,
    required this.goalId,
    required this.entryDate,
    required this.progress,
    required this.currentValue,
    this.modifiedBy,
    this.dateCreated,
    this.dateModified,
  });

  factory UserJournalModel.fromJson(Map<String, dynamic> json) {
    return UserJournalModel(
      id: json['id'],
      goalId: json['goalId'],
      entryDate: DateTime.parse(json['entryDate']),
      progress: json['progress'],
      currentValue: json['currentValue'],
      modifiedBy: json['modifiedBy'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateModified: DateTime.parse(json['dateModified']),
    );
  }

  Map<String, dynamic> toJson() => {
        "progress": progress,
        "currentValue": currentValue,
        "goalId": goalId,
      };
}
