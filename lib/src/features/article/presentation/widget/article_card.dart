import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/helper.dart';
import '../../../../model/article_response.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/network_img_fallback.dart';

class ArticleCard extends StatelessWidget {
  final ArticleResponse article;

  const ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.ARTICLEDETAILS, extra: article);
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            const BoxShadow(
              color: Colors.transparent,
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            NetworkImageWithFallback(
              imageUrl: article.featuredImagePath!,
              height: 120,
              width: double.infinity,
              borderRadius: 16,
              fallbackAsset: 'assets/images/article_1.png',
            ),

            const SizedBox(height: 8),

            // Category Label
            Text(
              article.category!.name!,
              style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // Article Title
            Text(
              article.title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 5),

            // Date & Time
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: formatDate(article.publishedDate!),
                    style: TextStyle(
                        color: Color(0xff3C3B3B),
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  TextSpan(
                    text: formatTimeAgo(article.publishedDate!),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: ColorConstant.primaryColor), // Change color here
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
