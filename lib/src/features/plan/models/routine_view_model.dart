import 'package:flutter/foundation.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class RoutineViewModel {
  final String goalName;
  final List<String> routineItems;
  final TimeOfDay time;
  final DateTime startDate;

  RoutineViewModel({
    required this.goalName,
    required this.routineItems,
    required this.time,
    required this.startDate,
  });

  // RoutineViewModel copyWith({
  //   String? goalName,
  //   List<String>? routineItems,
  //   TimeOfDay? time,
  //   DateTime? startDate,
  // }) {
  //   return RoutineViewModel(
  //     goalName: goalName ?? this.goalName,
  //     routineItems: routineItems ?? this.routineItems,
  //     time: time ?? this.time,
  //     startDate: startDate ?? this.startDate,
  //   );
  // }

  bool validate() {
    return goalName.isNotEmpty && routineItems.isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoutineViewModel &&
        other.goalName == goalName &&
        listEquals(other.routineItems, routineItems) &&
        other.time == time &&
        other.startDate == startDate;
  }

  @override
  int get hashCode {
    return Object.hash(
      goalName,
      Object.hashAll(routineItems),
      time,
      startDate,
    );
  }
}
