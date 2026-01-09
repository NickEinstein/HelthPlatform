import 'package:greenzone_medical/src/features/plan/widgets/care_goal_plan_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/community_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/journals_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/knowledge_tab.dart';
import 'package:greenzone_medical/src/features/plan/widgets/specialist_tab.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final planProvider =
        widget.myApp.title.isEmpty || widget.myApp.category.isEmpty
            ? ref.watch(singlePlanProvider(widget.myApp.id))
            : null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (context.mediaQuery.viewInsets.bottom > 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          if (mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                          if (widget.myApp.title.isEmpty)
                            planProvider?.when(
                                  data: (data) => Text(
                                    data?.title ?? '',
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  loading: () =>
                                      const Text('Loading').shimmer(),
                                  error: (e, s) => const SizedBox.shrink(),
                                ) ??
                                const SizedBox.shrink(),
                          if (widget.myApp.title.isNotEmpty)
                            Text(
                              widget.myApp.title,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          5.height,
                          if (widget.myApp.category.isEmpty)
                            planProvider?.when(
                                  data: (data) => Text(
                                    data?.category ?? '',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  loading: () =>
                                      const Text('Getting Category').shimmer(),
                                  error: (e, s) => const SizedBox.shrink(),
                                ) ??
                                const SizedBox.shrink(),
                          if (widget.myApp.category.isNotEmpty)
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
                  if (widget.myApp.category.isEmpty)
                    planProvider?.when(
                          data: (data) =>
                              CareGoalPlanTab(myApp: data ?? widget.myApp),
                          loading: () => Center(
                            child: const Text('Loading').shimmer(),
                          ),
                          error: (e, s) => const SizedBox.shrink(),
                        ) ??
                        const SizedBox.shrink(),
                  if (widget.myApp.category.isNotEmpty)
                    CareGoalPlanTab(myApp: widget.myApp),
                  const Center(child: Text('Products Loading')),
                  const KnowledgeTab(),
                  const CommunityTab(),
                  JournalsTab(app: widget.myApp),
                  const SpecialistTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
