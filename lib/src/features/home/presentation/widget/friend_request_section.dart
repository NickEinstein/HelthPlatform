import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart'; // for context.push

class FriendRequestSection extends ConsumerWidget {
  const FriendRequestSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendRequestAsync = ref.watch(userFriendRequestReceiverProvider);

    return friendRequestAsync.when(
      data: (friendRequests) {
        final filteredRequests =
            friendRequests.where((request) => request.status == 1).toList();

        if (filteredRequests.isEmpty) {
          // 🔥 Don't show anything if no friend requests
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredRequests.length} New Friend Request${filteredRequests.length > 1 ? 's' : ''}",
                    style: const TextStyle(
                      color: Color(0xff343333),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(Routes.ALLFRIENDREQUEST);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffE7E7E7),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                final request = filteredRequests[index];
                final sender = request.patientSender;
                final name = "${sender!.firstName} ${sender.lastName}";
                final description = sender.gender ?? 'N/A';
                final imageUrl = sender.pictureUrl ?? '';

                return NewFriendRequestCard(
                  name: name,
                  description: description.isNotEmpty ? description : 'N/A',
                  imageUrl: imageUrl,
                  onViewProfile: () {
                    context.push(Routes.VIEWPATIENTPAGE, extra: request);
                  },
                  isFirst: index == 0,
                  isLast: index == filteredRequests.length - 1,
                );
              },
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(), // 🔥 Don't show loader here
      error: (err, stack) => const SizedBox.shrink(),
    );
  }
}
