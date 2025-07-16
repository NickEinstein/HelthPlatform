import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:intl/intl.dart';

import '../../../../utils/packages.dart';
import '../../model/appointment_model.dart';

class CompletedAppointments extends StatelessWidget {
  final List<AppointmentResponse> appointments;

  const CompletedAppointments({
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
            'No completed appointment',
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
          // Iterate over the list of appointments
          ...appointments.asMap().entries.map((entry) {
            final index = entry.key;
            final appointment = entry.value;

            final dateTime = DateFormat('M/d/yyyy HH:mm')
                .parse('${appointment.appointDate} ${appointment.appointTime}');

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppointmentCard(
                appointment: appointment,
                imageUrl: 'assets/images/doctor2.png',
                doctorName: appointment.doctor ?? 'Unknown Doctor',
                treatment: appointment.description ?? 'No Description',
                date: DateFormat('EEEE, MMM d yyyy').format(dateTime),
                time: DateFormat('hh:mm a').format(dateTime),
                buttonText1: 'Reschedule',
                buttonText2: 'View Doctor\'s Report',
                showCancelButton: false,
                showRating: true, // ✅ show rating only on last one
                isDischargedNote:
                    appointment.dischargeNotes?.isNotEmpty ?? false,
                onCancel: () {},
                onReschedule: () {
                  showInfoBottomSheet(
                    context,
                    'Discharge Note',
                    appointment.dischargeNotes!,
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
