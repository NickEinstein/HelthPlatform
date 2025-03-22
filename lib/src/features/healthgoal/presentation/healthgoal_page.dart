import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';

class HealthGoalPage extends StatefulWidget {
  const HealthGoalPage({super.key});

  @override
  State<HealthGoalPage> createState() => _HealthGoalPageState();
}

class _HealthGoalPageState extends State<HealthGoalPage> {
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
                title: 'Health Goal',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              mediumSpace(),
              Image.asset(
                'assets/images/healthgoal.png',
              ),
              mediumSpace(),
              Row(
                children: [
                  Text("Your Health, Your Journey",
                      style: TextStyle(
                          color: Color(0xff3C3B3B),
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              tinySpace(),
              Text(
                  "Everyone’s health journey is unique. Whether you’re looking to stay active, eat healthier, improve mental well-being, or build lasting habits, we’re here to support you. Let’s start by understanding your health goals! ",
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
                  context.push(Routes.ABOUTHEALTH);
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
