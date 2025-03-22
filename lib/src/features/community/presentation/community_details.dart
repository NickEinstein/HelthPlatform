import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

import '../../../utils/custom_header.dart';

class CommunityDetails extends StatefulWidget {
  const CommunityDetails({super.key});

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails> {
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
                title: 'Fitness & Wellness',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  context.push(Routes.SEARCHCOMMUNITY);
                  // Handle search button press
                },
              ),
              smallSpace(),
              Image.asset('assets/images/fitnessfull.png'),
              smallSpace(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Fitness & Wellness",
                      style: TextStyle(
                          color: Color(0xff3C3B3B),
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  tiny5Space(),
                  const Text("Public. 560 members. 6 posts a year",
                      style: TextStyle(
                          color: Color(0xff595959),
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  mediumSpace(),
                  const Text("About",
                      style: TextStyle(
                          color: Color(0xff3C3B3B),
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  tiny5Space(),
                  const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus, nulla a accumsan at morbi bibendum tortor id a. ",
                      style: TextStyle(
                          color: Color(0xff595959),
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  mediumSpace(),
                  const Text("Group Activity",
                      style: TextStyle(
                          color: Color(0xff3C3B3B),
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  tiny5Space(),
                  const Text("Created about 5 weeks ago",
                      style: TextStyle(
                          color: Color(0xff595959),
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 16),
              verticalSpace(context, 0.2),
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
                    "Join Group"),
              ),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
