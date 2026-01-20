import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:greenzone_medical/src/constants/dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthGoalsPager extends StatefulWidget {
  final List<HealthGoalModel> goals;

  const HealthGoalsPager({super.key, required this.goals});

  @override
  State<HealthGoalsPager> createState() => _HealthGoalsPagerState();
}

class _HealthGoalsPagerState extends State<HealthGoalsPager>
    with SingleTickerProviderStateMixin {
  // final PageController _pageController = PageController(viewportFraction: 1);
  late PageController _pageController;

  int _currentIndex = 0;
  late Timer _autoSlideTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (!mounted) return;

      int nextIndex = _currentIndex + 1;
      if (nextIndex >= widget.goals.length) nextIndex = 0;

      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _autoSlideTimer.cancel();
    _autoSlideTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.goals.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return AnimatedScale(
                scale: _currentIndex == index ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 300),
                child: _buildHealthGoalCard(widget.goals[index]),
              );
            },
          ),
        ),
        // const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          // scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.goals.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? ColorConstant.primaryColor
                      : const Color(0xffE6E6E6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthGoalCard(HealthGoalModel goal) {
    bool isAssetImage = goal.imagePath.contains("asset");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: goal.backgroundColor,
        borderRadius: BorderRadius.circular(4),
        image: isAssetImage
            ? null
            : DecorationImage(
                image: NetworkImage(goal.imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.3),
                  BlendMode.darken,
                ),
              ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Text and Button
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: goal.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const SizedBox(height: 10), // Adjust spacing if needed
                  Text(
                    goal.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    goal.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffF2F2F2),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      // if (goal.onTap != null) {
                      String onTapValue = goal.onTap.toString();

                      if (Uri.tryParse(onTapValue)?.hasAbsolutePath == true) {
                        if (await canLaunchUrl(Uri.parse(onTapValue))) {
                          await launchUrl(Uri.parse(onTapValue));
                        }
                      } else {
                        goal.onTap();
                      }
                      // }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Text(
                        goal.buttonText,
                        style: const TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating small image
          Positioned(
            top: -35,
            right: 0,
            bottom: 10,
            child: ScaleTransition(
              scale: _pulseAnimation,
              child: Image.asset(
                'assets/images/health_goals.png',
                width: width(context) * 0.33,
                height: height(context) * 0.34,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Model to hold data for each health goal card
class HealthGoalModel {
  final String title;
  final String description;
  final Color backgroundColor;
  final VoidCallback onTap;
  final String buttonText; // Custom button text
  final String imagePath;

  HealthGoalModel({
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.onTap,
    required this.buttonText,
    required this.imagePath,
  });
}
