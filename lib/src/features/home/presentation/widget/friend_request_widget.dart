import '../../../../utils/packages.dart';
import 'group_interest_card.dart';

class FriendRequestWidget extends ConsumerWidget {
  const FriendRequestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final groupInterestAsync = ref.watch(userGroupInterestProvider([]));
    // final loginDataAsync = ref.watch(loginDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "87 New Friends Request",
                  style: TextStyle(
                    color: Color(0xff343333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffE7E7E7),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        8.height,
        // Group List (max 2 groups)
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return GroupInterestCard(
              name: "Jessica Williams",
              description: 'Vegetarian, Walk-Outs',
              // group.category?.name ?? '',
              imageUrl: '',
              onViewProfile: () {
                // context.push(
                //   Routes.COMMUNITYDETAILS,
                //   extra: group,
                // );
              },
              isFriend: true,
              isFirst: index == 0,
              isLast: index == 1,
            );
          },
        ),
      ],
    );
    // loginDataAsync.when(
    //   data: (loginData) {
    //     if (loginData == null) {
    //       return const Center(child: Text("No login data available"));
    //     }

    //     final decodedData = jsonDecode(loginData);
    //     final userId = decodedData["userID"].toString();

    //     return groupInterestAsync.when(
    //       data: (groupRequests) {
    //         final filteredGroups = groupRequests.where((group) {
    //           final members = group.communityGroupMembers ?? [];
    //           return !members.any((member) =>
    //               member.patient?.id.toString() ==
    //               // 123);
    //               userId);
    //         }).toList();

    //         // Limit to first 2 groups
    //         final limitedGroups = filteredGroups.take(2).toList();

    //         if (limitedGroups.isEmpty) {
    //           return const SizedBox
    //               .shrink(); // or a "No groups available" widget
    //         }

    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             // Title
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 10),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Expanded(
    //                     child: Text(
    //                       "${limitedGroups.length} New Friends Request",
    //                       style: const TextStyle(
    //                         color: Color(0xff343333),
    //                         fontSize: 16,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                     ),
    //                   ),
    //                   TextButton(
    //                     onPressed: () {},
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(20),
    //                         color: const Color(0xffE7E7E7),
    //                       ),
    //                       child: const Padding(
    //                         padding: EdgeInsets.symmetric(
    //                             vertical: 5, horizontal: 20),
    //                         child: Text(
    //                           "View All",
    //                           style: TextStyle(
    //                             color: Color(0xff5B5B5B),
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w400,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             8.height,
    //             // Group List (max 2 groups)
    //             ListView.builder(
    //               shrinkWrap: true,
    //               padding: EdgeInsets.zero,
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemCount: limitedGroups.length,
    //               itemBuilder: (context, index) {
    //                 final group = limitedGroups[index];
    //                 return GroupInterestCard(
    //                   name: group.name ?? '',
    //                   description:
    //                       '${group.communityGroupMembers!.length} members',
    //                   // group.category?.name ?? '',
    //                   imageUrl: group.pictureUrl ?? '',
    //                   onViewProfile: () {
    //                     context.push(
    //                       Routes.COMMUNITYDETAILS,
    //                       extra: group,
    //                     );
    //                   },
    //                   isFriend: true,
    //                   isFirst: index == 0,
    //                   isLast: index == limitedGroups.length - 1,
    //                 );
    //               },
    //             ),
    //           ],
    //         );
    //       },
    //       loading: () => const Center(child: CircularProgressIndicator()),
    //       error: (error, stack) => SizedBox.shrink(),
    //     );
    //   },
    //   loading: () => const Center(child: CircularProgressIndicator()),
    //   error: (error, stack) =>
    //       const Center(child: Text('Failed to load load data')),
    // );
  }
}
