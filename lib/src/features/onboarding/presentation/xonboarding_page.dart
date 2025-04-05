import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../routes/app_pages.dart';

class XOnboardingPage extends StatefulWidget {
  const XOnboardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _XOnboardingPageState createState() => _XOnboardingPageState();
}

class _XOnboardingPageState extends State<XOnboardingPage> {
  final PageController _controller = PageController(
    viewportFraction: 1.0, // Ensure each page takes full width
  );
  int _currentIndex = 0;
  Timer? _timer; // Timer for auto-transition
  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _onboardingData.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop timer when widget is disposed
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/doctor_1.png",
      "title": "Better Health, Connected",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
    },
    {
      "image": "assets/images/doctor_2.png",
      "title": "Get Medical Assistance Anytime",
      "description":
          "Access trusted medical help whenever you need it, from anywhere."
    },
    {
      "image": "assets/images/doctor_3.png",
      "title": "Book Appointments Easily",
      "description":
          "Schedule consultations with experienced doctors at your convenience."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen image
          PageView.builder(
            controller: _controller,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 230),
                child: Image.asset(
                  _onboardingData[index]["image"]!,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width, // Ensure full width
                ),
              );
            },
          ),

          // Bottom white section with rounded corners
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _onboardingData.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: ColorConstant.primaryColor,
                      dotColor: ColorConstant.primaryLightColor,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    _onboardingData[_currentIndex]["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Description
                  Text(
                    _onboardingData[_currentIndex]["description"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorConstant.secondryColor,
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.space26,
                  ),

                  // Buttons
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Buttons Section
  Widget _buildButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              // Navigate to sign-up screen
              context.push(Routes.ACCOUNTCREATION);
            },
            child: const Text("Create Account",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              side: const BorderSide(color: ColorConstant.primaryColor),
            ),
            onPressed: () {
              // Navigate to login screen
              context.push(Routes.SIGNIN);
            },
            child: const Text("Login",
                style:
                    TextStyle(fontSize: 16, color: ColorConstant.primaryColor)),
          ),
        ),
      ],
    );
  }
}
