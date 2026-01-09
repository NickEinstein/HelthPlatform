import 'package:equatable/equatable.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class RoutineViewModel extends Equatable {
  final String goalName;
  final List<String> routineItems;
  final TimeOfDay time;
  final DateTime startDate;

  const RoutineViewModel({
    required this.goalName,
    required this.routineItems,
    required this.time,
    required this.startDate,
  });

  bool validate() {
    return goalName.isNotEmpty && routineItems.isNotEmpty;
  }

  @override
  List<Object?> get props => [goalName, routineItems, time, startDate];
}
