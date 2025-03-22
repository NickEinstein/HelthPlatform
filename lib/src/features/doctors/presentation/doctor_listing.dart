import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';
import 'widget/doctor_card.dart';

class DoctorListing extends StatefulWidget {
  const DoctorListing({super.key});

  @override
  State<DoctorListing> createState() => _DoctorListingState();
}

class _DoctorListingState extends State<DoctorListing> {
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
                title: 'Ember Wynn',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
              ),
              smallSpace(),
              DoctorCard(
                imageUrl: 'assets/images/doctor1.png',
                name: 'Rodrigo Hartman',
                type: 'Dental Scaling & Polishing',
                profession: 'Dentist',
                hospital: 'National Hospital ABUJA',
                rating: 4.8,
                reviews: 10,
                isShowLove: false,
                isLiked: true,
                onPress: () {},
              ),
              const SizedBox(height: 16),
              Text("About Dr. Ember Wynn",
                  style: TextStyle(
                      color: Color(0xff3C3B3B),
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              tinySpace(),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus, nulla a accumsan at morbi bibendum tortor id a. Nullam amet, ultricies orci ultrices odio condimentum. ",
                  style: TextStyle(
                      color: Color(0xff595959),
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w400)),
              mediumSpace(),
              Text("Working Hours",
                  style: TextStyle(
                      color: Color(0xff3C3B3B),
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              tinySpace(),
              Text("Monday -  Friday 9:00AM - 2:00 PM",
                  style: TextStyle(
                      color: Color(0xff595959),
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w400)),
              mediumSpace(),
              Text("Contact Details",
                  style: TextStyle(
                      color: Color(0xff3C3B3B),
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              smallSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                        color:
                            ColorConstant.primaryLightColor.withOpacity(0.3)),
                    color: ColorConstant.primaryLightColor.withOpacity(0.3)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(color: ColorConstant.primaryColor),
                              color: ColorConstant.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              'assets/icon/message.png',
                              height: 27,
                              width: 27,
                            ),
                          )),
                      tiny5HorSpace(),
                      Text(
                        'Emberwyn45@NHAhospital.com',
                        style: TextStyle(
                          color: Color(0xff595959),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              smallSpace(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                        color:
                            ColorConstant.primaryLightColor.withOpacity(0.3)),
                    color: ColorConstant.primaryLightColor.withOpacity(0.3)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(color: ColorConstant.primaryColor),
                              color: ColorConstant.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              'assets/icon/call.png',
                              height: 27,
                              width: 27,
                            ),
                          )),
                      tiny5HorSpace(),
                      Text(
                        '+23481-785-253',
                        style: TextStyle(
                          color: Color(0xff595959),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
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
                  context.push(Routes.BOOKAPPOINTMENT);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Book Appointment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
