import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

class UpcomingAppointments extends StatelessWidget {
  final List<dynamic> appointments;

  const UpcomingAppointments({
    super.key,
    required this.appointments,
  });

  
  @override
  Widget build(BuildContext context) {
    void showCancelModal(BuildContext context, VoidCallback onConfirm) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Cancel Appointment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Are you sure you want to cancel your appointment?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  child: const Text('Yes, Cancel'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ...appointments.map((appointment) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppointmentCard(
                imageUrl: 'assets/images/doctor1.png',
                doctorName: appointment['doctor'] ?? 'Unknown Doctor',
                treatment: appointment['description'] ?? 'No Description',
                date: appointment['appointDate'] ?? '',
                time: appointment['appointTime'] ?? '',
                buttonText1: 'Cancel',
                buttonText2: 'Reschedule',
                onCancel: () {
                  showCancelModal(context, () {
                    // 👉 API call or state update goes here
                    print("Cancelling appointment ID: ${appointment['id']}");
                  });
                },
                onReschedule: () {
                  context.push(Routes.RESCHEDULEAPPOINTMENT);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}