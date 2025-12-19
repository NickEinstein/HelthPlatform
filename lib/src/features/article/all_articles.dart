import '../../provider/all_providers.dart';
import '../../utils/packages.dart';

class AllArticleScreen extends ConsumerStatefulWidget {
  const AllArticleScreen({super.key});

  @override
  ConsumerState<AllArticleScreen> createState() => _AllArticleScreenState();
}

class _AllArticleScreenState extends ConsumerState<AllArticleScreen> {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  List<String> selectedCategories = []; // Make sure to initialize this

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
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      final categoryNames = categoryState.maybeWhen(
                        data: (categories) =>
                            categories.map((c) => c.name).toList(),
                        orElse: () => <String>[],
                      );

                      final result = await openCategoryFilterDialog(
                          categoryNames, context);

                      if (result != null) {
                        setState(() {
                          selectedCategories = result;
                        });
                      }
                    },
                    child: Image.asset(
                      'assets/icon/filter_icon.png',
                      height: 52,
                      width: 35,
                    ),
                  ),
                ],
              ),
              smallSpace(),
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
                          backgroundColor: const Color(0xffD9FEAA),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Set radius to 20
                          ),
                        ))
                    .toList(),
              ),
              categoryState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(
                  child: Text("Failed to load categories"),
                ),
                data: (categoriesList) {
                  return Column(
                    children: [
                      smallSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Articles",
                                  style: TextStyle(
                                    color: ColorConstant.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            articleState.when(
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (err, stack) => Center(
                                child: Column(
                                  children: [
                                    mediumHorSpace(),
                                    const Text("No articles available."),
                                  ],
                                ),
                              ),
                              data: (articles) {
                                // 🔥 Apply Search Filter here
                                final filteredArticles =
                                    articles.where((article) {
                                  final title = article.title!.toLowerCase();
                                  final description =
                                      article.shortDescription!.toLowerCase();
                                  final matchesSearch =
                                      title.contains(searchQuery) ||
                                          description.contains(searchQuery);

                                  final matchesCategory =
                                      selectedCategories.isEmpty ||
                                          selectedCategories.contains(
                                              article.category?.name ?? '');

                                  return matchesSearch && matchesCategory;
                                }).toList();

                                if (filteredArticles.isEmpty) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        mediumHorSpace(),
                                        const Text(
                                            "No articles match your search."),
                                      ],
                                    ),
                                  );
                                }

                                return Column(
                                  children: filteredArticles
                                      .map((article) => ArticleCard(
                                            title: article.title!,
                                            subtitle: article.fullDescription!,
                                            imageUrl:
                                                article.featuredImagePath ?? '',

                                            // imageUrl:
                                            //     "assets/images/article_1.png",
                                            onPressed: () => context.push(
                                              Routes.ARTICLEDETAILS,
                                              extra: article,
                                            ),
                                          ))
                                      .toList(),
                                );
                              },
                            ),
                          ],
                        ),
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
