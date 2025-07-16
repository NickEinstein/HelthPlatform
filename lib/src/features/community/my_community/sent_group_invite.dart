// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../presentation/widget/group_card.dart';

class SentGroupInvites extends ConsumerStatefulWidget {
  const SentGroupInvites({super.key});

  @override
  ConsumerState<SentGroupInvites> createState() => _SentGroupInvitesState();
}

class _SentGroupInvitesState extends ConsumerState<SentGroupInvites> {
  String searchQuery = '';
  int selectedIndex = 0;
  List<String> categories = ["All"];

  @override
  Widget build(BuildContext context) {
    final communityReceiverAsync = ref.watch(userSenderCommunityProvider);
    final loginDataAsync = ref.watch(loginDataProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return loginDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('Error $error.'),
      ),
      data: (loginData) {
        if (loginData == null || loginData.isEmpty) {
          return const Center(child: Text("User data not found"));
        }

        return communityReceiverAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => const Center(
                  child: Text('No pending request found '),
                ),
            data: (communityList) {
              final filteredList = selectedIndex == 0
                  ? communityList
                  : communityList
                      .where((community) =>
                          community.patientReceiver!.firstName! ==
                          categories[selectedIndex])
                      .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  filteredList.isEmpty
                      ? const Center(child: Text("No pending request found"))
                      : ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap:
                              true, // Add shrinkWrap to ensure it gets proper constraints
                          children: filteredList.map((community) {
                            return Column(
                              children: [
                                GroupCard(
                                  onPressed: () {},
                                  isSentInvite: true,
                                  imageUrl: (community.patientReceiver
                                                  ?.pictureUrl !=
                                              null &&
                                          community.patientReceiver!.pictureUrl!
                                              .contains('uploads'))
                                      ? '${AppConstants.imageURL}${community.patientReceiver!.pictureUrl!}'
                                      : (community.patientReceiver?.pictureUrl
                                                  ?.isNotEmpty ??
                                              false)
                                          ? community
                                              .patientReceiver!.pictureUrl!
                                          : 'assets/images/fitness1.png',
                                  title: '${community.communityGroup!.name}',
                                  subtitle:
                                      '${community.patientReceiver!.firstName!} ${community.patientReceiver!.lastName!}',
                                  buttonText: 'Join',
                                  isMember: true,
                                  isAcceptReject: false,
                                  isLoading: isLoading,
                                  onButtonPressed: () async {},
                                ),
                                smallSpace(),
                              ],
                            );
                          }).toList(),
                        ),
                ],
              );
            });
      },
    );
  }
}
