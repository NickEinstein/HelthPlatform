import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:greenzone_medical/src/constants/api_url.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';
import 'package:greenzone_medical/src/services/api_service.dart';
import 'package:greenzone_medical/src/utils/custom_toast.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/appointment_card.dart';

class UpcomingAppointments extends StatelessWidget {
  final List<dynamic> appointments;
  final void Function()? onRefresh;

  const UpcomingAppointments({
    super.key,
    required this.appointments,
    this.onRefresh,
  });

  void showSuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 60),
            const SizedBox(height: 10),
            const Text(
              'Successfully Cancelled',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are sad that you have to cancel your appointment',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child:
                  const Text('Thank you', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

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
                'Are you sure you want to cancel your appointment?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();

                  try {
                    final apiService = ApiService();
                    final now = DateTime.now();
                    final formattedDate = DateFormat('yyyy/MM/dd').format(now);
                    final formattedTime = DateFormat('HH:mm').format(now);

                    final response = await apiService.put(
                      ApiUrl.cancelAppointment,
                      data: {
                        "id": appointmentId,
                        "isCanceled": true,
                        "healthCareProviderId": 0,
                        "canceledDate": formattedDate,
                        "canceledTime": formattedTime,
                      },
                    );

                    if (response.statusCode == 200) {
                      showSuccessModal(context);
                      if (onRefresh != null) {
                        onRefresh!();
                      }
                    } else {
                      CustomToast.show(
                        context,
                        "Failed to cancel appointment",
                        type: ToastType.error,
                      );
                    }
                  } catch (e) {
                    CustomToast.show(
                      context,
                      "An error occurred while cancelling",
                      type: ToastType.error,
                    );
                    print("❌ Cancel error: $e");
                  }
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
                imageUrl: 'assets/images/doctor1.png',
                doctorName: appointment['doctor'] ?? 'Unknown Doctor',
                treatment: appointment['description'] ?? 'No Description',
                date: appointment['appointDate'] ?? '',
                time: appointment['appointTime'] ?? '',
                buttonText1: 'Cancel',
                buttonText2: 'Reschedule',
                onCancel: () {
                  showCancelModal(context, appointment['id'].toString());
                },
                onReschedule: () {
                  context.push(
                    Routes.RESCHEDULEAPPOINTMENT,
                    extra: {
                      'appointmentId': appointment['id'],
                      'healthCareProviderId':
                          appointment['healthCareProviderId'],
                      'doctorId': appointment['doctorId'] ?? '',
                      'description': appointment['description'] ?? '',
                    },
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
