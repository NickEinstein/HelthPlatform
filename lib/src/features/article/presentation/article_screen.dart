import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
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
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  List<String> selectedCategories = []; // Initialize selected categories list

  @override
  void initState() {
    super.initState();
    // Clear selected categories on initial screen load
    selectedCategories = [];
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);
    final articleState = ref.watch(articleProvider);

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
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value.toLowerCase().trim();
                                });
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: "Search Article",
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
                  // const SizedBox(width: 10),
                  // GestureDetector(
                  //   onTap: () async {
                  //     // Fetch categories names and reset selected categories list
                  //     final categoryNames = categoryState.maybeWhen(
                  //       data: (categories) =>
                  //           categories.map((c) => c.name as String).toList(),
                  //       orElse: () => <String>[],
                  //     );

                  //     final result = await openCategoryFilterDialog(
                  //         categoryNames, context);

                  //     if (result != null) {
                  //       setState(() {
                  //         selectedCategories =
                  //             result; // Update the selected categories
                  //       });
                  //     }
                  //   },
                  //   child: Image.asset(
                  //     'assets/icon/filter_icon.png',
                  //     height: 52,
                  //     width: 35,
                  //   ),
                  // ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedCategories
                    .map((cat) => Chip(
                          label: Text(cat),
                          deleteIcon: const Icon(
                            Icons.close,
                            size: 20,
                            color: Color(0xff059909),
                          ),
                          onDeleted: () {
                            setState(() {
                              selectedCategories.remove(cat);
                            });
                          },
                          backgroundColor: Color(0xffD9FEAA),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Set radius to 20
                          ),
                        ))
                    .toList(),
              ),
              smallSpace(),
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
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Popular Article",
                                style: TextStyle(
                                    color: ColorConstant.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),

                      // ✅ Filter Articles based on Selected Category and Search Query
                      articleState.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) =>
                            Center(child: Text('No articles available.')),
                        data: (articles) {
                          final filteredArticles = articles.where((article) {
                            final matchesCategory = selectedIndex == 0 ||
                                article.category!.name ==
                                    categories[selectedIndex];

                            final matchesSearch = searchQuery.isEmpty ||
                                article.title!
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                article.shortDescription!
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                article.slug!
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                article.category!.name!
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                article.category!.description!
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                article.fullDescription!
                                    .toLowerCase()
                                    .contains(searchQuery);

                            final isFeatured = article.isFeatured == true;

                            return matchesCategory &&
                                matchesSearch &&
                                isFeatured;
                          }).toList();

                          if (filteredArticles.isEmpty) {
                            return Center(
                              child: Text(
                                "No articles match your search",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }

                          return ArticleList(articles: filteredArticles);
                        },
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
