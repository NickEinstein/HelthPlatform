import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

import '../../home/presentation/widget/article_card.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Article",
                style: TextStyle(
                    color: ColorConstant.secondryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
            TextButton(
                onPressed: () {
                  context.push(Routes.ARTICLESCREEN);
                },
                child: const Text("See All",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorConstant.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)))
          ],
        ),
        ArticleCard(
            title: "Cardiology and workout?",
            onPressed: () {
              context.push(Routes.ARTICLEDETAILS);
            },
            subtitle:
                'Although approximately 86% of practicing cardiologists surveyed see patients who are workout ever...',
            imageUrl: "assets/images/article_1.png"),
        ArticleCard(
            title: "Nutrition Crisis",
            onPressed: () {
              context.push(Routes.ARTICLEDETAILS);
            },
            subtitle:
                'Although approximately 86% of practicing cardiologists surveyed see patients who are workout ever...',
            imageUrl: "assets/images/article_2.png"),
        ArticleCard(
            title: "Body Type",
            onPressed: () {},
            subtitle:
                'Although approximately 86% of practicing cardiologists surveyed see patients who are workout ever...',
            imageUrl: "assets/images/article_3.png"),
      ],
    );
  }
}
