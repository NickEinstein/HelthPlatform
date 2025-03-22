import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../routes/routes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                          text: "Login ",
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
                "Please provide the following information to get started",
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
              LoginPasswordTextField(
                label: "Password",
                password: password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      context.push(Routes.RESETPASSWORD);
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Color(0xffFFA500),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              mediumSpace(),

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
                  // Add your action here
                  context.pushReplacement(Routes.BOTTOMNAV);
                },
                child: const Text(
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                    "Proceed"),
              ),
              smallSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(
                          text: "Do not have an account? ",
                          style: TextStyle(
                              color: Color(0xff595959),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        TextSpan(
                          text: "Create Account",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement(Routes.ACCOUNTCREATION);
                            },
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant
                                  .primaryColor), // Change color here
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // Navigation Buttons
            ],
          ),
        ),
      ),
    );
  }
}
