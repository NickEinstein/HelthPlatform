import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/cancelled_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/completed_appointments.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/upcoming_appointments.dart';
import 'package:intl/intl.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';

class AppointmentPage extends ConsumerStatefulWidget {
  final bool showBackButton;

  const AppointmentPage({super.key, this.showBackButton = false});

  @override
  ConsumerState<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends ConsumerState<AppointmentPage> {
  @override
  void initState() {
    super.initState();

    // Force refresh when the screen is opened
    Future.microtask(() => ref.refresh(userAppointmentProvider));
  }

  @override
  Widget build(BuildContext context) {
    final appointmentAsync = ref.watch(userAppointmentProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              if (widget.showBackButton)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    decoration: BoxDecoration(
                      color:
                          ColorConstant.primaryLightColor, // Light green color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.keyboard_arrow_left_rounded,
                        color: Colors.white),
                  ),
                ),
              smallHorSpace(),
              const Text(
                'Appointments',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          bottom: const TabBar(
            labelColor: ColorConstant.primaryColor,
            unselectedLabelColor: Color(0xff444444),
            indicatorColor: ColorConstant.primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            tabs: [
              Tab(
                text: 'Upcoming',
              ),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: appointmentAsync.when(
          data: (appointments) {
            final now = DateTime.now();

            final dateTimeFormat = DateFormat('M/d/yyyy HH:mm');

            DateTime? _combineDateTime(String date, String time) {
              try {
                return dateTimeFormat.parse('$date $time');
              } catch (e) {
                return null; // Handle invalid formats if needed
              }
            }

            final upcoming = appointments.where((appt) {
              final dateTime =
                  _combineDateTime(appt.appointDate!, appt.appointTime!);
              return dateTime != null &&
                  !(appt.isCanceled ?? false) &&
                  dateTime.isAfter(now);
            }).toList();

            final completed = appointments.where((appt) {
              final dateTime =
                  _combineDateTime(appt.appointDate!, appt.appointTime!);
              return dateTime != null &&
                  !(appt.isCanceled ?? false) &&
                  dateTime.isBefore(now);
            }).toList();

            final cancelled = appointments
                .where((appt) => (appt.isCanceled ?? false))
                .toList();

            return TabBarView(
              children: [
                Container(
                  color: Colors.transparent,
                  child: UpcomingAppointments(appointments: upcoming),
                  // child: UpcomingAppointments(appointments: cancelled),
                ),
                Container(
                  color: Colors.transparent,
                  child: CompletedAppointments(appointments: completed),
                  // child: CompletedAppointments(appointments: cancelled),
                ),
                Container(
                  color: Colors.transparent,
                  child: CancelledAppointments(appointments: cancelled),
                ),
              ],
            ).animate().slideY(begin: 1.0, end: 0, duration: 600.ms).fadeIn();
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const Center(
            child: Text("Error loading appointments"),
          ),
        ),
      ),
    );
  }
}
