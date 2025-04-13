import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';
import 'package:greenzone_medical/src/utils/custom_toast.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const RescheduleAppointmentPage({super.key, required this.data});

  @override
  State<RescheduleAppointmentPage> createState() =>
      _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState extends State<RescheduleAppointmentPage> {
  int? selectedReason;
  final TextEditingController _customReasonController = TextEditingController();

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
                    Navigator.pop(context);
                    Navigator.pop(context);
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

  Future<void> handleReschedule() async {
    if (selectedReason == null) {
      CustomToast.show(context, "Please select a reason",
          type: ToastType.warning);
      return;
    }

    final apiService = ApiService();

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy/MM/dd').format(now);
    final formattedTime = DateFormat('HH:mm').format(now);

    final String reason = selectedReason == reasons.length - 1
        ? _customReasonController.text.trim()
        : reasons[selectedReason!];

    if (reason.isEmpty) {
      CustomToast.show(context, "Please enter your reason",
          type: ToastType.warning);
      return;
    }

    try {
      final response = await apiService.put(
        ApiUrl.rescheduleAppointment,
        data: {
          "doctorEmployeeId": widget.data['doctorId'] ?? 0,
          "appointDate": formattedDate,
          "appointTime": formattedTime,
          "healthCareProviderId": widget.data['healthCareProviderId'] ?? 0,
          "description": widget.data['description'] ?? '',
          "id": widget.data['appointmentId'],
          "rescheduleReason": reason,
        },
      );

      if (response.statusCode == 200) {
        showRescheduleSuccessModal(context);
      } else {
        CustomToast.show(context, "Failed to reschedule appointment",
            type: ToastType.error);
      }
    } catch (e) {
      CustomToast.show(context, "An error occurred while rescheduling",
          type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.green.withOpacity(0.1),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: handleReschedule,
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
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Call the Clinic',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
