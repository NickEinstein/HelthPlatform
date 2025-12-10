import 'package:greenzone_medical/src/utils/packages.dart';

class RoutineViewModel {
  final String? goalName;
  final List<String>? routine;
  final TimeOfDay? time;
  final DateTime? startDate;

  RoutineViewModel({
    this.goalName,
    this.routine,
    this.time,
    this.startDate,
  });

  RoutineViewModel copyWith({
    String? goalName,
    List<String>? routine,
    TimeOfDay? time,
    DateTime? startDate,
  }) {
    return RoutineViewModel(
      goalName: goalName ?? this.goalName,
      routine: routine ?? this.routine,
      time: time ?? this.time,
      startDate: startDate ?? this.startDate,
    );
  }

  bool validate() {
    return goalName != null &&
        goalName!.isNotEmpty &&
        routine != null &&
        routine!.isNotEmpty &&
        time != null &&
        startDate != null;
  }
}
