import 'package:intl/intl.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';

class RescheduleAppointmentPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;

  const RescheduleAppointmentPage({super.key, required this.data});

  @override
  ConsumerState<RescheduleAppointmentPage> createState() =>
      _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState
    extends ConsumerState<RescheduleAppointmentPage> {
  int? selectedReason;
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  final TextEditingController _customReasonController = TextEditingController();
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

  final List<String> reasons = [
    "I'm not available on schedule",
    "I have an activity that can't be left behind",
    "I'm having a schedule clash",
    "I'm not available on schedule",
    "Others",
  ];

  @override
  void dispose() {
    _customReasonController.dispose();
    super.dispose();
  }

  void showRescheduleSuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade100,
                ),
                child: const Icon(Icons.calendar_today,
                    color: Colors.green, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Successfully Rescheduled',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your appointment has been successfully rescheduled.\nYour contact Doctor will call you to confirm your reschedule',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushReplacement(Routes.BOTTOMNAV);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Appointment',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomHeader(
          title: 'Reschedule Appointment',
          onPressed: () => Navigator.pop(context),
          onSearchPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          color: const Color(0x4DD9D9D9).withValues(alpha: 0.2),
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
            smallSpace(),
            const Text(
              'Reason for Schedule Change',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              reasons.length,
              (index) => RadioListTile<int>(
                title: Text(reasons[index]),
                value: index,
                groupValue: selectedReason,
                activeColor: Colors.green,
                onChanged: (int? value) {
                  setState(() => selectedReason = value);
                },
              ),
            ),
            if (selectedReason == reasons.length - 1) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _customReasonController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Please explain your reason...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 30),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedReason == null) {
                          CustomToast.show(context, "Please select a reason",
                              type: ToastType.warning);
                          return;
                        } else if (selectedTime.isEmpty) {
                          CustomToast.show(context, 'Select appointment time',
                              type: ToastType.error);
                        }

                        final apiService = ApiService();

                        final String reason =
                            selectedReason == reasons.length - 1
                                ? _customReasonController.text.trim()
                                : reasons[selectedReason!];

                        if (reason.isEmpty) {
                          CustomToast.show(context, "Please enter your reason",
                              type: ToastType.warning);
                          return;
                        }
                        ref.read(isLoadingProvider.notifier).state = true;

                        try {
                          final response = await apiService.put(
                            ApiUrl.rescheduleAppointment,
                            data: {
                              "doctorEmployeeId": widget.data['doctorId'] ?? 0,
                              "appointDate":
                                  '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                              "appointTime":
                                  convertTo24HourManual(selectedTime),
                              "healthCareProviderId":
                                  widget.data['healthCareProviderId'] ?? 0,
                              "description": widget.data['description'] ?? '',
                              "id": widget.data['appointmentId'],
                              "rescheduleReason": reason,
                            },
                          );
                          ref.read(isLoadingProvider.notifier).state =
                              false; // Stop loading if error

                          if (response.statusCode == 200) {
                            if (context.mounted) {
                              showRescheduleSuccessModal(context);
                            }
                          } else {
                            if (context.mounted) {
                              CustomToast.show(
                                  context, "Failed to reschedule appointment",
                                  type: ToastType.error);
                            }
                          }
                        } catch (e) {
                          ref.read(isLoadingProvider.notifier).state =
                              false; // Stop loading if error
                          if (context.mounted) {
                            CustomToast.show(
                                context, "An error occurred while rescheduling",
                                type: ToastType.error);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            // Center(
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text(
            //       'Call the Clinic',
            //       style: TextStyle(color: Colors.grey, fontSize: 14),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
