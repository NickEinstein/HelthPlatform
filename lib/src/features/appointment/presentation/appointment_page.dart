import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/cancelled_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/completed_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/upcoming_appointments.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:
              const Text('Appointments', style: TextStyle(color: Colors.black)),
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
        body: const TabBarView(
          children: [
            SingleChildScrollView(
              child: UpcomingAppointments(),
            ),
            SingleChildScrollView(
              child: CompletedAppointments(),
            ),
            SingleChildScrollView(
              child: CancelledAppointments(),
            ),
          ],
        ),
      ),
    );
  }
}
