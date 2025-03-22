// ==========================
// Reusable Article List
// ==========================
import 'package:flutter/material.dart';

import '../../../../model/article_model.dart';
import 'article_card.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;

  const ArticleList({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleCard(article: articles[index]);
      },
    );
  }
}
