import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:greenzone_medical/src/constants/dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthGoalsPager extends StatefulWidget {
  final List<HealthGoalModel> goals;

  const HealthGoalsPager({super.key, required this.goals});

  @override
  _HealthGoalsPagerState createState() => _HealthGoalsPagerState();
}

class _HealthGoalsPagerState extends State<HealthGoalsPager> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160, // Adjust as needed
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.goals.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return _buildHealthGoalCard(widget.goals[index]);
            },
          ),
        ),
        smallSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    : Color(0xffE6E6E6),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: goal.backgroundColor, // Fallback background color
        borderRadius: BorderRadius.circular(12),
        image: isAssetImage
            ? null // Skip loading if it's an asset image
            : DecorationImage(
                image: NetworkImage(goal.imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), // Dark overlay for readability
                  BlendMode.darken,
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              if (goal.onTap != null) {
                String onTapValue = goal.onTap.toString();

                // Check if onTap contains a URL
                if (Uri.tryParse(onTapValue)?.hasAbsolutePath == true) {
                  // It's a valid URL, launch it
                  if (await canLaunchUrl(Uri.parse(onTapValue))) {
                    await launchUrl(Uri.parse(onTapValue));
                  }
                } else {
                  // It's a function, call it normally
                  goal.onTap();
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
