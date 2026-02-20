import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';
import 'group_interest_card.dart';

class AllGroupInterestScreen extends ConsumerWidget {
  final List<int> categoryIds;

  const AllGroupInterestScreen({Key? key, required this.categoryIds})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInterestAsync =
        ref.watch(userGroupInterestProvider(categoryIds));
    final loginDataAsync = ref.watch(loginDataProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              verticalSpace(context, 0.02),
              CustomHeader(
                title: 'Groups',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: loginDataAsync.when(
                  data: (loginData) {
                    if (loginData == null) {
                      return const Center(
                          child: Text("No login data available"));
                    }

                    final decodedData = jsonDecode(loginData);
                    final userId = decodedData["userID"].toString();

                    return groupInterestAsync.when(
                      data: (groupRequests) {
                        final filteredGroups = groupRequests.where((group) {
                          final members = group.communityGroupMembers ?? [];
                          return !members.any((member) =>
                              member.patient?.id.toString() == userId);
                        }).toList();

                        if (filteredGroups.isEmpty) {
                          return const Center(
                              child: Text('No groups available'));
                        }

                        return ListView(
                          children: [
                            ...filteredGroups.map((group) {
                              final index = filteredGroups.indexOf(group);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: GroupInterestCard(
                                  name: group.name ?? '',
                                  description:
                                      '${group.communityGroupMembers!.length} members',

                                  //  group.category?.name ?? '',
                                  imageUrl: group.pictureUrl ?? '',
                                  onViewProfile: () {
                                    context.push(
                                      Routes.COMMUNITYDETAILS,
                                      extra: group,
                                    );
                                  },
                                  isFirst: index == 0,
                                  isLast: index == filteredGroups.length - 1,
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => const SizedBox.shrink(),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) =>
                      const Center(child: Text('Failed to load login data')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
