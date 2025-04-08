import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

class CompletedAppointments extends StatelessWidget {
  final List<dynamic> appointments;

  const CompletedAppointments({
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
                imageUrl: 'assets/images/doctor2.png',
                doctorName: appointment['doctor'] ?? 'Unknown Doctor',
                treatment: appointment['description'] ?? 'No Description',
                date: appointment['appointDate'] ?? '',
                time: appointment['appointTime'] ?? '',
                buttonText1: 'Reschedule',
                buttonText2: 'View Doctor\'s Report',
                showCancelButton: false,
                onCancel: () {},
                onReschedule: () => context.push(Routes.DOCTORSREPORT),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
