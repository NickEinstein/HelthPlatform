import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/healthgoal/presentation/widget/food_alergy.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../routes/routes.dart';
import 'widget/tolerance.dart';

class AboutGoalPage extends StatefulWidget {
  const AboutGoalPage({super.key});

  @override
  State<AboutGoalPage> createState() => _AboutGoalPageState();
}

class _AboutGoalPageState extends State<AboutGoalPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  String title = 'Dietary Restrictions';

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
                  Row(
                    children: [
                      // Back button with green background
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorConstant
                                .primaryLightColor, // Light green color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.keyboard_arrow_left_rounded,
                              color: Colors.white),
                        ),
                      ),

                      // Optional title (if provided)
                      if (title != null) ...[
                        const SizedBox(width: 12), // Spacing
                        Text(
                          _currentIndex == 0 ? title : 'Histamine Tolerance',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff3C3B3B),
                          ),
                        ),
                      ],
                    ],
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

              verticalSpace(context, 0.04),
              // PageView for Steps
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: [
                    FoodAlergy(onNext: _nextPage),
                    TolerancePage(onNext: _nextPage)

                    // PersonalInfoScreen(onNext: _nextPage),
                    // LocationInfoScreen(onNext: _nextPage),
                    // const PasswordScreen(),
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
                          _currentIndex == 2
                              ? "Create Account"
                              : "Get Started"),
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
