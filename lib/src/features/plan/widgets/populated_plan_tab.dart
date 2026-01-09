import 'package:greenzone_medical/src/features/plan/widgets/plan_tab_dashboard.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/date_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class PlanTab extends ConsumerStatefulWidget {
  final RegularAppModel model;
  const PlanTab({super.key, required this.model});

  @override
  ConsumerState<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends ConsumerState<PlanTab> {
  bool hasSetGoal = false;
  bool showDashboard = false;
  late TextEditingController _goalNameController;
  DateTime? startDate;
  TimeOfDay? startTime;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _targetCountController;
  late TextEditingController _currentCountController;
  late TextEditingController _unitController;
  DateTime? deadlineDate;
  TimeOfDay? deadlineTime;

  @override
  void initState() {
    super.initState();
    _goalNameController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _targetCountController = TextEditingController();
    _currentCountController = TextEditingController();
    _unitController = TextEditingController();
  }

  @override
  void dispose() {
    _goalNameController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _targetCountController.dispose();
    _currentCountController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: showDashboard ? const PlanTabDashboard(): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.height,
          if (!hasSetGoal) ...[
            const Text(
              "Create a Routine",
              style: CustomTextStyle.labelMedium,
            ),
            16.height,
            AppInput(
              minLines: 3,
              maxLines: 5,
              controller: _goalNameController,
              labelText: "What is your goal?",
              labelStyle: context.textTheme.bodySmall,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Goal name is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput.datePicker(
              trailingIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.calendar_today),
              ),
              labelText: "Select Date",
              labelStyle: context.textTheme.bodySmall,
              initialDateTime: startDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateTimeChanged: (value) {
                setState(() {
                  startDate = value;
                });
              },
            ),
            16.height,
            AppInput.timePicker(
              trailingIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.access_time),
              ),
              labelText: "Select Time",
              labelStyle: context.textTheme.bodySmall,
              initialTime: startTime,
              onTimeChanged: (value) {
                setState(() {
                  startTime = value;
                });
              },
            ),
            24.height,
            AppButton(
              onPressed: _createCarePlan,
              child: const Text('Create Care Plan'),
            ),
          ],
          //  Additional Details
          if (hasSetGoal) ...[
            const Text(
              "Provide Additional Details",
              style: CustomTextStyle.labelMedium,
            ),
            16.height,
            AppInput(
              controller: _titleController,
              labelText: "Title",
              labelStyle: context.textTheme.bodySmall,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput(
              minLines: 3,
              maxLines: 5,
              controller: _descriptionController,
              labelText: "Description",
              labelStyle: context.textTheme.bodySmall,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput(
              controller: TextEditingController(text: widget.model.category),
              labelText: "Category",
              labelStyle: context.textTheme.bodySmall,
              readOnly: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Category is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput(
              controller: _targetCountController,
              labelText: "Target",
              labelStyle: context.textTheme.bodySmall,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Target is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput(
              controller: _currentCountController,
              labelText: "Current Value",
              labelStyle: context.textTheme.bodySmall,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Current Value is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput(
              controller: _unitController,
              labelText: "Unit",
              labelStyle: context.textTheme.bodySmall,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Unit is required";
                }
                return null;
              },
            ),
            16.height,
            AppInput.datePicker(
              trailingIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.calendar_today),
              ),
              labelText: "Deadline",
              labelStyle: context.textTheme.bodySmall,
              initialDateTime: deadlineDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateTimeChanged: (value) {
                setState(() {
                  deadlineDate = value;
                });
              },
            ),
            16.height,
            AppInput.timePicker(
              trailingIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.access_time),
              ),
              labelText: "Deadline Time",
              labelStyle: context.textTheme.bodySmall,
              initialTime: deadlineTime,
              onTimeChanged: (value) {
                setState(() {
                  deadlineTime = value;
                });
              },
            ),
            24.height,
            AppButton(
              onPressed: _createGoal,
              child: const Text('Submit Details'),
            ),
          ],
          28.height,
        ],
      ),
    );
  }

  _createGoal() async {
    final currentValue = int.tryParse(_currentCountController.text);
    final targetValue = int.tryParse(_targetCountController.text);
    if (currentValue == null ||
        targetValue == null ||
        _unitController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _unitController.text.isEmpty) {
      context.showFeedBackDialog(message: 'Please fill all fields');
      return;
    }
    final (isSuccess, message) =
        await ref.read(myGoalServiceProvider).createGoal(
              appId: widget.model.id.toString(),
              category: widget.model.category,
              currentValue: currentValue,
              targetValue: targetValue,
              unit: _unitController.text,
              deadlineDate: deadlineDate?.formatDateDash ?? '',
              deadlineTime: deadlineTime?.formatTime(context) ?? '',
              desc: _descriptionController.text,
              title: _titleController.text,
            );
    if (isSuccess) {
      setState(() {
        showDashboard = true;
      });
    } else {
      context.showFeedBackDialog(message: message ?? 'Something went wrong');
    }
  }

  _createCarePlan() async {
    if (startDate == null ||
        startTime == null ||
        _goalNameController.text.isEmpty) {
      context.showFeedBackDialog(message: 'Please fill all fields');
      return;
    }
    final (isSuccess, message) =
        await ref.read(myGoalServiceProvider).createPlan(
              appId: widget.model.id.toString(),
              goal: _goalNameController.text,
              startDate: startDate?.formatDateDash ?? '',
              timeOfDay: startTime?.formatTime(context) ?? '',
            );
    if (isSuccess) {
      setState(() {
        hasSetGoal = true;
      });
    } else {
      context.showFeedBackDialog(message: message ?? 'Something went wrong');
    }
  }
}

// class PlanTab extends StatefulWidget {
//   const PlanTab({super.key});

//   @override
//   State<PlanTab> State() => _PlanTabState();
// }

// class _PlanTabState extends State<PlanTab> {
//   List<RoutineViewModel> routines = [];
//   TextEditingController goalNameController = TextEditingController();
//   List<String> currentRoutineList = [];
//   DateTime? startDate;
//   TimeOfDay? startTime;

//   _addRoutine() {
//     if (startDate == null || startTime == null) {
//       return;
//     }
//     final routine = RoutineViewModel(
//       goalName: goalNameController.text,
//       routineItems: currentRoutineList.map((e) => e).toList(),
//       startDate: startDate!,
//       time: startTime!,
//     );
//     if (routine.validate()) {
//       setState(() {
//         routines.add(routine);
//       });
//       goalNameController.clear();
//       currentRoutineList.clear();
//       startDate = null;
//       startTime = null;
//     } else {
//       context.showFeedBackDialog(message: 'Please fill all fields');
//     }
//   }

//   _removeNewRoutine(int index) {
//     setState(() {
//       routines.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         children: [
//           40.height,
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: Colors.white,
//               border: Border.all(color: AppColors.primaryBorder),
//               boxShadow: const [
//                 BoxShadow(
//                   spreadRadius: 0,
//                   blurRadius: 11,
//                   color: Color(0x40CEBDE4),
//                   offset: Offset(1, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Select a goal for your hair?',
//                         style: context.textTheme.labelSmall?.copyWith(
//                           color: AppColors.greyTextColor3,
//                         ),
//                       ),
//                       Text(
//                         'Selection an option',
//                         style: context.textTheme.bodyMedium?.copyWith(
//                           color: AppColors.greyTextColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 4.width,
//                 SvgPicture.asset('dropdown2'.toSvg),
//               ],
//             ),
//           ),
//           16.height,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Flexible(
//                 child: Text(
//                   "Create a Routine:",
//                   style: CustomTextStyle.labelMedium,
//                 ),
//               ),
//               InkWell(
//                 onTap: _addRoutine,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryLight,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: AppColors.primaryBorder),
//                   ),
//                   child: Row(
//                     children: [
//                       const Text(
//                         "Add Another Routine",
//                         style: TextStyle(
//                           color: Color(0xFF2E2E2E), // Text color #2E2E2E
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       5.width,
//                       const Icon(Icons.add, size: 16, color: Color(0xFF109615)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           12.height,
//           Container(
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(
//                 color: const Color(0xFFA2A2A2),
//                 width: 1,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFEEEEEE), // Background #EEEEEE
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(10)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(4),
//                           border: Border.all(
//                             color: const Color(0xFF109615),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(
//                                     "Enter routine name?",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   TextField(
//                                     controller: goalNameController,
//                                     decoration: const InputDecoration(
//                                       isDense: true,
//                                       border: InputBorder.none,
//                                       hintText: "Enter a routine name",
//                                       hintStyle: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black54,
//                                       ),
//                                     ),
//                                     style: context.textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // InkWell(
//                             //   onTap: () {
//                             //     final newList = [
//                             //       controllers[index].text,
//                             //       ...?routines[index].routine
//                             //     ];
//                             //     routines[index] = RoutineViewModel(
//                             //       goalName: routines[index].goalName,
//                             //       routine: newList,
//                             //       time: routines[index].time,
//                             //       startDate: routines[index].startDate,
//                             //     );
//                             //   },
//                             //   child: RotatedBox(
//                             //     quarterTurns: 3,
//                             //     child: SvgPicture.asset('dropdown2'.toSvg),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                       15.height,
//                       const Text(
//                         "What will you do?",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF2E2E2E),
//                         ),
//                       ),
//                       10.height,
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: currentRoutineList.map((activity) {
//                           return Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(4),
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   activity,
//                                   style: const TextStyle(fontSize: 12),
//                                 ),
//                                 5.width,
//                                 InkWell(
//                                   onTap: () {
//                                     currentRoutineList.remove(activity);
//                                     setState(() {});
//                                   },
//                                   child: const Icon(Icons.close,
//                                       size: 14, color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                       15.height,
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           onTap: () async {
//                             final item = await showDialog<String>(
//                               context: context,
//                               builder: (context) {
//                                 final itemCtrl = TextEditingController();
//                                 return Dialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   insetPadding: const EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 20,
//                                   ),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16, vertical: 12),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             "Add Activity",
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         8.height,
//                                         TextField(
//                                           autofocus: true,
//                                           controller: itemCtrl,
//                                           decoration: InputDecoration(
//                                             focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(6),
//                                               borderSide: const BorderSide(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(6),
//                                             ),
//                                           ),
//                                         ),
//                                         8.height,
//                                         Align(
//                                           alignment: Alignment.centerRight,
//                                           child: ElevatedButton(
//                                             onPressed: () {
//                                               final res = itemCtrl.text;
//                                               Navigator.pop(
//                                                 context,
//                                                 res,
//                                               );
//                                             },
//                                             child: const Text(
//                                               "Add",
//                                               style: TextStyle(
//                                                   color: Colors.black),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                             if (item != null) {
//                               setState(() {
//                                 currentRoutineList.add(item);
//                               });
//                             }
//                             // itemCtrl.dispose();
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryLight, // Light green
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: AppColors.primaryBorder,
//                               ),
//                             ),
//                             child: const Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "Add an Item",
//                                   style: TextStyle(
//                                     color: Color(0xFF2E2E2E),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 SizedBox(width: 4),
//                                 Icon(Icons.add,
//                                     size: 16, color: Color(0xFF109615)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                   decoration: const BoxDecoration(
//                     color: Color(0xffDCF8C6), // Footer green
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(4),
//                       bottomRight: Radius.circular(46),
//                     ),
//                   ),
//                   child: Wrap(
//                     children: [
//                       InkWell(
//                         onTap: () async {
//                           final startTime = await showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay.now(),
//                           );
//                           if (startTime != null) {
//                             setState(() {
//                               this.startTime = startTime;
//                             });
//                           }
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               startTime == null
//                                   ? 'Select start time'
//                                   : "${startTime?.format(context)} Daily",
//                               style: const TextStyle(
//                                 color: Color(0xFF2E2E2E),
//                                 fontSize: 14,
//                               ),
//                             ),
//                             5.width,
//                             SvgPicture.asset(
//                               'clock'.toSvg,
//                               height: 12,
//                               width: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       4.width,
//                       InkWell(
//                         onTap: () async {
//                           final startDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime.now(),
//                             lastDate: DateTime(DateTime.now().year + 1),
//                           );
//                           if (startDate != null) {
//                             setState(() {
//                               this.startDate = startDate;
//                             });
//                           }
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               startDate == null
//                                   ? 'Select start date'
//                                   : DateFormat('dd.MM.yyyy').format(startDate!),
//                               style: context.textTheme.bodyMedium,
//                             ),
//                             5.width,
//                             SvgPicture.asset(
//                               'date'.toSvg,
//                               height: 12,
//                               width: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       6.width,
//                     ],
//                   ),
//                 ),
//               ),
//               42.width
//             ],
//           ),
//           12.height,
//           // Routine List
//           ...List.generate(
//             routines.length,
//             (index) {
//               final thisRoutine = routines[index];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: const Color(0xFFA2A2A2),
//                     width: 2,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFEEEEEE), // Background #EEEEEE
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(10)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(4),
//                               border: Border.all(
//                                 color: const Color(0xFF109615),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         thisRoutine.goalName,
//                                         style: context.textTheme.bodyMedium,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 // InkWell(
//                                 //   onTap: () {
//                                 //     final newList = [
//                                 //       controllers[index].text,
//                                 //       ...?routines[index].routine
//                                 //     ];
//                                 //     routines[index] = RoutineViewModel(
//                                 //       goalName: routines[index].goalName,
//                                 //       routine: newList,
//                                 //       time: routines[index].time,
//                                 //       startDate: routines[index].startDate,
//                                 //     );
//                                 //   },
//                                 //   child: RotatedBox(
//                                 //     quarterTurns: 3,
//                                 //     child: SvgPicture.asset('dropdown2'.toSvg),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           15.height,
//                           const Text(
//                             "What you will do",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Color(0xFF2E2E2E),
//                             ),
//                           ),
//                           10.height,
//                           Wrap(
//                             spacing: 8,
//                             runSpacing: 8,
//                             children: thisRoutine.routineItems.map(
//                               (activity) {
//                                 return Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(4),
//                                     border:
//                                         Border.all(color: Colors.grey.shade300),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         activity,
//                                         style: const TextStyle(fontSize: 12),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 12),
//                             decoration: const BoxDecoration(
//                               color: Color(0xffDCF8C6), // Footer green
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(4),
//                                 bottomRight: Radius.circular(46),
//                               ),
//                             ),
//                             child: Wrap(
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       "${thisRoutine.time.format(context)} Daily",
//                                       style: const TextStyle(
//                                         color: Color(0xFF2E2E2E),
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     5.width,
//                                     SvgPicture.asset(
//                                       'clock'.toSvg,
//                                       height: 12,
//                                       width: 12,
//                                     ),
//                                   ],
//                                 ),
//                                 4.width,
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       DateFormat('dd.MM.yyyy')
//                                           .format(thisRoutine.startDate),
//                                       style: context.textTheme.bodyMedium,
//                                     ),
//                                     5.width,
//                                     SvgPicture.asset(
//                                       'date'.toSvg,
//                                       height: 12,
//                                       width: 12,
//                                     ),
//                                   ],
//                                 ),
//                                 6.width,
//                               ],
//                             ),
//                           ),
//                         ),
//                         16.width,
//                         InkWell(
//                           onTap: () {
//                             _removeNewRoutine(index);
//                           },
//                           child: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                             size: 16,
//                           ),
//                         ),
//                         12.width,
//                       ],
//                     ),
//                     // Container(
//                     //   padding:
//                     //       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                     //   decoration: const BoxDecoration(
//                     //     color: Color(0xffDCF8C6), // Footer green
//                     //     borderRadius:
//                     //         BorderRadius.vertical(bottom: Radius.circular(10)),
//                     //   ),
//                     //   child: Row(
//                     //     children: [
//                     //       const Text(
//                     //         "2.00pm Daily",
//                     //         style: TextStyle(
//                     //           color: Color(0xFF2E2E2E),
//                     //           fontSize: 14,
//                     //         ),
//                     //       ),
//                     //       5.width,
//                     //       const Icon(Icons.access_time,
//                     //           color: Color(0xFF109615), size: 20),
//                     //       const Spacer(),
//                     //       const Text(
//                     //         "09.10.2025",
//                     //         style: TextStyle(
//                     //           color: Color(0xFF2E2E2E),
//                     //           fontSize: 14,
//                     //         ),
//                     //       ),
//                     //       5.width,
//                     //       const Icon(Icons.calendar_today,
//                     //           color: Color(0xFF109615), size: 20),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               );
//             },
//           ),

//           12.height,
//           AppButton(
//             onPressed: () {},
//             child: const Text('Create Care Plan'),
//           ),
//           (context.padding.bottom + 16).height,
//         ],
//       ),
//     );
//   }
// }
