import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../routes/routes.dart';
import 'widget/location_info_screen.dart';
import 'widget/password_screen.dart';
import 'widget/personal_info_screen.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle final submission or navigation to next screen
      print("Account Created! Navigate to the next screen.");
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

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
                          text: "Create ",
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontWeight: FontWeight.w500,
                              fontSize: 24),
                        ),
                        TextSpan(
                          text: "Account",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: ColorConstant
                                  .primaryColor), // Change color here
                        ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotColor: ColorConstant.primaryLightColor,
                      activeDotColor: ColorConstant.primaryColor,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "Please provide the following information to get started",
                style: TextStyle(
                    color: ColorConstant.secondryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              // PageView for Steps
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: [
                    PersonalInfoScreen(onNext: _nextPage),
                    LocationInfoScreen(onNext: _nextPage),
                    const PasswordScreen(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Navigation Buttons
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _nextPage,
                      child: Text(
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                          _currentIndex == 2 ? "Create Account" : "Proceed"),
                    ),
                    if (_currentIndex > 0)
                      TextButton(
                        onPressed: _previousPage,
                        child: const Text(
                          "Back",
                          style: TextStyle(color: ColorConstant.primaryColor),
                        ),
                      ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          const TextSpan(
                            text: "I have an account? ",
                            style: TextStyle(
                              color: Color(0xff595959),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Log in",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant
                                  .primaryColor, // Make it look like a link
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushReplacement(Routes.SIGNIN);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
