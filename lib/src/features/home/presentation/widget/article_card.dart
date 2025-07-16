import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

import '../../../../utils/network_img_fallback.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onPressed; // New onPressed parameter

  const ArticleCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    required this.onPressed, // Required onPressed callback
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Handle tap action
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: ShapeDecoration(
          color: const Color(0x51F2F8F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            // Article Image
            NetworkImageWithFallback(
              imageUrl: imageUrl,
              height: 80,
              width: 80,
              borderRadius: 16,
              fallbackAsset: 'assets/images/article_1.png',
            ),

            const SizedBox(width: 12), // Spacing between image & text

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stripHtmlTags(title),
                    style: const TextStyle(
                      color: Color(0xFF3C3A3A),
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      height: 1.29,
                    ),
                    maxLines: 2, // Limits to one line
                    overflow:
                        TextOverflow.ellipsis, // Adds "..." when text overflows
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stripHtmlTags(subtitle),
                    style: const TextStyle(
                      color: Color(0xFF605F5F),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),

            // Arrow Button at the End
            IconButton(
              onPressed: onPressed, // Calls onPressed when tapped
              icon: const Icon(Icons.arrow_forward_ios, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
