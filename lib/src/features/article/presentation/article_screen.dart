import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../model/article_model.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';
import 'article_section.dart';
import 'widget/article_list.dart';
import 'widget/category_selector.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  const ArticleScreen({super.key});

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen> {
  int selectedIndex = 0; // Track selected category index

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);

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

              // 🟢 Handle Categories State
              categoryState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(
                  child: Text("Failed to load categories"),
                ),
                data: (categoriesList) {
                  final List<String> categories =
                      ["All"] + categoriesList.map((e) => e.name).toList();

                  return Column(
                    children: [
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.28,
                        child: ArticleList(), // 🛑 Replace with actual articles
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ArticlesSection(),
                      ),
                    ],
                  );
                },
              ),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
