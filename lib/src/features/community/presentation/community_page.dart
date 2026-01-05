import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Community',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              tinySpace(),
              Image.asset(
                'assets/images/community.png',
              ),
              mediumSpace(),
             const Text("Building a Healthier Community, One Step at a Time",
                  style: TextStyle(
                      color: Color(0xff3C3B3B),
                      fontSize: 24,
                      fontWeight: FontWeight.w700)),
              tinySpace(),
              const Text(
                  "Our community is dedicated to fostering a supportive environment where everyone has access to the resources, knowledge, and encouragement needed to live a healthier life. ",
                  style: TextStyle(
                      color: ColorConstant.secondryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              mediumSpace(),
              smallSpace(),
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
                  context.push(Routes.COMMUNITYLIST);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Get Started"),
              ),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
