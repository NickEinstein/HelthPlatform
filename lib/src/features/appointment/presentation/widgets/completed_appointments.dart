import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

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
            buttonText2: 'View Doctors report',
            showCancelButton: false,
            onCancel: () {},
            onReschedule: () {},
          ),
          const SizedBox(height: 10),
          AppointmentCard(
            imageUrl: 'assets/images/doctor2.png',
            doctorName: 'Ember Wynn',
            treatment: 'Pediatric Neurology',
            date: 'Wednesday, 15 Mar 2025',
            buttonText1: 'Reschedule',
            buttonText2: 'View Doctors report',
            time: '10:30 AM',
            showCancelButton: false,
            onCancel: () {},
            onReschedule: () {context.push(Routes.DOCTORSREPORT);},
          ),
        ],
      ),
    );
  }
}
