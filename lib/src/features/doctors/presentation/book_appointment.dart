import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../utils/custom_header.dart';
import 'widget/booking_calender.dart';
import 'widget/doctor_card.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
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
              BookingCalendar(),
              mediumSpace(),
              Text("Patient Details",
                  style: TextStyle(
                      color: Color(0xff3C3B3B),
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              mediumSpace(),
              const CustomTextField(
                label: "Full Name",
                hint: "Shedrack Williams",
              ),
              mediumSpace(),
              const CustomDropdown(
                  label: "Age Bracket",
                  options: ["15 - 20", "21 - 30", "31 - 50"]),
              mediumSpace(),
              const CustomDropdown(
                  label: "Gender", options: ["Male", "Female"]),
              mediumSpace(),
              const CustomLongTextField(
                label: "Write your Problem",
                hint: "Write your problem",
              ),
              verticalSpace(context, 0.08),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor,
                  foregroundColor: ColorConstant.primaryColor,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Add your action here
                  // context.pushReplacement(Routes.BOTTOMNAV);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Set Appointment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
