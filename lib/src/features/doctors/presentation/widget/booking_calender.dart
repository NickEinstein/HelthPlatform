import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

class BookingCalendar extends StatefulWidget {
  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';

  List<DateTime> getNext7Days() {
    return List.generate(
        7, (index) => DateTime.now().add(Duration(days: index)));
  }

  List<String> availableTimes = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "03:00 PM",
    "04:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getNext7Days().length,
            itemBuilder: (context, index) {
              DateTime date = getNext7Days()[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                  });
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: selectedDate.day == date.day
                        ? ColorConstant.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: Color(0xffD9D9D94D).withOpacity(0.2)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("dd").format(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedDate.day == date.day
                              ? Colors.white
                              : Color(0xff3C3B3B),
                        ),
                      ),
                      Text(
                        DateFormat("EEE").format(date).toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedDate.day == date.day
                              ? Colors.white
                              : Color(0xff3C3B3B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        mediumSpace(),
        const Text("Available Time",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff3C3B3B),
                fontWeight: FontWeight.w600)),
        smallSpace(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableTimes.map((time) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTime = time;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: selectedTime == time
                      ? ColorConstant.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        selectedTime == time ? Colors.white : Color(0xff616060),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
