import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../model/appointment_model.dart';

class UpcomingAppointments extends StatelessWidget {
  final List<AppointmentResponse> appointments;

  final void Function()? onRefresh;

  const UpcomingAppointments({
    super.key,
    required this.appointments,
    this.onRefresh,
  });

  void showCancelModal(BuildContext context, String appointmentId) {
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
                'Are you sure you want to cancel your \nappointment?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC53030),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  context.pushNamed(
                    Routes.REASONCANCELAPPOINTMENT,
                    extra: {
                      'appointmentId': appointmentId,
                      'onRefresh': onRefresh,
                      'isCanceled': true
                    },
                  );

                  // try {
                  //   final apiService = ApiService();
                  //   final now = DateTime.now();
                  //   final formattedDate = DateFormat('yyyy/MM/dd').format(now);
                  //   final formattedTime = DateFormat('HH:mm').format(now);

                  //   final response = await apiService.put(
                  //     ApiUrl.cancelAppointment,
                  //     data: {
                  //       "id": appointmentId,
                  //       "isCanceled": true,
                  //       "healthCareProviderId": 0,
                  //       "canceledDate": formattedDate,
                  //       "canceledTime": formattedTime,
                  //     },
                  //   );

                  //   if (response.statusCode == 200) {
                  //     showSuccessModal(context);
                  //     if (onRefresh != null) {
                  //       onRefresh!();
                  //     }
                  //   } else {
                  //     CustomToast.show(
                  //       context,
                  //       "Failed to cancel appointment",
                  //       type: ToastType.error,
                  //     );
                  //   }
                  // }
                  // catch (e) {
                  //   CustomToast.show(
                  //     context,
                  //     "An error occurred while cancelling",
                  //     type: ToastType.error,
                  //   );
                  // }
                },
                child: const Text(
                  'Yes, Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFED7D7),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255), // ✅ background color
      child: appointments.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'No upcoming appointment',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ...appointments.map((appointment) {
                    final dateTime = DateFormat('M/d/yyyy HH:mm').parse(
                        '${appointment.appointDate} ${appointment.appointTime}');

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
                        buttonText2: 'Reschedule',
                        showRating: false,
                        onCancel: () {
                          showCancelModal(context, appointment.id.toString());
                        },
                        onReschedule: () {
                          context.push(
                            Routes.RESCHEDULEAPPOINTMENT,
                            extra: {
                              'appointmentId': appointment.id,
                              'healthCareProviderId':
                                  appointment.healthCareProviderId,
                              'doctorId': appointment.doctorId ?? '',
                              'description': appointment.description ?? '',
                            },
                          );
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
