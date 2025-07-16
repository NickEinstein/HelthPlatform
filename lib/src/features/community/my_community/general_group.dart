// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../presentation/widget/group_card.dart';

class GeneralGroups extends ConsumerStatefulWidget {
  const GeneralGroups({super.key});

  @override
  ConsumerState<GeneralGroups> createState() => _GeneralGroupsState();
}

class _GeneralGroupsState extends ConsumerState<GeneralGroups> {
  String searchQuery = '';
  int selectedIndex = 0;
  List<String> categories = ["All"];

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(communityListProvider);
    final loginDataAsync = ref.watch(loginDataProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return loginDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(
        child: Text('Error loading community'),
      ),
      data: (loginData) {
        if (loginData == null || loginData.isEmpty) {
          return const Center(child: Text("User data not found"));
        }

        final decodedData = jsonDecode(loginData);
        final userId = decodedData["userID"];

        return communityListAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => const Center(
                  child: Text('Error loading community'),
                ),
            data: (communityList) {
              categories = [
                "All",
                ...communityList
                    .map((community) => community.name!)
                    .toSet()
                    .toList()
              ];

              final filteredList = selectedIndex == 0
                  ? communityList
                  : communityList
                      .where((community) =>
                          community.name == categories[selectedIndex])
                      .toList();

              // 👉 Sort by number of members descending
              final popularCommunities = [...communityList];
              popularCommunities.sort((a, b) =>
                  (b.communityGroupMembers?.length ?? 0)
                      .compareTo(a.communityGroupMembers?.length ?? 0));

              return filteredList.isEmpty
                  ? const Center(child: Text("No communities found"))
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // optional if inside scrollable parent
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final community = filteredList[index];
                        final isMember = community.communityGroupMembers!
                            .any((member) => member.patient!.id == userId);

                        return Column(
                          children: [
                            GroupCard(
                              onPressed: () {
                                context.push(
                                  Routes.COMMUNITYDETAILS,
                                  extra: community,
                                );
                              },
                              imageUrl: community.pictureUrl!,
                              title: community.name!,
                              subtitle:
                                  '${community.communityGroupMembers!.length} members',
                              buttonText: isMember ? 'Joined' : 'Join',
                              isMember: isMember,
                              isLoading: isLoading,
                              onButtonPressed: () async {
                                final loadingMap =
                                    ref.read(loadingMapProvider.notifier);
                                loadingMap.state = {
                                  ...loadingMap.state,
                                  community.id!: true
                                };

                                final allService = ref.read(allServiceProvider);
                                final result = await allService
                                    .joinCommunity(community.id!);

                                if (!context.mounted) return;

                                loadingMap.state = {
                                  ...loadingMap.state,
                                  community.id!: false
                                };

                                if (result == 'Join successful') {
                                  CustomToast.show(context,
                                      'Joined the Community Successfully',
                                      type: ToastType.success);
                                  context.pushReplacement(Routes.BOTTOMNAV);
                                } else {
                                  CustomToast.show(context, result,
                                      type: ToastType.error);
                                }
                              },
                            ),
                            smallSpace(),
                          ],
                        );
                      },
                    );
            });
      },
    );
  }
}
