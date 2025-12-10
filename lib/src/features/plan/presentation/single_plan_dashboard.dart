import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/plan/models/routine_view_model.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';
import 'package:intl/intl.dart';

class SinglePlanDashboard extends ConsumerStatefulWidget {
  static const routeName = '/single-plan-dashboard';
  final MyAppModel myApp;
  const SinglePlanDashboard({super.key, required this.myApp});

  @override
  ConsumerState<SinglePlanDashboard> createState() =>
      _SinglePlanDashboardState();
}

class _SinglePlanDashboardState extends ConsumerState<SinglePlanDashboard> {
  bool isStarted = false;

  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (context.mediaQuery.viewInsets.bottom > 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<LoginResponse?>(
            future: authService.getStoredUser(),
            builder: (context, snapshot) {
              String userName = "User"; // Default name
              if (snapshot.hasData && snapshot.data != null) {
                userName = snapshot.data!.name;
              }

              return SafeArea(
                child: DefaultTabController(
                  length: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            10.height,
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => context.pop(),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.arrow_back,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            10.height,
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryBorder,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.more,
                                size: 40,
                                color: AppColors.primary,
                              ),
                            ),
                            10.height,
                            Text(
                              widget.myApp.title,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            5.height,
                            Text(
                              widget.myApp.category,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            15.height,
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.primaryBorder),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: AppColors.primaryLight,
                              ),
                              child: Text(
                                'Dashboard',
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: AppColors.primaryBorder,
                                ),
                              ),
                            ),
                            20.height,
                          ],
                        ),
                      ),

                      // Tab Bar
                      const TabBar(
                        isScrollable: true,
                        indicatorColor: AppColors.primary,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabAlignment: TabAlignment.start,
                        tabs: [
                          Tab(text: 'Care, Goal & Plan'),
                          Tab(text: 'Product'),
                          Tab(text: 'Knowledge'),
                          Tab(text: 'Community'),
                          Tab(text: 'Journals'),
                          Tab(text: 'Specialists'),
                        ],
                      ),

                      // Tab View Content
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Care, Goal & Plan Tab
                            SingleChildScrollView(
                                child: isStarted
                                    ? const PlanTab()
                                    // const SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: _buildGetStartedTab(
                                          context,
                                          userName: userName,
                                        ),
                                      )),
                            // Placeholders for other tabs
                            const Center(child: Text('Products Loading')),
                            _buildKnowledgeTab(context),
                            _buildCommunityTab(context),
                            _buildJournalsTab(context),
                            _buildSpecialistsTab(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _buildGetStartedTab(
    BuildContext context, {
    required String userName,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello $userName,',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          20.height,
          Text(
            widget.myApp.description,
            style: context.textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
          ),
          // Text(
          //   'We are excited about your aspiration and desire to give your hair the attention it deserves.',
          //   style: context.textTheme.bodyLarge?.copyWith(
          //     height: 1.5,
          //   ),
          // ),
          // 20.height,
          // Text(
          //   "What's most exciting is that we'll be a part of this journey with you.",
          //   style: context.textTheme.bodyLarge?.copyWith(
          //     height: 1.5,
          //   ),
          // ),
          // 20.height,
          // Text(
          //   "Let's get you started on a plan for your hair.",
          //   style: context.textTheme.bodyLarge?.copyWith(
          //     height: 1.5,
          //   ),
          // ),
          40.height,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isStarted = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF109615), // Darker green
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Let's Get Started",
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildKnowledgeTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Article Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Article',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'See All',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          15.height,
          SizedBox(
            height: 240,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPopularArticleCard(
                  context,
                  title: 'How to Boost Your Immune System Naturaly',
                  category: 'Wellness',
                  date: 'Mar. 15,2025',
                  readTime: '6 minutes ago',
                  imageUrl: 'assets/images/wellness_1.png', // Placeholder
                ),
                _buildPopularArticleCard(
                  context,
                  title: 'How to Boost Your Immune System Naturaly',
                  category: 'Wellness',
                  date: 'Mar. 15,2025',
                  readTime: '6 minutes ago',
                  imageUrl: 'assets/images/wellness_2.png', // Placeholder
                ),
                _buildPopularArticleCard(
                  context,
                  title: 'How to Boost Your Immune System Naturaly',
                  category: 'Wellness',
                  date: 'Mar. 15,2025',
                  readTime: '6 minutes ago',
                  imageUrl: 'assets/images/wellness_3.png', // Placeholder
                ),
              ],
            ),
          ),
          20.height,

          // Articles Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Articles',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'See All',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          15.height,
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildArticleItem(
                context,
                title: 'Cardiology and workout?',
                description:
                    'Although approximately 86% of practicing cardiologists surveyed see patients who are workout ever...',
                imageUrl: 'assets/images/article_1.png', // Placeholder
              ),
              _buildArticleItem(
                context,
                title: 'Nutrition Crisis',
                description:
                    'Although approximately 86% of practicing cardiologists surveyed see patients who are workout ever...',
                imageUrl: 'assets/images/article_2.png', // Placeholder
              ),
              _buildArticleItem(
                context,
                title: 'Body Type',
                description:
                    'Although approximately 86% of practicing cardiologists surveyed see patients who are workout ever...',
                imageUrl: 'assets/images/article_3.png', // Placeholder
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularArticleCard(
    BuildContext context, {
    required String title,
    required String category,
    required String date,
    required String readTime,
    required String imageUrl,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300], // Placeholder color
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {}, // Handle missing assets
              ),
            ),
            child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.white)),
          ),
          10.height,
          Text(
            category,
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          5.height,
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          5.height,
          Row(
            children: [
              Text(
                date,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              Text(
                readTime,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary, // Assuming green from image
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleItem(
    BuildContext context, {
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
            child: const Center(
                child: Icon(Icons.image, size: 20, color: Colors.white)),
          ),
          15.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.height,
                Text(
                  description,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCommunityTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Find a Group',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            ),
          ),
          20.height,
          // Header
          Text(
            'Hair care communities',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF109615), // Green color
            ),
          ),
          15.height,
          // Community List
          _buildCommunityCard(
            context,
            title: 'TheHerbalMedic',
            author: 'Dr. Humphrey Williams',
            details: 'Cardiologist | Healing Stripes Hospitals',
            members: '12,453 Members',
            posts: '130+ new post',
            imageUrl: 'assets/images/community_1.png', // Placeholder
          ),
          20.height,
          // Ad Space
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'This is an ad space.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.height,
                Text(
                  'Ads are displayed relevant to what the user is searching (user\'s search keywords)',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          20.height,
          _buildCommunityCard(
            context,
            title: 'TheHerbalMedic',
            author: 'Dr. Humphrey Williams',
            details: 'Cardiologist | Healing Stripes Hospitals',
            members: '12,453 Members',
            posts: '130+ new post',
            imageUrl: 'assets/images/community_1.png', // Placeholder
          ),
          20.height,
          _buildCommunityCard(
            context,
            title: 'Fitness & Wellness',
            author: 'Dr. Humphrey Williams',
            details: 'Cardiologist | Healing Stripes Hospitals',
            members: '12,453 Members',
            posts: '130+ new post',
            imageUrl: 'assets/images/community_2.png', // Placeholder
          ),
          20.height,
          _buildCommunityCard(
            context,
            title: 'Aweteesim',
            author: 'Dr. Humphrey Williams',
            details: 'Cardiologist | Healing Stripes Hospitals',
            members: '12,453 Members',
            posts: '130+ new post',
            imageUrl: 'assets/images/community_3.png', // Placeholder
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(
    BuildContext context, {
    required String title,
    required String author,
    required String details,
    required String members,
    required String posts,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {},
                  ),
                ),
              ),
              15.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                    2.height,
                    Text(
                      author,
                      style: context.textTheme.bodySmall,
                    ),
                    2.height,
                    Text(
                      details,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    5.height,
                    Row(
                      children: [
                        Text(
                          members,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                        10.width,
                        const Icon(Icons.circle, color: Colors.green, size: 8),
                        5.width,
                        Text(
                          posts,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.height,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF109615),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 0),
                minimumSize: const Size(0, 35),
              ),
              child: const Text('View', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello Gabriella,',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          10.height,
          Text(
            'Your journal helps you document your progress, achievements and observations as you crush your goals.',
            style: context.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
          20.height,
          // Actions
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF8CEE8C), // Light green
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic, color: Colors.white),
              ),
              10.width,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF98FB98), // Pale green
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Color(0xFF109615)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Make a Note',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          20.height,
          // Journal List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildJournalCard(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJournalCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Few hair loss 3rd day in to this program',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                      Text(
                        'Your journal helps you document your progress, achievements and observations as you crush ...',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFDCF8C6), // Light green footer
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                5.width,
                Text(
                  'September 5, 2025',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                20.width,
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                5.width,
                Text(
                  '2.00pm',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hair care Specialists near you',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF109615), // Green color
            ),
          ),
          15.height,
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSpecialistCard(
                context,
                title: 'O\'Naturals Hair Beauty Salon',
                description:
                    'Natural hair specialists,Natural hair care and styling, bridal services, and hair products',
                location: 'Lekki Phase I, Lagos.',
                imageUrl: 'assets/images/specialist_1.png', // Placeholder
              ),
              _buildSpecialistCard(
                context,
                title: 'Hair by Adefunkeee',
                description:
                    'Natural hair specialists,Natural hair care and styling, bridal services, and hair products',
                location: 'Lekki Phase I, Lagos.',
                imageUrl: 'assets/images/specialist_2.png', // Placeholder
              ),
              _buildSpecialistCard(
                context,
                title: 'The Hair Centre Salon',
                description:
                    'Natural hair specialists,Natural hair care and styling, bridal services, and hair products',
                location: 'Lekki Phase I, Lagos.',
                imageUrl: 'assets/images/specialist_3.png', // Placeholder
              ),
              _buildSpecialistCard(
                context,
                title: 'Mo\'s Beauty Bar',
                description:
                    'Natural hair specialists,Natural hair care and styling, bridal services, and hair products',
                location: 'Lekki Phase I, Lagos.',
                imageUrl: 'assets/images/specialist_4.png', // Placeholder
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistCard(
    BuildContext context, {
    required String title,
    required String description,
    required String location,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // Light grey background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {},
                  ),
                ),
              ),
              15.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.height,
                    Text(
                      description,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontSize: 11,
                      ),
                    ),
                    8.height,
                    Row(
                      children: [
                        const Icon(Icons.store, size: 14, color: Colors.green),
                        5.width,
                        Text(
                          location,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          15.height,
          const Divider(height: 1, color: Colors.grey),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialIcon(Icons.phone, filled: true),
              _buildSocialIcon(Icons.email_outlined),
              _buildSocialIcon(Icons.camera_alt_outlined), // Instagram
              _buildSocialIcon(Icons.location_on_outlined),
              _buildSocialIcon(Icons.music_note), // TikTok
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, {bool filled = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: filled ? const Color(0xFF109615) : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFF109615),
        ),
      ),
      child: Icon(
        icon,
        size: 18,
        color: filled ? Colors.white : const Color(0xFF109615),
      ),
    );
  }
}

class PlanTab extends StatefulWidget {
  const PlanTab({super.key});

  @override
  State<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends State<PlanTab> {
  final List<RoutineViewModel> routines = [];
  TextEditingController goalNameController = TextEditingController();
  List<String> routineList = [];
  DateTime? startDate;
  TimeOfDay? startTime;

  _addRoutine() {
    final routine = RoutineViewModel(
      goalName: goalNameController.text,
      routine: routineList,
      startDate: startDate,
      time: startTime,
    );
    if (routine.validate()) {
      goalNameController.clear();
      routineList.clear();
      startDate = null;
      startTime = null;
      setState(() {
        routines.add(routine);
      });
    } else {
      context.showFeedBackDialog(message: 'Please fill all fields');
    }
  }

  _removeNewRoutine(int index) {
    setState(() {
      routines.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          40.height,
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              border: Border.all(color: AppColors.primaryBorder),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 11,
                  color: Color(0x40CEBDE4),
                  offset: Offset(1, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a goal for your hair?',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.greyTextColor3,
                        ),
                      ),
                      Text(
                        'Selection an option',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                4.width,
                SvgPicture.asset('dropdown2'.toSvg),
              ],
            ),
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  "Create a Routine:",
                  style: CustomTextStyle.labelMedium,
                ),
              ),
              InkWell(
                onTap: _addRoutine,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryBorder),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Add Another Routine",
                        style: TextStyle(
                          color: Color(0xFF2E2E2E), // Text color #2E2E2E
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      5.width,
                      const Icon(Icons.add, size: 16, color: Color(0xFF109615)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          12.height,
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFFA2A2A2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE), // Background #EEEEEE
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF109615),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Enter routine name?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextField(
                                    controller: goalNameController,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Enter a routine name",
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     final newList = [
                            //       controllers[index].text,
                            //       ...?routines[index].routine
                            //     ];
                            //     routines[index] = RoutineViewModel(
                            //       goalName: routines[index].goalName,
                            //       routine: newList,
                            //       time: routines[index].time,
                            //       startDate: routines[index].startDate,
                            //     );
                            //   },
                            //   child: RotatedBox(
                            //     quarterTurns: 3,
                            //     child: SvgPicture.asset('dropdown2'.toSvg),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      15.height,
                      const Text(
                        "What will you do?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E2E2E),
                        ),
                      ),
                      10.height,
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: routineList.map((activity) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  activity,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                5.width,
                                InkWell(
                                  onTap: () {
                                    routineList.remove(activity);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.close,
                                      size: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      15.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            final item = await showDialog<String>(
                              context: context,
                              builder: (context) {
                                final itemCtrl = TextEditingController();
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Add Activity",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        8.height,
                                        TextField(
                                          autofocus: true,
                                          controller: itemCtrl,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                        8.height,
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              final res = itemCtrl.text;
                                              Navigator.pop(
                                                context,
                                                res,
                                              );
                                            },
                                            child: const Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            if (item != null) {
                              setState(() {
                                routineList.add(item);
                              });
                            }
                            // itemCtrl.dispose();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight, // Light green
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primaryBorder,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Add an Item",
                                  style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.add,
                                    size: 16, color: Color(0xFF109615)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xffDCF8C6), // Footer green
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(46),
                    ),
                  ),
                  child: Wrap(
                    children: [
                      InkWell(
                        onTap: () async {
                          final startTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (startTime != null) {
                            setState(() {
                              this.startTime = startTime;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              startTime == null
                                  ? 'Select start time'
                                  : "${startTime?.format(context)} Daily",
                              style: const TextStyle(
                                color: Color(0xFF2E2E2E),
                                fontSize: 14,
                              ),
                            ),
                            5.width,
                            SvgPicture.asset(
                              'clock'.toSvg,
                              height: 12,
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      4.width,
                      InkWell(
                        onTap: () async {
                          final startDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (startDate != null) {
                            setState(() {
                              this.startDate = startDate;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              startDate == null
                                  ? 'Select start date'
                                  : DateFormat('dd.MM.yyyy').format(startDate!),
                              style: context.textTheme.bodyMedium,
                            ),
                            5.width,
                            SvgPicture.asset(
                              'date'.toSvg,
                              height: 12,
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      6.width,
                    ],
                  ),
                ),
              ),
              42.width
            ],
          ),
          12.height,
          ...List.generate(
            routines.length,
            (index) => Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFA2A2A2),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE), // Background #EEEEEE
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFF109615),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      routines[index].goalName ?? '',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     final newList = [
                              //       controllers[index].text,
                              //       ...?routines[index].routine
                              //     ];
                              //     routines[index] = RoutineViewModel(
                              //       goalName: routines[index].goalName,
                              //       routine: newList,
                              //       time: routines[index].time,
                              //       startDate: routines[index].startDate,
                              //     );
                              //   },
                              //   child: RotatedBox(
                              //     quarterTurns: 3,
                              //     child: SvgPicture.asset('dropdown2'.toSvg),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        15.height,
                        const Text(
                          "What you will do",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2E2E2E),
                          ),
                        ),
                        10.height,
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: routines[index].routine?.map((activity) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        activity,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          decoration: const BoxDecoration(
                            color: Color(0xffDCF8C6), // Footer green
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(46),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${routines[index].time?.format(context)} Daily",
                                    style: const TextStyle(
                                      color: Color(0xFF2E2E2E),
                                      fontSize: 14,
                                    ),
                                  ),
                                  5.width,
                                  SvgPicture.asset(
                                    'clock'.toSvg,
                                    height: 12,
                                    width: 12,
                                  ),
                                ],
                              ),
                              4.width,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    DateFormat('dd.MM.yyyy')
                                        .format(routines[index].startDate!),
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  5.width,
                                  SvgPicture.asset(
                                    'date'.toSvg,
                                    height: 12,
                                    width: 12,
                                  ),
                                ],
                              ),
                              6.width,
                            ],
                          ),
                        ),
                      ),
                      30.width,
                      InkWell(
                        onTap: () {
                          _removeNewRoutine(index);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 12,
                        ),
                      )
                    ],
                  ),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  //   decoration: const BoxDecoration(
                  //     color: Color(0xffDCF8C6), // Footer green
                  //     borderRadius:
                  //         BorderRadius.vertical(bottom: Radius.circular(10)),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       const Text(
                  //         "2.00pm Daily",
                  //         style: TextStyle(
                  //           color: Color(0xFF2E2E2E),
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //       5.width,
                  //       const Icon(Icons.access_time,
                  //           color: Color(0xFF109615), size: 20),
                  //       const Spacer(),
                  //       const Text(
                  //         "09.10.2025",
                  //         style: TextStyle(
                  //           color: Color(0xFF2E2E2E),
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //       5.width,
                  //       const Icon(Icons.calendar_today,
                  //           color: Color(0xFF109615), size: 20),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
