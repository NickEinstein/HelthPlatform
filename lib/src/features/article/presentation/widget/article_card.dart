import 'package:flutter/material.dart';

import '../../../../model/article_model.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({required this.article});

  String truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
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
              article.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 8),

          // Category Label
          Text(
            article.category,
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          // Article Title
          Text(
            article.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 5),

          // Article Description (Max 80 characters)
          // Text(
          //   truncateText(article.description, 80),
          //   style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          //   maxLines: 3,
          //   overflow: TextOverflow.ellipsis,
          // ),

          // SizedBox(height: 5),

          // Date & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.date,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                article.timeAgo,
                style: TextStyle(color: Colors.green[800], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
