import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/constants/api_url.dart';



import '../../../di.dart';





import 'package:greenzone_medical/src/features/appointment/presentation/widgets/cancelled_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/completed_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/upcoming_appointments.dart';
// import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/services/api_service.dart';

class AppointmentPage extends ConsumerStatefulWidget {
  const AppointmentPage({super.key});

  @override
  ConsumerState<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends ConsumerState<AppointmentPage> {
  List<dynamic> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    final authService = ref.read(authServiceProvider);
    final apiService = ApiService();

    try {
      final user = await authService.getStoredUser();

      if (user == null) {
        // print("❌ No user found in storage");
        setState(() => isLoading = false);
        return;
      }

      final userId = user.userId;

      final response = await apiService.get('${ApiUrl.appointment(userId)}');

      print('📦 Raw API response: ${response.data}');

      setState(() {
        appointments = response.data['data'];
        isLoading = false;
      });

      // for (var appt in appointments) {
      //   print(
      //       '🩺 Appointment => Doctor: ${appt['doctor']}, Date: ${appt['appointDate']}, Tracking: ${appt['tracking']}');
      // }
    } catch (e) {
      setState(() => isLoading = false);
      // print("❌ Failed to fetch appointments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text('Appointments', style: TextStyle(color: Colors.black)),
          bottom: const TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  UpcomingAppointments(
                    appointments: appointments
                        .where((appt) => appt['isCanceled'] == null)
                        .toList(),
                  ),
                  CompletedAppointments(
                    // You can filter by 'Completed' if applicable
                    appointments: appointments
                        .where((appt) => appt['isCanceled'] != 'AwaitingVitals')
                        .toList(),
                  ),
                  CancelledAppointments(
                    appointments: appointments
                        .where((appt) => appt['isCanceled'] == true)
                        .toList(),
                  ),
                ],
              ),
      ),
    );
  }
}
