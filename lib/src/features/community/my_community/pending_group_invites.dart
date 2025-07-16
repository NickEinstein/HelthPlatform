// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../presentation/widget/group_card.dart';

class PendingGroupInvites extends ConsumerStatefulWidget {
  const PendingGroupInvites({super.key});

  @override
  ConsumerState<PendingGroupInvites> createState() =>
      _PendingGroupInvitesState();
}

class _PendingGroupInvitesState extends ConsumerState<PendingGroupInvites> {
  String searchQuery = '';
  int selectedIndex = 0;
  List<String> categories = ["All"];
  bool isAnimated = true; // Control animation visibility state.

  @override
  Widget build(BuildContext context) {
    final communityReceiverAsync = ref.watch(userReceiverCommunityProvider);
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
                  child: Text('No pending group invites '),
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
                      ? const Center(child: Text("No Pending invite found"))
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final community = filteredList[index];
                            final patientReceiver = community.patientReceiver;
                            final communityGroup = community.communityGroup;

                            if (patientReceiver == null ||
                                communityGroup == null) {
                              return const SizedBox
                                  .shrink(); // Skip items with missing data
                            }

                            return AnimatedOpacity(
                              opacity: isAnimated ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                // height: 100,
                                child: GroupCard(
                                  onPressed: () {},
                                  onRejecteddButtonPressed: () async {
                                    ref.read(isLoadingProvider.notifier).state =
                                        true;

                                    final allService =
                                        ref.read(allServiceProvider);
                                    final result = await allService
                                        .communityRespondToInvite(
                                      id: community.id!,
                                      isAccepted: false,
                                    );

                                    if (!context.mounted) return;

                                    ref.read(isLoadingProvider.notifier).state =
                                        false;

                                    if (result == 'successful') {
                                      showInfoBottomSheet(
                                        context,
                                        'Hello!',
                                        'Group rejected successfully',
                                        buttonText: 'Close',
                                        isAnotherTime: false,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          context.pushReplacement(
                                              Routes.BOTTOMNAV);
                                        },
                                      );
                                    } else {
                                      CustomToast.show(context, result,
                                          type: ToastType.error);
                                    }
                                  },
                                  onAcceptedButtonPressed: () async {
                                    ref.read(isLoadingProvider.notifier).state =
                                        true;

                                    final allService =
                                        ref.read(allServiceProvider);
                                    final result = await allService
                                        .communityRespondToInvite(
                                      id: community.id!,
                                      isAccepted: true,
                                    );

                                    if (!context.mounted) return;

                                    ref.read(isLoadingProvider.notifier).state =
                                        false;

                                    if (result == 'successful') {
                                      showInfoBottomSheet(
                                        context,
                                        'Hello!',
                                        'Group accepted successfully',
                                        buttonText: 'Close',
                                        isAnotherTime: false,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          context.pushReplacement(
                                              Routes.BOTTOMNAV);
                                        },
                                      );
                                    } else {
                                      CustomToast.show(context, result,
                                          type: ToastType.error);
                                    }
                                  },
                                  imageUrl: patientReceiver.pictureUrl ?? '',
                                  title: communityGroup.name ?? 'Unnamed Group',
                                  subtitle:
                                      '${patientReceiver.firstName ?? ''} ${patientReceiver.lastName ?? ''}',
                                  buttonText: 'Join',
                                  isMember: true,
                                  isAcceptReject: true,
                                  isLoading: isLoading,
                                  onButtonPressed: () async {
                                    final loadingMap =
                                        ref.read(loadingMapProvider.notifier);
                                    loadingMap.state = {
                                      ...loadingMap.state,
                                      community.id!: true,
                                    };

                                    final allService =
                                        ref.read(allServiceProvider);
                                    final result = await allService
                                        .joinCommunity(community.id!);

                                    if (!context.mounted) return;

                                    loadingMap.state = {
                                      ...loadingMap.state,
                                      community.id!: false,
                                    };

                                    if (result == 'Join successful') {
                                      CustomToast.show(
                                        context,
                                        'Joined the Community Successfully',
                                        type: ToastType.success,
                                      );
                                      context.pushReplacement(Routes.BOTTOMNAV);
                                    } else {
                                      CustomToast.show(context, result,
                                          type: ToastType.error);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ],
              );
            });
      },
    );
  }
}
