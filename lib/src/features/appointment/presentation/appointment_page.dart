import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/constants/api_url.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/cancelled_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/completed_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/upcoming_appointments.dart';
import 'package:greenzone_medical/src/services/api_service.dart';

import '../../../di.dart';

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
        setState(() => isLoading = false);
        return;
      }

      final userId = user.userId;
      final response = await apiService.get(ApiUrl.appointment(userId));

      setState(() {
        appointments = response.data['data'];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // 🌿 Global background color
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Appointments',
            style: TextStyle(color: Colors.black),
          ),
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
                  // ✅ Each child must use transparent bg to let the main bg show
                  Container(
                    color: Colors.transparent,
                    child: UpcomingAppointments(
                      appointments: appointments
                          .where((appt) => appt['isCanceled'] == null)
                          .toList(),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: CompletedAppointments(
                      appointments: appointments
                          .where(
                            (appt) =>
                                appt['isCanceled'] != true &&
                                appt['isCanceled'] != 'AwaitingVitals',
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: CancelledAppointments(
                      appointments: appointments
                          .where((appt) => appt['isCanceled'] == true)
                          .toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
