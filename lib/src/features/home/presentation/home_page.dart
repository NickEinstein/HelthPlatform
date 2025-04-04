import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:greenzone_medical/src/constants/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/api_url.dart';
import '../../../constants/dimens.dart';
import '../../../di.dart';
import '../../../model/login_response.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/custom_toast.dart';
import '../../article/presentation/article_section.dart';
import '../../../provider/all_providers.dart';
import 'health_goal_section.dart';
import 'search_bar.dart';
import 'widget/action_button.dart';
import 'widget/article_card.dart';

class HomePage extends ConsumerStatefulWidget {
  // ✅ Change from StatelessWidget to ConsumerWidget
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final bannerState = ref.watch(bannerProvider);
    final articleState = ref.watch(articleProvider);

    return FutureBuilder<LoginResponse?>(
      future: authService.getStoredUser(),
      builder: (context, snapshot) {
        String userName = "User"; // Default name
        if (snapshot.hasData && snapshot.data != null) {
          userName = snapshot.data!.name;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false, // Removes back button
            centerTitle: false, // Aligns title to the left
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: getGreeting(),
                    style: const TextStyle(
                      color: Color(0xff0D0D0D),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: userName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(articleProvider); // Refresh articles
            },
            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Allows pulling even when list is short
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          controller: _searchController,
                          onChanged: (query) {
                            setState(() {
                              _searchQuery = query.toLowerCase();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          // await authService.logout();
                          CustomToast.show(context, "Coming soon...",
                              type: ToastType.error);
                        },
                        child: Image.asset(
                          'assets/images/notification.png',
                          height: 32,
                          width: 25,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          CustomToast.show(context, "Coming soon...",
                              type: ToastType.error);
                        },
                        child: Image.asset(
                          'assets/images/message.png',
                          height: 32,
                          width: 25,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  bannerState.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) =>
                        const Center(child: Text("Failed to load banners")),
                    data: (banners) {
                      if (banners.isEmpty) {
                        return const Center(
                            child: Text("No banners available."));
                      }

                      // Define static banners
                      final List<HealthGoalModel> staticBanners = [
                        HealthGoalModel(
                          title: "Health Goals !!",
                          description: "Tell us more about your Health \nGoals",
                          backgroundColor: ColorConstant.primaryColor,
                          buttonText: "See Details",
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final hasVisited =
                                prefs.getBool('hasVisitedHealthGoal') ?? false;

                            if (hasVisited) {
                              context.push(Routes
                                  .ABOUTHEALTH); // 🚀 Redirect after first visit
                            } else {
                              await prefs.setBool(
                                  'hasVisitedHealthGoal', true); // ✅ Store flag
                              context.push(Routes
                                  .HEALTHGOAL); // 🚀 First-time navigation
                            }
                          },
                          imagePath: "assets/images/health_goals.png",
                        ),
                        HealthGoalModel(
                          title: "Community",
                          description: "Have you taken your \nmedicine yet?",
                          backgroundColor: const Color(0xff633717),
                          buttonText: "Join a community",
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final hasJoined =
                                prefs.getBool('hasJoinedCommunity') ?? false;

                            if (hasJoined) {
                              // ignore: use_build_context_synchronously
                              context.push(Routes.COMMUNITYLIST);
                            } else {
                              await prefs.setBool('hasJoinedCommunity', true);
                              // ignore: use_build_context_synchronously
                              context.push(Routes.COMMUNITYPAGE);
                            }
                          },
                          imagePath: "assets/images/health_goals.png",
                        ),
                      ];

                      // Convert API banners to HealthGoalModel list
                      final List<HealthGoalModel> apiBanners =
                          banners.map((banner) {
                        return HealthGoalModel(
                          title: banner.name ?? "No Title",
                          description: "Check out ${banner.name}!",
                          backgroundColor: ColorConstant.primaryColor,
                          onTap: () {
                            if (banner.linkUrl != null &&
                                banner.linkUrl!.isNotEmpty) {
                              try {
                                launchUrl(Uri.parse(banner.linkUrl!));
                              } catch (e) {
                                debugPrint(
                                    "⚠️ Failed to launch URL: ${banner.linkUrl}");
                              }
                            }
                          },
                          buttonText: "Learn More",
                          imagePath:
                              "https://edogoverp.com/ConnectedHealthWebApi/${banner.imageUrl}",
                        );
                      }).toList();

                      // Combine static and API banners
                      final List<HealthGoalModel> allBanners = [
                        ...staticBanners,
                        ...apiBanners
                      ];

                      return HealthGoalsPager(goals: allBanners);
                    },
                  ),
                  mediumSpace(),
                  const ActionButtonsRow(),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Articles",
                                  style: TextStyle(
                                    color: ColorConstant.secondryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.push(Routes.ARTICLESCREEN);
                                  },
                                  child: const Text(
                                    "See All",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ColorConstant.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// **Handle different states (loading, error, data)**
                          RefreshIndicator(
                            onRefresh: () async {
                              ref.invalidate(articleProvider);
                            },
                            child: articleState.when(
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (err, stack) => const Center(
                                  child: Text("No articles available.")),
                              data: (articles) {
                                // **Filter Articles Based on Search Query**
                                final filteredArticles = articles
                                    .where((article) =>
                                        article.title
                                            .toLowerCase()
                                            .contains(_searchQuery) ||
                                        article.shortDescription
                                            .toLowerCase()
                                            .contains(_searchQuery))
                                    .take(5) // Show only first 5 articles
                                    .toList();

                                if (filteredArticles.isEmpty) {
                                  return const Center(
                                      child: Text("No articles found."));
                                }

                                return ListView.builder(
                                  shrinkWrap:
                                      true, // Ensures ListView only takes necessary space
                                  physics:
                                      const NeverScrollableScrollPhysics(), // Prevents nested scrolling conflicts
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  itemCount: filteredArticles.length,
                                  itemBuilder: (context, index) {
                                    final article = filteredArticles[index];
                                    return ArticleCard(
                                      title: article.title,
                                      subtitle: article.shortDescription,
                                      imageUrl: "assets/images/article_1.png",
                                      onPressed: () => context.push(
                                        Routes.ARTICLEDETAILS,
                                        extra: {
                                          "title": article.title,
                                          "description":
                                              article.fullDescription,
                                          "imageUrl":
                                              "assets/images/article_1.png",
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                  // Articles will now refresh when pulled down
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
