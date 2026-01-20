import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/action_button.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/conversations_content.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/general_chat_content.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/group_joined_content.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/media_tab_content.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/my_friends_content.dart';
import 'package:greenzone_medical/src/features/community_profile/widgets/my_page_content.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class CommunityProfile extends ConsumerStatefulWidget {
  const CommunityProfile({super.key});

  @override
  ConsumerState<CommunityProfile> createState() => _CommunityProfileState();
}

class _CommunityProfileState extends ConsumerState<CommunityProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                onPressed: () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=2576&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gabriella Dickson Williams',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    4.height,
                    const Text(
                      '560 Friends. Joined 3 Groups. 608 Posts',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    16.height,
                    // Friends Face Pile
                    SizedBox(
                      height: 40,
                      child: Stack(
                        children: List.generate(
                          6,
                          (index) => Positioned(
                            left: index * 25.0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=${index + 10}',
                              ),
                              backgroundColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    16.height,
                    // Action Buttons
                    Row(
                      children: [
                        const Expanded(
                            child: ActionButton(
                                label: 'Find Friends',
                                isPrimary: true,
                                icon: Icons.add)),
                        8.width,
                        const Expanded(
                            child: ActionButton(
                                label: 'Find a Group',
                                isPrimary: false,
                                isLight: true)),
                      ],
                    ),
                    8.height,
                    Row(
                      children: [
                        const Expanded(
                            child: ActionButton(
                                label: 'Create a Post',
                                isPrimary: false,
                                icon: Icons.add,
                                isOutlined: true)),
                        8.width,
                        const Expanded(
                            child: ActionButton(
                                label: 'Share',
                                isPrimary: false,
                                icon: Icons.share,
                                isGrey: true)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: ColorConstant.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: ColorConstant.primaryColor,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    const Tab(text: 'My Page'),
                    Tab(
                        child: Row(
                      children: [
                        const Text('Media'),
                        4.width,
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF9F5FF),
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        )
                      ],
                    )),
                    const Tab(text: 'General Chat'),
                    const Tab(text: 'My Friends'),
                    const Tab(text: 'Group Joined'),
                    const Tab(text: 'Conversations'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            MyPageContent(),
            MediaTabContent(),
            GeneralChatContent(),
            MyFriendsContent(),
            GroupJoinedContent(),
            ConversationsContent(),
          ],
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
