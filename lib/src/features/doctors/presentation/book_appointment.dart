import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';
import '../../../model/doctord_list_response.dart';
import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../../health_record/model/appointment_event.dart';

class BookAppointment extends ConsumerStatefulWidget {
  final DoctorListResponse doctor; // Accept doctor data
  const BookAppointment({super.key, required this.doctor});

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
        startTime = startTime.add(const Duration(hours: 1));
        continue;
      }

      times.add(DateFormat("hh:mm a").format(startTime));
      startTime = startTime.add(const Duration(hours: 1));
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
                                color: const Color(0x4DD9D9D9),
                              ),
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
                                        : const Color(0xff3C3B3B),
                                  ),
                                ),
                                Text(
                                  DateFormat("EEE").format(date).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: selectedDate.day == date.day
                                        ? Colors.white
                                        : const Color(0xff3C3B3B),
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
                                  : const Color(0xff616060),
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

                          // Null check for healthCareProviderId and doctorId
                          if (widget.doctor.id == null) {
                            CustomToast.show(context, 'Doctor data is missing.',
                                type: ToastType.error);
                            ref.read(isLoadingProvider.notifier).state =
                                false; // Stop loading if error
                            return;
                          }

                          final result = await allService.bookAppointment(
                            healthCareProviderId:
                                // 5,
                                widget.doctor.healthCareProvider!.id!,
                            doctorEmployeeId: widget.doctor.id!,
                            appointDate:
                                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                            appointTime: convertTo24HourManual(selectedTime),

                            // appointDate:
                            //     '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                            // appointTime: selectedTime.split(' ')[0],
                            description: descriptionController.text,
                          );

                          if (!context.mounted) {
                            return;
                          } // Prevents using context if unmounted
                          ref.read(isLoadingProvider.notifier).state =
                              false; // Stop loading

                          if (result == 'successful') {
                            final appointmentDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              int.parse(selectedTime.split(':')[0]),
                              int.parse(
                                  selectedTime.split(':')[1].split(' ')[0]),
                            );

                            final event = buildAppointmentEvent(
                              title:
                                  'Appointment with Dr. ${widget.doctor.firstName}',
                              description: descriptionController.text,
                              startDateTime: appointmentDateTime,
                            );

                            showInfoBottomSheet(
                              context,
                              '',
                              'Good news! Your appointment with Dr. ${widget.doctor.firstName} has been confirmed.',
                              buttonText: 'Add to Calendar',
                              isAnotherTime: true,
                              onPressed: () async {
                                Navigator.pop(context);
                                await Add2Calendar.addEvent2Cal(event);
                                if (context.mounted) {
                                  context.pushReplacement(Routes.BOTTOMNAV);
                                }
                              },
                            );
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
