// // ==========================
// // Reusable Article List
// // ==========================
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:greenzone_medical/src/model/article_response.dart';

// import 'article_card.dart';

// class ArticleList extends StatelessWidget {
//   final List<ArticleResponse> articles;

//   const ArticleList({super.key, required this.articles});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final articleState = ref.watch(articleProvider);

//     return articleState.when(
//       data: (articles) {
//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: articles.length,
//           itemBuilder: (context, index) {
//             return ArticleCard(article: articles[index]);
//           },
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (error, stackTrace) => Center(child: Text('Error: $error')),
//     );
//   }
// }

// ==========================
// Reusable Article List
// ==========================
import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/model/article_response.dart';

import 'article_card.dart';

class ArticleList extends StatelessWidget {
  final List<ArticleResponse> articles;

  const ArticleList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            articles.map((article) => ArticleCard(article: article)).toList(),
      ),
    );
  }
}
