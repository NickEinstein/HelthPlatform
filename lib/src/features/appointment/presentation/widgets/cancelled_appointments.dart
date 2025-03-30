import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';

class CancelledAppointments extends StatelessWidget {
  const CancelledAppointments({super.key});

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
            showCancelButton:false,
            buttonText2: 'Reschedule',
            buttonsDisabled:true,
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
            buttonText2: 'Reschedule',
            buttonsDisabled:true,
            showCancelButton:false,
            time: '10:30 AM',
            onCancel: () {},
            onReschedule: () {},
          ),
        ],
      ),
    );
  }
}
