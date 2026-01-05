
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenzone_medical/src/features/plan/models/routine_view_model.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl/intl.dart';

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  List<RoutineViewModel> routines = [];
  TextEditingController goalNameController = TextEditingController();
  List<String> currentRoutineList = [];
  DateTime? startDate;
  TimeOfDay? startTime;

  _addRoutine() {
    if (startDate == null || startTime == null) {
      return;
    }
    final routine = RoutineViewModel(
      goalName: goalNameController.text,
      routineItems: currentRoutineList,
      startDate: startDate!,
      time: startTime!,
    );
    print(routine.routineItems);
    print(currentRoutineList);
    if (routine.validate()) {
      setState(() {
        routines.add(routine);
      });
      print(routines.map((e) => e.routineItems).toString());
      goalNameController.clear();
      currentRoutineList.clear();
      startDate = null;
      startTime = null;
    } else {
      context.showFeedBackDialog(message: 'Please fill all fields');
    }
  }

  _removeNewRoutine(int index) {
    setState(() {
      routines.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          40.height,
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              border: Border.all(color: AppColors.primaryBorder),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 11,
                  color: Color(0x40CEBDE4),
                  offset: Offset(1, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a goal for your hair?',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.greyTextColor3,
                        ),
                      ),
                      Text(
                        'Selection an option',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                4.width,
                SvgPicture.asset('dropdown2'.toSvg),
              ],
            ),
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  "Create a Routine:",
                  style: CustomTextStyle.labelMedium,
                ),
              ),
              InkWell(
                onTap: _addRoutine,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryBorder),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Add Another Routine",
                        style: TextStyle(
                          color: Color(0xFF2E2E2E), // Text color #2E2E2E
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      5.width,
                      const Icon(Icons.add, size: 16, color: Color(0xFF109615)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          12.height,
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFFA2A2A2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE), // Background #EEEEEE
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF109615),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Enter routine name?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextField(
                                    controller: goalNameController,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Enter a routine name",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     final newList = [
                            //       controllers[index].text,
                            //       ...?routines[index].routine
                            //     ];
                            //     routines[index] = RoutineViewModel(
                            //       goalName: routines[index].goalName,
                            //       routine: newList,
                            //       time: routines[index].time,
                            //       startDate: routines[index].startDate,
                            //     );
                            //   },
                            //   child: RotatedBox(
                            //     quarterTurns: 3,
                            //     child: SvgPicture.asset('dropdown2'.toSvg),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      15.height,
                      const Text(
                        "What will you do?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E2E2E),
                        ),
                      ),
                      10.height,
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: currentRoutineList.map((activity) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  activity,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                5.width,
                                InkWell(
                                  onTap: () {
                                    currentRoutineList.remove(activity);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.close,
                                      size: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      15.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            final item = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                final itemCtrl = TextEditingController();
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Add Activity",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        8.height,
                                        TextField(
                                          autofocus: true,
                                          controller: itemCtrl,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                        8.height,
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              final res = itemCtrl.text;
                                              Navigator.pop(
                                                context,
                                                res,
                                              );
                                            },
                                            child: const Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            if (item != null) {
                              setState(() {
                                currentRoutineList.add(item);
                              });
                            }
                            // itemCtrl.dispose();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight, // Light green
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primaryBorder,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Add an Item",
                                  style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.add,
                                    size: 16, color: Color(0xFF109615)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xffDCF8C6), // Footer green
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(46),
                    ),
                  ),
                  child: Wrap(
                    children: [
                      InkWell(
                        onTap: () async {
                          final startTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (startTime != null) {
                            setState(() {
                              this.startTime = startTime;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              startTime == null
                                  ? 'Select start time'
                                  : "${startTime?.format(context)} Daily",
                              style: const TextStyle(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                              ),
                            ),
                            5.width,
                            SvgPicture.asset(
                              'clock'.toSvg,
                              height: 12,
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      4.width,
                      InkWell(
                        onTap: () async {
                          final startDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (startDate != null) {
                            setState(() {
                              this.startDate = startDate;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              startDate == null
                                  ? 'Select start date'
                                  : DateFormat('dd.MM.yyyy').format(startDate!),
                              style: context.textTheme.bodyMedium,
                            ),
                            5.width,
                            SvgPicture.asset(
                              'date'.toSvg,
                              height: 12,
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      6.width,
                    ],
                  ),
                ),
              ),
              42.width
            ],
          ),
          12.height,
          ...List.generate(
            routines.length,
            (index) {
              final thisRoutine = routines[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFA2A2A2),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEEEEE), // Background #EEEEEE
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color(0xFF109615),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        thisRoutine.goalName,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     final newList = [
                                //       controllers[index].text,
                                //       ...?routines[index].routine
                                //     ];
                                //     routines[index] = RoutineViewModel(
                                //       goalName: routines[index].goalName,
                                //       routine: newList,
                                //       time: routines[index].time,
                                //       startDate: routines[index].startDate,
                                //     );
                                //   },
                                //   child: RotatedBox(
                                //     quarterTurns: 3,
                                //     child: SvgPicture.asset('dropdown2'.toSvg),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          15.height,
                          const Text(
                            "What you will do",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2E2E2E),
                            ),
                          ),
                          10.height,
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: thisRoutine.routineItems.map(
                              (activity) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        activity,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            decoration: const BoxDecoration(
                              color: Color(0xffDCF8C6), // Footer green
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(46),
                              ),
                            ),
                            child: Wrap(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${thisRoutine.time.format(context)} Daily",
                                      style: const TextStyle(
                                        color: Color(0xFF2E2E2E),
                                        fontSize: 14,
                                      ),
                                    ),
                                    5.width,
                                    SvgPicture.asset(
                                      'clock'.toSvg,
                                      height: 12,
                                      width: 12,
                                    ),
                                  ],
                                ),
                                4.width,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat('dd.MM.yyyy')
                                          .format(thisRoutine.startDate),
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    5.width,
                                    SvgPicture.asset(
                                      'date'.toSvg,
                                      height: 12,
                                      width: 12,
                                    ),
                                  ],
                                ),
                                6.width,
                              ],
                            ),
                          ),
                        ),
                        16.width,
                        InkWell(
                          onTap: () {
                            print(thisRoutine.routineItems);
                            _removeNewRoutine(index);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                        12.width,
                      ],
                    ),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    //   decoration: const BoxDecoration(
                    //     color: Color(0xffDCF8C6), // Footer green
                    //     borderRadius:
                    //         BorderRadius.vertical(bottom: Radius.circular(10)),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Text(
                    //         "2.00pm Daily",
                    //         style: TextStyle(
                    //           color: Color(0xFF2E2E2E),
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //       5.width,
                    //       const Icon(Icons.access_time,
                    //           color: Color(0xFF109615), size: 20),
                    //       const Spacer(),
                    //       const Text(
                    //         "09.10.2025",
                    //         style: TextStyle(
                    //           color: Color(0xFF2E2E2E),
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //       5.width,
                    //       const Icon(Icons.calendar_today,
                    //           color: Color(0xFF109615), size: 20),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
          (context.padding.bottom + 16).height,
        ],
      ),
    );
  }
}
