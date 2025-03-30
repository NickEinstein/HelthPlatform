import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 16),
          AppointmentCard(
            imageUrl: 'assets/images/doctor1.png',
            doctorName: 'Rodrigo Hartman',
            treatment: 'Dental Scaling & Polishing',
            date: 'Today',
            time: '20:00 PM',
            buttonText1: 'Reschedule',
            buttonText2: 'Reschedule',
            onCancel: () {},
            onReschedule: () {
              context.push(Routes.RESCHEDULEAPPOINTMENT);
            },
          ),
          const SizedBox(height: 10),
          AppointmentCard(
            imageUrl: 'assets/images/doctor2.png',
            doctorName: 'Ember Wynn',
            treatment: 'Pediatric Neurology',
            date: 'Wednesday, 15 Mar 2025',
            time: '10:30 AM',
            buttonText1: 'Reschedule',
            buttonText2: 'Reschedule',
            onCancel: () {},
            onReschedule: () {},
          ),
        ],
      ),
    );
  }
}
