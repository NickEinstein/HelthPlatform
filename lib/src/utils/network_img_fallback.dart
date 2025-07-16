import 'package:flutter/material.dart';

import '../constants/app_constant.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final String fallbackAsset;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.borderRadius = 16,
    this.fallbackAsset = 'assets/images/article_1.png',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl.startsWith('http')
            ? imageUrl
            : '${AppConstants.noSlashImageURL}$imageUrl',
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          fallbackAsset,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
