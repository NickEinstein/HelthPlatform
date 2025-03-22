import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomHeader extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final VoidCallback? onSearchPressed; // Optional search button callback

  const CustomHeader({
    Key? key,
    this.title, // Optional title
    required this.onPressed, // Required back button function
    this.onSearchPressed, // Optional search button function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Back button with green background
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryLightColor, // Light green color
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
                  title!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3C3B3B),
                  ),
                ),
              ],
            ],
          ),

          // Optional search icon (if onSearchPressed is provided)
          if (onSearchPressed != null)
            GestureDetector(
              onTap: onSearchPressed,
              child: Image.asset(
                'assets/images/search.png',
                width: 20,
                height: 20,
              ),
            ),
        ],
      ),
    );
  }
}
