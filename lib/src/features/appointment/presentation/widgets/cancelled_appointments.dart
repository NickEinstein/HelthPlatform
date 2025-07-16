import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:intl/intl.dart';

import '../../model/appointment_model.dart';

class CancelledAppointments extends StatelessWidget {
  final List<AppointmentResponse> appointments;

  const CancelledAppointments({
    super.key,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text(
            'No canceled appointment',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ...appointments.map((appointment) {
            final dateTime = DateFormat('M/d/yyyy HH:mm')
                .parse('${appointment.appointDate} ${appointment.appointTime}');

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppointmentCard(
                appointment: appointment,
                imageUrl: 'assets/images/doctor1.png',
                doctorName: appointment.doctor ?? 'Unknown Doctor',
                treatment: appointment.description ?? 'No Description',
                date: DateFormat('EEEE, MMM d yyyy').format(dateTime),
                time: DateFormat('hh:mm a').format(dateTime),
                buttonText1: 'Cancel',
                buttonText2: 'Expired',
                showCancelButton: false,
                buttonsDisabled: true,
                showRating: false,
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
