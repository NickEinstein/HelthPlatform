import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/color_constant.dart';
import '../../../constants/style.dart';
import '../../../routes/routes.dart';
import '../model/onboarding_data.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> rotationAnimation;
  late final PageController pageController;
  static const viewportFraction = 0.7;
  int activeIndex = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: viewportFraction);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
    rotationAnimation =
        Tween<double>(begin: 0, end: 30 * pi / 180).animate(curvedAnimation);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    pageController.dispose(); // Don't forget to dispose it

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width * viewportFraction;

    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTapDown: (_) => animationController.forward(),
                  onTapUp: (_) => animationController.reverse(),
                  child: PageView.builder(
                    controller: pageController, // Use the same controller
                    itemCount: onBoardingItems.length,
                    onPageChanged: (int index) {
                      setState(() {
                        activeIndex = index;
                      });
                      animationController.forward().then(
                            (value) => animationController.reverse(),
                          );
                    },
                    itemBuilder: (context, index) {
                      final isActive = index == activeIndex;
                      return Transform.translate(
                        offset: Offset(0, isActive ? -150 : -40),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: isActive ? 1.1 : 0.9,
                          curve: Curves.easeOut,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(0),
                              image: DecorationImage(
                                image: AssetImage(
                                  onBoardingItems[index].image,
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Indicator, Info, and Button in One Positioned Widget
              Positioned(
                bottom: 30, // Aligns everything to the bottom
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller:
                            pageController, // Ensure it's the same controller
                        count: onBoardingItems.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Color(0xff109815),
                          dotColor: Color(0xffD9D9D9),
                          dotHeight: 6,
                          dotWidth: 6,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: _buildItemInfo(activeIndex: activeIndex),
                      ),
                    ),
                    _buildButtons(), // Button below the text
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )));
  }

  /// Buttons Section
  Widget _buildButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff109815),
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
              side: const BorderSide(color: Color(0xff109815)),
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

  List<Widget> _buildItemInfo({int activeIndex = 0}) {
    return [
      Center(
        child: Text(
          onBoardingItems[activeIndex].title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: ColorConstant.secondryColor,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Center(
        child: Text(
          onBoardingItems[activeIndex].subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xff616060),
          ),
        ),
      ),
      const SizedBox(height: 10),
    ];
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    this.length = 1,
    this.activeIndex = 0,
    this.activeColor = AppColors.primary,
  });

  final int length;
  final int activeIndex;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox.fromSize(
        size: const Size.fromHeight(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.smallest;
            final activeWidth = size.width * 0.5;
            final inActiveWidth =
                (size.width - activeWidth - (2 * length * 2)) / (length - 1);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    height: index == activeIndex ? 8 : 5,
                    width: index == activeIndex ? activeWidth : inActiveWidth,
                    decoration: BoxDecoration(
                      color: index == activeIndex
                          ? activeColor
                          : AppColors.onBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
