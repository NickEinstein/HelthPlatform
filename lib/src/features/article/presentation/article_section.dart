import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

import '../../home/presentation/widget/article_card.dart';
import '../../../provider/all_providers.dart';

class ArticlesSection extends ConsumerWidget {
  const ArticlesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Articles",
              style: TextStyle(
                color: ColorConstant.secondryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            // TextButton(
            //   onPressed: () => context.push(Routes.ARTICLESCREEN),
            //   child: const Text(
            //     "See All",
            //     style: TextStyle(
            //       decoration: TextDecoration.underline,
            //       color: ColorConstant.primaryColor,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
          ],
        ),

        /// **Handle different states (loading, error, data)**
        articleState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
              child: Column(
            children: [
              mediumHorSpace(),
              const Text("No articles available."),
            ],
          )),
          data: (articles) {
            if (articles.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  mediumHorSpace(),
                  const Text("No articles available."),
                ],
              ));
            }
            return Column(
              children: articles
                  .take(3) // Show only first 3 articles in preview
                  .map((article) => ArticleCard(
                        title: article.title,
                        subtitle: article.shortDescription,
                        imageUrl: "assets/images/article_1.png",

                        // imageUrl:
                        //     article.imageUrl ?? "assets/images/default.png",
                        onPressed: () => context.push(
                          Routes.ARTICLEDETAILS,
                          extra: {
                            "title": article.title,
                            "description": article.fullDescription,
                            "imageUrl": "assets/images/article_1.png",
                          },
                        ),

                        // onPressed: () => context.push(Routes.ARTICLEDETAILS),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
