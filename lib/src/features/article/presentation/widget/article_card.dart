import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../model/article_response.dart';

import 'package:intl/intl.dart';

import '../../../../routes/routes.dart';

class ArticleCard extends StatelessWidget {
  final ArticleResponse article;

  const ArticleCard({required this.article});

  String formatDateTime(String dateTimeStr) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeStr);
      String formattedDate =
          DateFormat('MMM dd, yyyy').format(dateTime); // e.g., Mar 26, 2025
      String formattedTime =
          DateFormat('h:mm a').format(dateTime); // e.g., 2:35 AM
      return "$formattedDate • $formattedTime";
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.ARTICLEDETAILS, extra: {
          "title": article.title,
          "description": article.fullDescription,
          "imageUrl": "assets/images/article_1.png",
        });
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/article_1.png',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            // Category Label
            Text(
              article.category.name,
              style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // Article Title
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 5),

            // Date & Time
            Text(
              formatDateTime(article.publishedDate),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
