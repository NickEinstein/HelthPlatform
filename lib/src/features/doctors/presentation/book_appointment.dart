import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/services/all_service.dart';
import 'package:intl/intl.dart';

import '../../../constants/helper.dart';
import '../../../model/doctord_list_response.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';

class BookAppointment extends ConsumerStatefulWidget {
  final DoctorListResponse doctor; // Accept doctor data
  BookAppointment({super.key, required this.doctor});

  @override
  ConsumerState<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends ConsumerState<BookAppointment> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  final TextEditingController descriptionController = TextEditingController();

  List<DateTime> getNext7Days() {
    return List.generate(
        7, (index) => DateTime.now().add(Duration(days: index)));
  }

  List<String> getAvailableTimes() {
    List<String> times = [];
    DateTime now = DateTime.now();
    DateTime startTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9, 0);
    DateTime endTime = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 18, 0);

    while (startTime.isBefore(endTime)) {
      // Skip past times if selected date is today
      if (selectedDate.day == now.day &&
          selectedDate.month == now.month &&
          selectedDate.year == now.year &&
          startTime.isBefore(now)) {
        startTime = startTime.add(Duration(hours: 1));
        continue;
      }

      times.add(DateFormat("hh:mm a").format(startTime));
      startTime = startTime.add(Duration(hours: 1));
    }

    return times;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Book Appointment',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
              ),
              smallSpace(),
              // BookingCalendar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getNext7Days().length,
                      itemBuilder: (context, index) {
                        DateTime date = getNext7Days()[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                              selectedTime = ''; // Reset time selection
                            });
                          },
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: selectedDate.day == date.day
                                  ? ColorConstant.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color(0xffD9D9D94D).withOpacity(0.2)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat("dd").format(date),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: selectedDate.day == date.day
                                        ? Colors.white
                                        : Color(0xff3C3B3B),
                                  ),
                                ),
                                Text(
                                  DateFormat("EEE").format(date).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: selectedDate.day == date.day
                                        ? Colors.white
                                        : Color(0xff3C3B3B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  mediumSpace(),
                  const Text("Available Time",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff3C3B3B),
                          fontWeight: FontWeight.w600)),
                  smallSpace(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: getAvailableTimes().map((time) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedTime == time
                                ? ColorConstant.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 14,
                              color: selectedTime == time
                                  ? Colors.white
                                  : Color(0xff616060),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              mediumSpace(),
              // Text("Patient Details",
              //     style: TextStyle(
              //         color: Color(0xff3C3B3B),
              //         fontSize: 15,
              //         fontWeight: FontWeight.w600)),
              // mediumSpace(),
              // const CustomTextField(
              //   label: "Full Name",
              //   hint: "Shedrack Williams",
              // ),
              // mediumSpace(),
              // const CustomDropdown(
              //     label: "Age Bracket",
              //     options: ["15 - 20", "21 - 30", "31 - 50"]),
              // mediumSpace(),
              // const CustomDropdown(
              //     label: "Gender", options: ["Male", "Female"]),
              // mediumSpace(),
              CustomLongTextField(
                label: "Write your Problem",
                hint: "Write your problem",
                controller: descriptionController,
              ),
              verticalSpace(context, 0.08),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        foregroundColor: ColorConstant.primaryColor,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (selectedTime.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          ref.read(isLoadingProvider.notifier).state = true;

                          final allService = ref.read(allServiceProvider);

                          final result = await allService.bookAppointment(
                              healthCareProviderId:
                                  widget.doctor.healthCareProviderId!,
                              doctorEmployeeId: widget.doctor.id!,
                              appointDate:
                                  '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                              appointTime: selectedTime.split(' ')[0],
                              description: descriptionController.text);

                          if (!context.mounted)
                            return; // ✅ Prevents using context if unmounted
                          ref.read(isLoadingProvider.notifier).state =
                              false; // ✅ Stop loading

                          if (result == 'successful') {
                            CustomToast.show(
                                context, 'Appointment Booked Successfully.',
                                type: ToastType.success);

                            context.pushReplacement(Routes.BOTTOMNAV);
                          } else {
                            CustomToast.show(context, result,
                                type: ToastType.error);
                          }
                        } else if (selectedTime.isEmpty) {
                          CustomToast.show(context, 'Select appointment time',
                              type: ToastType.error);
                        } else if (descriptionController.text.isEmpty) {
                          CustomToast.show(context,
                              'Please describe your problem to proceed',
                              type: ToastType.error);
                        }
                        // Add your action here
                        // context.pushReplacement(Routes.BOTTOMNAV);
                      },
                      child: const Text(
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white),
                          "Set Appointment"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
