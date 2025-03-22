import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Page Indicator
              CustomHeader(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              smallSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Forgot password",
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontWeight: FontWeight.w500,
                              fontSize: 24),
                        ),
                        TextSpan(
                          text: "",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: ColorConstant
                                  .primaryColor), // Change color here
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              smallSpace(),
              const Text(
                "Enter your email address we will send a 4 digit code to reset your password",
                style: TextStyle(
                    color: ColorConstant.secondryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              mediumSpace(),
              const CustomTextField(
                label: "Email Address",
                hint: "example@example.com",
              ),

              mediumSpace(),
              smallSpace(),

              // PageView for Steps
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
                  context.push(Routes.OTPPAGE);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Send Code"),
              ),
              smallSpace(),

              // Navigation Buttons
            ],
          ),
        ),
      ),
    );
  }
}
