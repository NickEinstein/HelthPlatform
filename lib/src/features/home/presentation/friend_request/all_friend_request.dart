import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';

class AllFriendRequest extends ConsumerStatefulWidget {
  const AllFriendRequest({super.key});

  @override
  ConsumerState<AllFriendRequest> createState() => _AllFriendRequestState();
}

class _AllFriendRequestState extends ConsumerState<AllFriendRequest> {
  @override
  Widget build(BuildContext context) {
    final friendRequestAsync = ref.watch(userFriendRequestReceiverProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Friends Request',
                onPressed: () {
                  context.pushReplacement(Routes.BOTTOMNAV);
                },
              ),
              mediumSpace(),
              friendRequestAsync.when(
                data: (friendRequests) {
                  final filteredRequests = friendRequests
                      .where((request) => request.status == 1)
                      .toList();

                  if (filteredRequests.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          mediumSpace(),
                          const Text(
                            "No pending friend request",
                            style: TextStyle(
                              color: Color(0xff343333),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredRequests.length,
                        itemBuilder: (context, index) {
                          final request = filteredRequests[index];
                          final sender = request.patientSender;

                          if (sender == null) {
                            return const SizedBox
                                .shrink(); // or show a fallback UI
                          }

                          final name = "${sender.firstName} ${sender.lastName}";
                          final description = sender.gender?.isNotEmpty == true
                              ? sender.gender!
                              : 'N/A';
                          final imageUrl = sender.pictureUrl ?? '';

                          return NewFriendRequestCard(
                            name: name,
                            description: description,
                            imageUrl: imageUrl,
                            onViewProfile: () {
                              context.push(Routes.VIEWPATIENTPAGE,
                                  extra: request);
                            },
                            isFirst: index == 0,
                            isLast: index == filteredRequests.length - 1,
                          );
                        },
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
