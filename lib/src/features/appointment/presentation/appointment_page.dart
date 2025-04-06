import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/cancelled_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/completed_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/upcoming_appointments.dart';
import 'package:greenzone_medical/src/services/api_service.dart';
import 'package:greenzone_medical/src/constants/api_url.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List<dynamic> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
  final apiService = ApiService(); // or use your provider/service locator

  try {
    final response = await apiService.get(ApiUrl.appointment);
    
    // ✅ Pretty-print response data
    print('📦 Raw API response: ${response.data}');
    
    setState(() {
      appointments = response.data['data'];
      isLoading = false;
    });

    // ✅ Optional: Print each appointment nicely
    for (var appt in appointments) {
      print('🩺 Appointment => Doctor: ${appt['doctor']}, Date: ${appt['appointDate']}, Tracking: ${appt['tracking']}');
    }

  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print("❌ Failed to fetch appointments: $e");
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
                    appointments: appointments.where((appt) => appt['tracking'] == 'AwaitingVitals').toList(),
                  ),
                  CompletedAppointments(
                    // appointments: appointments.where((appt) => appt['tracking'] == 'Completed').toList(),
                  ),
                  CancelledAppointments(
                    appointments: appointments.where((appt) => appt['isCanceled'] == true).toList(),
                  ),
                ],
              ),
      ),
    );
  }
}
