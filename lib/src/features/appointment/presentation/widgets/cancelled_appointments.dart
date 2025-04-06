import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';

class CancelledAppointments extends StatelessWidget {
  final List<dynamic> appointments;

  const CancelledAppointments({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ...appointments.map((appointment) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppointmentCard(
                imageUrl: 'assets/images/doctor1.png', // Optional: dynamic doctor image
                doctorName: appointment['doctor'] ?? 'Unknown Doctor',
                treatment: appointment['description'] ?? 'No Description',
                date: appointment['appointDate'] ?? '',
                time: appointment['appointTime'] ?? '',
                buttonText1: 'Cancel',
                buttonText2: 'Expired',
                showCancelButton: false,
                buttonsDisabled: true,
                onCancel: () {},
                onReschedule: () {},
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
