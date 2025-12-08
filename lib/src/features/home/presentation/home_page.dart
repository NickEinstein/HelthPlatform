// ignore_for_file: use_build_context_synchronously

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:greenzone_medical/src/features/home/presentation/widget/advert_helper.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/pharmacy_search_screen.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import 'widget/friend_request_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int cachedUpcomingAppointments = 0;
  int cachedPrescription = 0;

  int cachedHMOCount = 0;
  bool hasLoadedData = false;
  // String _token = '';

  @override
  void initState() {
    super.initState();
    // loadData();
    // FirebaseMessaging.instance.getToken().then((token) {
    //   setState(() {
    //     _token = token ?? 'Token not found';
    //   });
    // });

    Future.microtask(() => ref.invalidate(userFriendRequestReceiverProvider));
    Future.microtask(() => ref.invalidate(userHMOProvider));
    Future.microtask(() => ref.invalidate(userAppointmentProvider));
    Future.microtask(() => ref.invalidate(userPrescriptionProvider));
    Future.microtask(() => ref.invalidate(articleProvider));
    Future.microtask(() => ref.invalidate(userUnreadChatProvider));
    Future.microtask(() => ref.invalidate(userUnreadNotificationProvider));
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 0)); // or any async work

    if (!mounted) return;

    setState(() {
      // showHealthGoalBottomSheet(context);
      showInterestBottomSheet(context);
    });
  }

  Widget _buildStaticBanners() {
    final List<HealthGoalModel> staticBanners = [
      HealthGoalModel(
        title: "Health Goals !!",
        description: "Tell us more about your Health \nGoals",
        backgroundColor: ColorConstant.primaryColor,
        buttonText: "See Details",
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final hasVisited = prefs.getBool('hasVisitedHealthGoal') ?? false;

          if (hasVisited) {
            context.push(Routes.ABOUTHEALTH);
          } else {
            await prefs.setBool('hasVisitedHealthGoal', true);
            context.push(Routes.HEALTHGOAL);
          }
        },
        imagePath: "assets/images/health_goals.png",
      ), // <--- comma here
      HealthGoalModel(
        title: "Community",
        description: "Have you taken your \nmedicine yet?",
        backgroundColor: const Color(0xff633717),
        buttonText: "Join a Community",
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          final hasJoined = prefs.getBool('hasJoinedCommunity') ?? false;

          if (hasJoined) {
            context.push(Routes.COMMUNITYLIST);
          } else {
            await prefs.setBool('hasJoinedCommunity', true);
            context.push(Routes.COMMUNITYPAGE);
          }
        },
        imagePath: "assets/images/health_goals.png",
      ), // <--- comma here
      HealthGoalModel(
        title: "Track your meds!",
        description: "Have you taken your \nmedicine yet?",
        backgroundColor: const Color(0xff175B63),
        buttonText: "See Details",
        onTap: () async {
          context.push(Routes.COMMUNITYPAGE);
        },
        imagePath: "assets/images/health_goals.png",
      ), // <--- optional trailing comma (recommended)
    ];

    return HealthGoalsPager(goals: staticBanners);
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    Future.microtask(() => ref.invalidate(userUnreadChatProvider));

    super.didUpdateWidget(oldWidget);
  }

  void showHealthGoalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return HealthGoalBottomSheet(); // Use the stateful widget here
      },
    );
  }

  void showInterestBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return const YourInterestSheet(); // Use the stateful widget here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final bannerState = ref.watch(bannerProvider);
    final articleState = ref.watch(articleProvider);
    final prescriptionsAsync = ref.watch(userPrescriptionProvider);
    final appointmentAsync = ref.watch(userAppointmentProvider);
    final hmoAsync = ref.watch(userHMOProvider);
    final getAllInterestAsync = ref.watch(userGetInterestProvider);
    final getUnreadChatAsync = ref.watch(userUnreadChatProvider);
    final asyncNotifications = ref.watch(userUnreadNotificationProvider);

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Received a message in the foreground: ${message.messageId}');
    //   // Handle the message and show notification UI if needed
    // });

    getAllInterestAsync.whenOrNull(
      data: (interests) {
        if (interests.isNotEmpty) {
          hasLoadedData = false; // Reset the flag if we have valid data
          return;
        } else {
          if (!hasLoadedData) {
            loadData();
            hasLoadedData = true;
          }
        }
      },
      error: (error, stackTrace) {
        if (!hasLoadedData) {
          loadData();
          hasLoadedData = true; // Prevent calling loadData again
        }
      },
    );

    hmoAsync.whenOrNull(
      data: (hmos) {
        cachedHMOCount = hmos.length;
      },
    );
    prescriptionsAsync.whenOrNull(
      data: (hmos) {
        cachedPrescription = hmos.length;
      },
    );

    appointmentAsync.whenOrNull(
      data: (appointments) {
        final today = DateTime.now();

        final upcoming = appointments.where((a) {
          // Safely handle nullable appointDate
          final appointDate = a.appointDate;
          if (appointDate == null || appointDate.isEmpty) return false;

          final dateParts = appointDate.split('/'); // Expected format: M/D/YYYY
          if (dateParts.length != 3) return false;

          try {
            final parsedDate = DateTime(
              int.parse(dateParts[2]), // Year
              int.parse(dateParts[0]), // Month
              int.parse(dateParts[1]), // Day
            );

            return !(a.isCanceled ?? false) &&
                parsedDate.isAfter(today.subtract(const Duration(days: 1)));
          } catch (e) {
            return false; // If parsing fails, skip this entry
          }
        }).length;

        cachedUpcomingAppointments = upcoming;
      },
    );

    return FutureBuilder<LoginResponse?>(
      future: authService.getStoredUser(),
      builder: (context, snapshot) {
        String userName = "User"; // Default name
        if (snapshot.hasData && snapshot.data != null) {
          userName = snapshot.data!.name;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          endDrawer: const HomeDrawer(),
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   surfaceTintColor: Colors.white,
          //   elevation: 0,
          //   automaticallyImplyLeading: false, // Removes back button
          //   centerTitle: false, // Aligns title to the left
          //   title: RichText(
          //     text: TextSpan(
          //       children: [
          //         TextSpan(
          //           text: getGreeting(),
          //           style: const TextStyle(
          //             color: Color(0xff0D0D0D),
          //             fontSize: 20,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         TextSpan(
          //           text: '\n$userName',
          //           style: const TextStyle(
          //             color: Colors.black,
          //             fontSize: 14,
          //             height: 1.9,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   actions: [
          //     InkWell(
          //       onTap: () {
          //         _scaffoldKey.currentState?.openEndDrawer();
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.only(right: 20),
          //         child: Image.asset(
          //           "assets/icon/menu.png",
          //           height: 23,
          //           width: 37,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(articleProvider); // Refresh articles
              ref.invalidate(userPrescriptionProvider);
              ref.invalidate(userAppointmentProvider);
              ref.invalidate(userHMOProvider);
              ref.invalidate(userGetInterestProvider);
              ref.watch(userUnreadChatProvider);
              ref.watch(userUnreadNotificationProvider);
            },
            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Allows pulling even when list is short
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (context.padding.top + 14).height,
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
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset(
                            "assets/icon/menu.png",
                            height: 23,
                            width: 37,
                          ),
                        ),
                      )
                    ],
                  ),
                  12.height,
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          controller: _searchController,
                          onCameraTap: () {
                            context.push(Routes.PRODUCTSCAN);
                          },
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
                          await context.push(Routes.NOTIFICATIONPAGE);
                          ref.invalidate(
                              userUnreadNotificationProvider); // Force refresh on return
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/images/notification.png',
                              height: 32,
                              width: 25,
                            ),
                            if (asyncNotifications is AsyncData)
                              // Count unread notifications
                              Builder(
                                builder: (_) {
                                  final unreadCount =
                                      asyncNotifications.value?.unreadCount ??
                                          0;

                                  if (unreadCount == 0) {
                                    return const SizedBox.shrink();
                                  }

                                  return Positioned(
                                    right: -4,
                                    top: -4,
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.white, width: 1.5),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 18,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        unreadCount > 99
                                            ? '99+'
                                            : unreadCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          await context.push(Routes.CHATPAGE);
                          ref.invalidate(
                              userUnreadChatProvider); // Force refresh on return
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              'assets/images/message.png',
                              height: 32,
                              width: 25,
                            ),
                            getUnreadChatAsync.when(
                              data: (data) {
                                final count = data.unreadMessages;
                                if (count == 0) {
                                  return const SizedBox(); // No badge if 0
                                }
                                return Positioned(
                                  top: -2,
                                  right: -6,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                      minHeight: 18,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$count',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loading: () =>
                                  const SizedBox(), // Or a small loading spinner
                              error: (_, __) =>
                                  const SizedBox(), // Or handle the error visually
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildStaticBanners(),
                  // mediumSpace(),
                  // _drugSearchWidget(context),
                  // mediumSpace(),
                  // const PersonalGoalsWidget(),
                  mediumSpace(),
                  const ActionButtonsRow(),
                  smallSpace(),
                  CustomListTile(
                    imagePath: "assets/icon/appo_icon.png",
                    title: "Appointment",
                    subtitle:
                        "$cachedUpcomingAppointments upcoming Appointment${cachedUpcomingAppointments == 1 ? '' : 's'}",
                    backgroundColor: const Color(0xffEAF2FF),
                    onTap: () {
                      context.push(Routes.APPOINTMENT, extra: true);
                    },
                  ),

                  CustomListTile(
                    imagePath: "assets/icon/pres_icon.png",
                    title: "Prescriptions",
                    subtitle:
                        "$cachedPrescription Prescription${cachedPrescription == 1 ? '' : 's'}",
                    backgroundColor: const Color(0xffEAF2FF),
                    onTap: () {
                      context.push(Routes.PRESCRIPTION, extra: true);
                    },
                  ),

                  mediumSpace(),
                  // const ProfileCompletionWidget(),
                  // mediumSpace(),
                  // InkWell(
                  //   onTap: () {
                  //     context.push(SuspendedProducts.routeName);
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xFFFFE7E6),
                  //       border: Border.all(
                  //         color: const Color(0xFFFF6159),
                  //       ),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     padding: const EdgeInsets.all(12),
                  //     child: Row(
                  //       children: [
                  //         Image.asset('nafdac'.toImg),
                  //         8.width,
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 'Suspended & Canceled Products',
                  //                 style: context.textTheme.bodyMedium?.copyWith(
                  //                   fontSize: 15,
                  //                 ),
                  //               ),
                  //               4.height,
                  //               Text(
                  //                 'NAFDAC Approved list',
                  //                 style: context.textTheme.bodyLarge?.copyWith(
                  //                   fontSize: 13,
                  //                   color: const Color(0xFFFF6159),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         4.width,
                  //         const Icon(
                  //           Icons.arrow_forward_ios,
                  //           size: 14,
                  //           color: Color(0xFFFF6159),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // mediumSpace(),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'My Community & Socials',
                  //       style: context.textTheme.labelLarge,
                  //     ),
                  //     12.height,
                  //     const Divider(
                  //       color: Color(0xFFBABABA),
                  //     ),
                  //     12.height,
                  //     Text(
                  //       'Hey Jessica, you have 0 posts',
                  //       style: context.textTheme.labelMedium?.copyWith(
                  //         color: const Color(0xFF656565),
                  //       ),
                  //     ),
                  //     4.height,
                  //     Text(
                  //       'Start the conversation by creating the first post',
                  //       style: context.textTheme.bodyLarge?.copyWith(
                  //         fontSize: 13,
                  //       ),
                  //     ),
                  //     14.height,
                  //     Container(
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xFFEAFFEB),
                  //         border: Border.all(color: AppColors.primary),
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 12,
                  //         vertical: 16,
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         'Create your first post',
                  //         style: context.textTheme.labelMedium?.copyWith(
                  //           color: const Color(0xFF575757),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // mediumSpace(),
                  // const FriendRequestWidget(),
                  // mediumSpace(),
                  Column(
                    children: [
                      // CustomListTile(
                      //   imagePath: "assets/icon/health_ins_icon.png",
                      //   title: "Health Insurance",
                      //   subtitle:
                      //       "$cachedHMOCount HMO${cachedHMOCount == 1 ? '' : 's'}",
                      //   backgroundColor: const Color(0xffEAF2FF),
                      //   onTap: () {},
                      // ),
                      const FriendRequestSection(),
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

                      getAllInterestAsync.when(
                        data: (interests) {
                          if (interests.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          final categoryIds = interests
                              .map((interest) => interest.category?.id)
                              .whereType<int>()
                              .toList();

                          return GroupInterestList(categoryIds: categoryIds);
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => const SizedBox.shrink(),
                      ),

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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            article.title!
                                                .toLowerCase()
                                                .contains(_searchQuery) ||
                                            article.shortDescription!
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
                                          title: article.title!,
                                          subtitle: article.fullDescription!,
                                          // imageUrl: "assets/images/article_1.png",
                                          imageUrl: article.featuredImagePath ??
                                              'assets/images/article_1.png',

                                          onPressed: () => context.push(
                                            Routes.ARTICLEDETAILS,
                                            extra: article,
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
                  )
                      .animate()
                      .slideY(begin: 1.0, end: 0, duration: 600.ms)
                      .fadeIn()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _drugSearchWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(PharmacySearchScreen.routeName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryVariant,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('drugstore'.toSvg),
                      4.width,
                      Text(
                        'CHP Pharmacy eKiosk',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (context.screenWidth * .1).width,
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40A7A7A7),
                  blurRadius: 11,
                  offset: Offset(0, 4),
                )
              ],
              color: Colors.white,
              border: Border.all(
                color: AppColors.primaryVariant,
                width: .7,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Text(
                  'Search for any drugs',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF9D9D9D),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset('search'.toSvg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
