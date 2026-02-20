import 'package:intl/intl.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';

class RescheduleDoctorAppointmentPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;

  const RescheduleDoctorAppointmentPage({super.key, required this.data});

  @override
  ConsumerState<RescheduleDoctorAppointmentPage> createState() =>
      _RescheduleDoctorAppointmentPageState();
}

class _RescheduleDoctorAppointmentPageState
    extends ConsumerState<RescheduleDoctorAppointmentPage> {
  int? selectedReason;
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  bool isInfoExpanded = true;
  final TextEditingController _additionalNoteController =
      TextEditingController();

  List<DateTime> getNext5Days() {
    return List.generate(
        5, (index) => DateTime.now().add(Duration(days: index)));
  }

  List<String> getAvailableTimes() {
    List<String> times = [];
    DateTime now = DateTime.now();
    DateTime startTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9, 0);
    DateTime endTime = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 17, 0);

    while (startTime.isBefore(endTime)) {
      if (selectedDate.day == now.day &&
          selectedDate.month == now.month &&
          selectedDate.year == now.year &&
          startTime.isBefore(now)) {
        startTime = startTime.add(const Duration(hours: 1, minutes: 30));
        continue;
      }

      times.add(DateFormat("hh:mm a").format(startTime));
      startTime = startTime.add(const Duration(hours: 1, minutes: 30));
    }

    return times;
  }

  final List<String> reasons = [
    "I just want to cancel",
    "I have an activity that can't be left behind",
    "I'm having a schedule clash",
    "The Symptoms for the visit is no more",
    "I don't want to fall",
    "Others",
  ];

  @override
  void dispose() {
    _additionalNoteController.dispose();
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

    final existingDate = widget.data['appointDate'] ?? '';
    final existingTime = widget.data['appointTime'] ?? '';
    final purpose = widget.data['description'] ?? '';
    final location = widget.data['location'] ?? '';

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
            // ── Follow-Up Appointment Card ──
            _buildFollowUpCard(existingDate, existingTime, purpose, location),
            const SizedBox(height: 20),

            // ── Reason for Schedule Change ──
            const Text(
              'Reason for Schedule Change',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              reasons.length,
              (index) => RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  reasons[index],
                  style: const TextStyle(fontSize: 14),
                ),
                value: index,
                groupValue: selectedReason,
                activeColor: Colors.green,
                onChanged: (int? value) {
                  setState(() => selectedReason = value);
                },
              ),
            ),

            // ── Additional Note ──
            const SizedBox(height: 12),
            const Text(
              'Additional Note',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withValues(alpha: 0.3),
                ),
              ),
              child: TextField(
                controller: _additionalNoteController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Write additional notes here...",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Date Selector ──
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getNext5Days().length,
                itemBuilder: (context, index) {
                  DateTime date = getNext5Days()[index];
                  bool isSelected = selectedDate.day == date.day &&
                      selectedDate.month == date.month &&
                      selectedDate.year == date.year;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                        selectedTime = '';
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected
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
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xff3C3B3B),
                            ),
                          ),
                          Text(
                            DateFormat("EEE").format(date).toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
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
            const SizedBox(height: 16),

            // ── Time Grid ──
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: getAvailableTimes().map((time) {
                bool isSelected = selectedTime == time;
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
                      color: isSelected
                          ? ColorConstant.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            isSelected ? Colors.white : const Color(0xff616060),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // ── Reschedule Button ──
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
                        }
                        if (selectedTime.isEmpty) {
                          CustomToast.show(context, 'Select appointment time',
                              type: ToastType.error);
                          return;
                        }

                        final String reason =
                            selectedReason == reasons.length - 1
                                ? _additionalNoteController.text.trim()
                                : reasons[selectedReason!];

                        if (selectedReason == reasons.length - 1 &&
                            reason.isEmpty) {
                          CustomToast.show(context, "Please enter your reason",
                              type: ToastType.warning);
                          return;
                        }

                        ref.read(isLoadingProvider.notifier).state = true;

                        try {
                          final apiService = ApiService();
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

                          ref.read(isLoadingProvider.notifier).state = false;

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
                          ref.read(isLoadingProvider.notifier).state = false;
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
                        'Reschedule Appointment',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
            const SizedBox(height: 16),

            // ── Call the Clinic ──
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Call the Clinic',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowUpCard(String existingDate, String existingTime,
      String purpose, String location) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          InkWell(
            onTap: () {
              setState(() => isInfoExpanded = !isInfoExpanded);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Follow-Up Appointment',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff3C3B3B),
                    ),
                  ),
                  Icon(
                    isInfoExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (isInfoExpanded) ...[
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Existing Appointment Date
                  const Text(
                    'Existing Appointment Date',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (existingDate.isNotEmpty || existingTime.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$existingDate  |  $existingTime',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 14),

                  // Purpose of Visit
                  const Text(
                    'Purpose of Visit',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    purpose.isNotEmpty ? purpose : 'No description provided',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff616060),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Location
                  const Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location.isNotEmpty ? location : 'Not specified',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff616060),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
