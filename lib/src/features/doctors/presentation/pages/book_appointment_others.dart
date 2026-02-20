// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import '../../../../utils/packages.dart';

class BookAppointmentOthers extends ConsumerStatefulWidget {
  final String from;
  const BookAppointmentOthers({super.key, required this.from});

  @override
  ConsumerState<BookAppointmentOthers> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends ConsumerState<BookAppointmentOthers> {
  @override
  Widget build(BuildContext context) {
    // final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(context, 0.08),
                CustomHeader(
                  title: 'Book Appointment',
                  onPressed: () {
                    // Handle back button press
                    Navigator.pop(context);
                  },
                ),
                smallSpace(),
                // BookingCalendar(),
                Column(children: [
                  Center(
                    child: Text(
                      '${widget.from} is unavailable',
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ]),
              ]),
        ),
      ),
    );
  }
}
