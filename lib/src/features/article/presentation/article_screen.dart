import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../model/article_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';
import 'article_section.dart';
import 'widget/article_list.dart';
import 'widget/category_selector.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  int selectedIndex = 0; // Track selected category index

  final List<String> categories = [
    "All",
    "Wellness",
    "Health",
    "Fitness",
    "Health"
  ];
  final List<Article> articles = [
    Article(
      imageUrl: "assets/images/article_1.png",
      category: "Wellness",
      title: "How to Boost Your Immune System Naturally",
      description:
          "Your immune system is your body's defense against infections. Learn how to boost it with these simple tips.",
      date: "Mar. 15, 2025",
      timeAgo: "6 minutes ago",
    ),
    Article(
      imageUrl: "assets/images/olddy.png",
      category: "Fitness",
      title: "Best Exercises for a Healthy Lifestyle",
      description:
          "Explore the best exercises to keep your body in shape and improve overall health.",
      date: "Mar. 10, 2025",
      timeAgo: "2 hours ago",
    ),
    Article(
      imageUrl: "assets/images/foody.png",
      category: "Health",
      title: "Top 5 Foods for Better Digestion",
      description:
          "A well-balanced diet can do wonders for digestion. Discover the top 5 foods that promote gut health.",
      date: "Feb. 20, 2025",
      timeAgo: "1 day ago",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Article',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              tinySpace(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE6E6E6)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/search.png',
                            height: 32,
                            width: 25,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Search Group Name",
                                hintStyle: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/icon/filter_icon.png',
                    height: 52,
                    width: 35,
                  ),
                ],
              ),
              smallSpace(),
              CategorySelector(
                categories: categories,
                selectedIndex: selectedIndex,
                onCategorySelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Popular Article",
                        style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
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
              ),
              // 🔥 Fix: Use SizedBox instead of Expanded

              SizedBox(
                height:
                    MediaQuery.of(context).size.height * 0.28, // Adjust height
                child: ArticleList(articles: articles),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ArticlesSection(),
              ),

              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
