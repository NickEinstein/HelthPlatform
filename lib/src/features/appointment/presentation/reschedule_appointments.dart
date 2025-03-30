import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';

class RescheduleAppointmentPage extends StatefulWidget {
  const RescheduleAppointmentPage({super.key});

  @override
  State<RescheduleAppointmentPage> createState() =>
      _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState extends State<RescheduleAppointmentPage> {
  int? selectedReason;

  final List<String> reasons = [
    "I'm not available on schedule",
    "I have an activity that can't be left behind",
    "I'm having a schedule clash",
    "I'm not available on schedule",
    "Others",
  ];

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
          onPressed: () {
            Navigator.pop(context);
          },
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
                child: const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
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
                onPressed: () {},
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
