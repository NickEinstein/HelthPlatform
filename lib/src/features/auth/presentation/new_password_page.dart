import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../utils/custom_header.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  String password = "";
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordsMatch = false;
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
                          text: "Reset password",
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
              PasswordTextField(
                label: "Password",
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ConfirmPasswordTextField(
                label: "Confirm Password",
                password: _confirmPasswordController.text,
                onMatchChanged: (isMatching) {
                  setState(() {
                    _passwordsMatch = isMatching;
                  });
                },
              ),
              // ConfirmPasswordTextField(
              //   label: "Confirm Password",
              //   password: password,
              // ),

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
                  // context.push(Routes.OTPPAGE);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Reset password"),
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
