import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
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

class HomePage extends ConsumerWidget {
  // ✅ Change from StatelessWidget to ConsumerWidget
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final bannerState = ref.watch(bannerProvider);

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
                  const TextSpan(
                    text: "Good morning! ",
                    style: TextStyle(
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
                      const Expanded(child: CustomSearchBar()),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          await authService.logout();
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
                  SizedBox(height: 20),
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
                          onTap: () {
                            context.push(Routes.HEALTHGOAL);
                          },
                          buttonText: "See Details",
                          imagePath: "assets/images/health_goals.png",
                        ),
                        HealthGoalModel(
                          title: "Community",
                          description: "Have you taken your \nmedicine yet?",
                          backgroundColor: Color(0xff633717),
                          buttonText: "Join a community",
                          onTap: () {
                            context.push(Routes.COMMUNITYPAGE);
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
                  const ArticlesSection(), // Articles will now refresh when pulled down
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
