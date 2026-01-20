import 'package:flutter/foundation.dart';
import 'package:greenzone_medical/src/features/home/presentation/widget/advert_helper.dart';
import 'package:greenzone_medical/src/features/plan/widgets/start_plan_screen.dart';
import 'package:greenzone_medical/src/model/my_app_category_model.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class AllGoalsScreen extends ConsumerStatefulWidget {
  static const routeName = '/all-goals';
  const AllGoalsScreen({super.key});

  @override
  ConsumerState<AllGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends ConsumerState<AllGoalsScreen> {
  List<RegularAppModel> searchedApps = [];
  late TextEditingController _searchController;
  bool isSearching = false;

  @override
  initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goalNotifierProvider.notifier).getAppCategories();
      ref.read(goalNotifierProvider.notifier).getAllApps();
    });
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void search(List<RegularAppModel>? list) {
    if (!mounted) return;
    try {
      final searchQuery = _searchController.text.toLowerCase();
      if (searchQuery.isEmpty) {
        setState(() {
          isSearching = false;
        });
      } else {
        setState(() {
          isSearching = true;
          searchedApps = list
                  ?.where(
                      (app) => app.title.toLowerCase().contains(searchQuery))
                  .toList() ??
              [];
        });
      }
    } catch (e) {
      // print(e);
      // print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bannerState = ref.watch(bannerProvider);
    final authService = ref.watch(authServiceProvider);
    final allAvailableApps = ref.watch(goalNotifierProvider.select(
        (s) => s.allApps ?? const AsyncValue.data(<RegularAppModel>[])));
    final appCategories = ref.watch(goalNotifierProvider.select(
        (s) => s.categories ?? const AsyncValue.data(<MyAppCategoryModel>[])));

    return FutureBuilder<LoginResponse?>(
        future: authService.getStoredUser(),
        builder: (context, snapshot) {
          String userName = "User"; // Default name
          if (snapshot.hasData && snapshot.data != null) {
            userName = snapshot.data!.name;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: allAvailableApps.when(
                  data: (_) => const AlwaysScrollableScrollPhysics(),
                  loading: () => const NeverScrollableScrollPhysics(),
                  error: (_, __) => const NeverScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getGreeting(),
                              style: context.textTheme.displayMedium,
                            ),
                            Text(
                              userName,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.height,
                    // Search Bar
                    TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        search(allAvailableApps.value ?? []);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for an app',
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.greyTextColor),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.camera_alt_outlined,
                                color: AppColors.greyTextColor),
                            10.width,
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.mic,
                                  color: AppColors.primary),
                            ),
                            8.width,
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: AppColors.bordersLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: AppColors.bordersLight),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    ),
                    20.height,

                    // Content based on search state
                    if (isSearching) ...[
                      const Text(
                        'Search Result',
                        style: CustomTextStyle.labelMedium,
                      ),
                      10.height,
                      SizedBox(
                        height: 225.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: searchedApps
                              .map(
                                (goal) => GoalCard(
                                  title: goal.title,
                                  icon: Icons.crop_square_outlined,
                                  installs: goal.installs ?? '',
                                  onStart: () {
                                    context.push(
                                      StartPlanScreen.routeName,
                                      extra: goal,
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ] else ...[
                      // Categories List
                      appCategories.when(
                        data: (categories) {
                          return categories.isNotEmpty
                              ? CategoryAppsList(
                                  category: categories.firstWhere(
                                    (e) =>
                                        e.name == 'Hair Growth and Retention',
                                    orElse: () => categories.firstOrNull!,
                                  ),
                                )
                              : const SizedBox();
                        },
                        error: (e, s) => Center(child: Text(e.toString())),
                        loading: () => const HorizontalListTileLoader(
                          itemCount: 4,
                          height: 160,
                        ),
                      ),
                    ],
                    20.height,
                    // Hospital List
                    allAvailableApps.when(
                      data: (apps) {
                        return apps.isNotEmpty
                            ? Column(
                                children: apps
                                    .sublist(0, 3)
                                    .map((app) => _appHorizontalWidget(
                                          app: app,
                                          categories: appCategories.value ?? [],
                                        ))
                                    .toList(),
                              )
                            : const SizedBox();
                      },
                      error: (e, s) => Center(
                          child: Text(
                        e.toString(),
                      )),
                      loading: () => const ListLoader(
                        itemCount: 4,
                      ),
                    ),
                    20.height,
                    // Ad Banner
                    if (!kDebugMode)
                      bannerState.when(
                        loading: () => const ListLoader(
                          itemCount: 1,
                          height: 120,
                        ),
                        error: (err, stack) =>
                            const Center(child: Text("Failed to load banners")),
                        data: (banners) {
                          if (banners.isEmpty) {
                            return const Center(
                                child: Text("No banners available."));
                          }
                          // API banners only
                          final List<AdvertModel> apiBanners =
                              banners.map((banner) {
                            final imageUrl = banner.imageUrl ?? "";
                            final isVideo = imageUrl.endsWith('.mp4');
                            return AdvertModel(
                              title: "",
                              description: "",
                              backgroundColor: ColorConstant.primaryColor,
                              mediaType: isVideo ? 'video' : 'image',
                              imagePath:
                                  "${AppConstants.noSlashImageURL}$imageUrl",
                              onTap: () {
                                final url = imageUrl.isNotEmpty
                                    ? "${AppConstants.noSlashImageURL}$imageUrl"
                                    : "https://edogoverp.com";
                                try {
                                  launchUrl(Uri.parse(url));
                                } catch (e) {
                                  debugPrint("⚠️ Failed to launch URL: $url");
                                }
                              },
                            );
                          }).toList();
                          return AdvertHelper(goals: apiBanners);
                        },
                      ),

                    // Container(
                    //   height: 150,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color: Colors.grey[300],
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Stack(
                    //     children: [
                    //       Positioned.fill(
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               gradient: LinearGradient(
                    //                   begin: Alignment.centerLeft,
                    //                   end: Alignment.centerRight,
                    //                   colors: [
                    //                     Colors.grey[400]!,
                    //                     Colors.grey[300]!
                    //                   ])),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         bottom: 20,
                    //         left: 20,
                    //         child: Text(
                    //           'This is\nAn Advert',
                    //           style: CustomTextStyle.labelXLBold
                    //               .copyWith(color: Colors.white, fontSize: 24),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    20.height,
                    appCategories.when(
                      data: (categories) {
                        return categories.isNotEmpty
                            ? CategoryAppsList(
                                category: categories.firstWhere(
                                  (e) => e.name == 'Newskin.',
                                  orElse: () => categories.firstOrNull!,
                                ),
                              )
                            : const SizedBox();
                      },
                      error: (e, s) => Center(child: Text(e.toString())),
                      loading: () => const HorizontalListTileLoader(
                        itemCount: 4,
                        height: 160,
                      ),
                    ),
                    20.height,
                    allAvailableApps.when(
                      data: (apps) {
                        return apps.isNotEmpty
                            ? Column(
                                children: apps
                                    .skip(3)
                                    .map(
                                      (app) => _appHorizontalWidget(
                                        app: app,
                                        categories: appCategories.value ?? [],
                                      ),
                                    )
                                    .toList(),
                              )
                            : const SizedBox();
                      },
                      error: (error, stackTrace) {
                        return Center(
                          child: Text(error.toString()),
                        );
                      },
                      loading: () => const ListLoader(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _appHorizontalWidget({
    required RegularAppModel app,
    List<MyAppCategoryModel> categories = const [],
  }) {
    final category =
        categories.where((e) => e.id == app.categoryId).firstOrNull;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bordersLight),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.more, color: AppColors.primary),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.title,
                  style: CustomTextStyle.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                2.height,
                if (category != null)
                  Text(
                    category.name,
                    style: CustomTextStyle.paragraphTiny
                        .copyWith(color: AppColors.greyTextColor),
                  ),
                // Row(
                //   children: List.generate(
                //     app.installs,
                //     (index) => const Icon(
                //       Icons.star,
                //       color: Colors.amber,
                //       size: 12,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          4.width,
          ElevatedButton(
            onPressed: () {
              context.push(StartPlanScreen.routeName, extra: app);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(60, 30),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
            child: const Text('Start', style: TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }
}

class CategoryAppsList extends ConsumerWidget {
  final MyAppCategoryModel category;

  const CategoryAppsList({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appsAsync = ref.watch(goalByCategoryProvider(category.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: CustomTextStyle.labelMedium,
        ),
        10.height,
        SizedBox(
          height: 225.h,
          child: appsAsync.when(
            data: (apps) {
              if (apps.isEmpty) {
                return const Center(child: Text("No apps available"));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: apps.length,
                itemBuilder: (context, index) {
                  final app = apps[index];
                  return GoalCard(
                    title: app.title,
                    icon: Icons.more,
                    installs: app.installs ?? '',
                    onStart: () {
                      context.push(
                        StartPlanScreen.routeName,
                        extra: app,
                      );
                    },
                  );
                },
              );
            },
            error: (e, s) => Center(child: Text('Error: $e')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
        // 20.height,
      ],
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String installs;
  final Function() onStart;

  const GoalCard({
    super.key,
    required this.onStart,
    required this.title,
    required this.icon,
    required this.installs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15, bottom: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bordersLight),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryLight,
            child: Icon(icon, color: AppColors.primary, size: 30),
          ),
          10.height,
          Text(
            title,
            style: CustomTextStyle.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (installs.isNotEmpty) ...[
            4.height,
            Text(
              installs,
              style: CustomTextStyle.paragraphTiny.copyWith(
                color: AppColors.greyTextColor,
              ),
            ),
          ],
          12.height,
          InkWell(
            onTap: onStart,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF109615),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Start Now',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
