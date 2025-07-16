import 'package:greenzone_medical/src/model/community_list_response.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/network_img_fallback.dart';
import '../../../utils/packages.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/group_card.dart';

// final isLoadingProvider = StateProvider<bool>((ref) => false);
final loadingMapProvider = StateProvider<Map<int, bool>>((ref) => {});

class CommunityList extends ConsumerStatefulWidget {
  const CommunityList({super.key});

  @override
  ConsumerState<CommunityList> createState() => _CommunityListState();
}

class _CommunityListState extends ConsumerState<CommunityList> {
  int selectedIndex = 0;
  List<String> categories = ["All"];

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(communityListProvider);
    final loginDataAsync = ref.watch(loginDataProvider);
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
                title: 'Community',
                onPressed: () {
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  context.push(Routes.SEARCHCOMMUNITY);
                },
              ),
              smallSpace(),

              // 👉 Load Category First
              categoryState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(
                  child: Text("Failed to load categories"),
                ),
                data: (categoriesList) {
                  categories = [
                    "All",
                    "Surgery",
                    ...categoriesList.map((e) => e.name).toList()
                  ];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      smallSpace(),

                      // 👉 Now Continue with login data
                      loginDataAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => const Center(
                          child: Text('Error loading community'),
                        ),
                        data: (loginData) {
                          if (loginData == null || loginData.isEmpty) {
                            return const Center(
                                child: Text("User data not found"));
                          }

                          final decodedData = jsonDecode(loginData);
                          final userId = decodedData["userID"];

                          return communityListAsync.when(
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) => const Center(
                              child: Text('Error loading community'),
                            ),
                            data: (communityList) {
                              final filteredList = selectedIndex == 0
                                  ? communityList
                                  : communityList
                                      .where((community) =>
                                          community.category?.name ==
                                          categories[selectedIndex])
                                      .toList();

                              // Count number of communities in each category
                              final Map<String, int> categoryCount = {};
                              for (var community in communityList) {
                                final categoryName =
                                    community.category?.name ?? '';
                                if (categoryName.isNotEmpty) {
                                  categoryCount[categoryName] =
                                      (categoryCount[categoryName] ?? 0) + 1;
                                }
                              }

                              // Get the top 5 categories by count
                              final topCategories = categoryCount.entries
                                  .toList()
                                ..sort((a, b) => b.value.compareTo(a.value));
                              final top5Categories = topCategories
                                  .take(5)
                                  .map((e) => e.key)
                                  .toList();

                              // Get the last community for each of the top 5 categories
                              final List<CommunityListResponse>
                                  topPopularCommunities = [];
                              for (final categoryName in top5Categories) {
                                final lastCommunity = communityList.lastWhere(
                                  (c) => c.category?.name == categoryName,
                                );
                                if (lastCommunity != null) {
                                  topPopularCommunities.add(lastCommunity);
                                }
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (topPopularCommunities.isNotEmpty) ...[
                                    const Text(
                                      'Popular Community',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: height(context) * 0.14,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: topPopularCommunities.length,
                                        itemBuilder: (context, index) {
                                          final community =
                                              topPopularCommunities[index];
                                          return GestureDetector(
                                            onTap: () {
                                              final categoryIndex =
                                                  categories.indexOf(community
                                                          .category?.name ??
                                                      '');
                                              if (categoryIndex != -1) {
                                                setState(() {
                                                  selectedIndex = categoryIndex;
                                                  // context.push(
                                                  //   Routes.COMMUNITYDETAILS,
                                                  //   extra: community,
                                                  // );
                                                });
                                              }
                                            },

                                            // onTap: () {
                                            //   final categoryIndex =
                                            //       categories.indexOf(community
                                            //               .category?.name ??
                                            //           '');
                                            //   if (categoryIndex != -1) {
                                            //     setState(() {
                                            //       selectedIndex = categoryIndex;
                                            //       context.push(
                                            //         Routes.COMMUNITYDETAILS,
                                            //         extra: community,
                                            //       );
                                            //     });
                                            //   }
                                            // },
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  margin: const EdgeInsets.only(
                                                      right: 12),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors.green),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: Image.network(
                                                      (community.pictureUrl! ??
                                                                  '')
                                                              .startsWith(
                                                                  'http')
                                                          ? community
                                                              .pictureUrl!
                                                          : '${AppConstants.noSlashImageURL}${community.pictureUrl! ?? ''}',
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        final firstName =
                                                            community
                                                                .category!.name;

                                                        final initials =
                                                            (firstName!
                                                                    .isNotEmpty
                                                                ? firstName[0]
                                                                : '');

                                                        return Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                getAvatarColor(
                                                                    firstName),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            initials,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  16, // Adjusted from 24 to better fit the avatar
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  community.category?.name ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],

                                  // 👉 Community List
                                  filteredList.isEmpty
                                      ? const Center(
                                          child: Text("No communities found"))
                                      : Column(
                                          children:
                                              filteredList.map((community) {
                                            bool isMember = community
                                                .communityGroupMembers!
                                                .any((member) =>
                                                    member.patient!.id ==
                                                    userId);

                                            return Column(
                                              children: [
                                                GroupCard(
                                                  onPressed: () {
                                                    context.push(
                                                      Routes.COMMUNITYDETAILS,
                                                      extra: community,
                                                    );
                                                  },
                                                  imageUrl:
                                                      community.pictureUrl!,
                                                  //  community.pictureUrl
                                                  //         .toString()
                                                  //         .contains('uploads')
                                                  //     ? '${AppConstants.imageURL}${community.pictureUrl!}'
                                                  //     : community.pictureUrl!
                                                  //             .isNotEmpty
                                                  //         ? community
                                                  //             .pictureUrl!
                                                  //         : 'assets/images/fitness1.png',
                                                  title: community.name!,
                                                  subtitle:
                                                      '${community.communityGroupMembers!.length} members',
                                                  buttonText: isMember
                                                      ? 'Joined'
                                                      : 'Join',
                                                  isMember: isMember,
                                                  isLoading: ref.watch(
                                                              loadingMapProvider)[
                                                          community.id] ??
                                                      false,
                                                  onButtonPressed: () async {
                                                    final loadingMap = ref.read(
                                                        loadingMapProvider
                                                            .notifier);
                                                    loadingMap.state = {
                                                      ...loadingMap.state,
                                                      community.id!: true,
                                                    };

                                                    final allService = ref.read(
                                                        allServiceProvider);
                                                    final result =
                                                        await allService
                                                            .joinCommunity(
                                                                community.id!);

                                                    if (!context.mounted)
                                                      return;

                                                    loadingMap.state = {
                                                      ...loadingMap.state,
                                                      community.id!: false,
                                                    };

                                                    if (result ==
                                                        'Join successful') {
                                                      CustomToast.show(context,
                                                          'Joined the Community Successfully',
                                                          type: ToastType
                                                              .success);
                                                      context.pushReplacement(
                                                          Routes.BOTTOMNAV);
                                                    } else {
                                                      CustomToast.show(
                                                          context, result,
                                                          type:
                                                              ToastType.error);
                                                    }
                                                  },
                                                ),
                                                smallSpace(),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
