import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import 'widget/search_card.dart';

class SearchCommunity extends ConsumerStatefulWidget {
  const SearchCommunity({super.key});

  @override
  ConsumerState<SearchCommunity> createState() => _SearchCommunityState();
}

class _SearchCommunityState extends ConsumerState<SearchCommunity> {
  String searchQuery = '';
  List<String> selectedCategories = []; // Track selected categories

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(communityListProvider);
    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            verticalSpace(context, 0.08),
            CustomHeader(
              title: 'Community',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            tinySpace(),

            // 🔍 Search Bar
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
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Find a Group",
                              hintStyle: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final categoryNames = categoryState.when(
                      data: (categoriesList) {
                        // Get category names
                        final categories = categoriesList
                            .map((category) => category.name)
                            .toSet()
                            .toList();
                        return categories;
                      },
                      loading: () => <String>[], // Empty list while loading
                      error: (error, stack) =>
                          <String>[], // Empty list on error
                    );

                    // Open your category filter dialog
                    final result = await openCategoryFilterDialog(
                      categoryNames.cast<String>(),
                      context,
                    );

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

            // 🏋️ Selected Categories Chips
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

            smallSpace(),

            // 🏋️ Community List
            Expanded(
              child: communityListAsync.when(
                data: (communityList) {
                  // Filter communities based on search and selected categories
                  final filteredList = communityList.where((community) {
                    final matchesSearch =
                        community.name!.toLowerCase().contains(searchQuery);

                    final matchesCategory = selectedCategories.isEmpty
                        ? true // If no categories selected, match all
                        : selectedCategories.contains(community.category?.name);

                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text("No communities found"),
                    );
                  }

                  return ListView.builder(
                    padding:
                        EdgeInsets.zero, // 🔹 Removes extra padding at the top
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final community = filteredList[index];
                      return SearchCard(
                        imageUrl: community.pictureUrl!,
                        title: community.name ?? 'Unknown Community',
                        subtitle:
                            '${community.communityGroupMembers?.length ?? 0} members',
                        onButtonPressed: () {
                          context.push(Routes.COMMUNITYDETAILS,
                              extra: community);
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    const Center(child: Text("Error community found")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
