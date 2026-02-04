// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:add_2_calendar_new/add_2_calendar_new.dart';

Event buildAppointmentEvent({
  required String title,
  required String description,
  required DateTime startDateTime,
}) {
  return Event(
    title: title,
    description: description,
    location: 'Clinic',
    startDate: startDateTime,
    endDate: startDateTime.add(const Duration(minutes: 30)),
    allDay: false,
  );
}
