import 'package:greenzone_medical/src/features/plan/widgets/community_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/journals_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/knowledge_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/populated_plan_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/specialist_tab.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class SinglePlanDashboard extends ConsumerStatefulWidget {
  static const routeName = '/single-plan-dashboard';
  final RegularAppModel myApp;
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
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
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
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
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
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
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
                              ),
                      ),
                      const Center(child: Text('Products Loading')),
                      const KnowledgeTab(),
                      const CommunityTab(),
                      const JournalsTab(),
                      const SpecialistTab(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
