import 'package:greenzone_medical/src/model/community_list_response.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/network_img_fallback.dart';
import '../../../utils/packages.dart';
import '../../chats/presentation/model/chatcontact_model.dart';
import 'widget/build_group_avatars.dart';

class CommunityFriendDetails extends ConsumerWidget {
  final CommunityListResponse community; // Receive the community object
  final int id;
  const CommunityFriendDetails({
    super.key,
    required this.community,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginDataAsync = ref.watch(loginDataProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final patientIdResponse = ref.watch(userPatientIdProvider(id));
    final friendsListAsync = ref.watch(userAllFriendsSenderProvider);
    final isMember = community.communityGroupMembers!.any(
      (member) => member.patient!.id == id,
    );
// put here 👇
    final isFriend = friendsListAsync.when(
      data: (friendsList) {
        if (friendsList.isEmpty) {
          return false;
        }

        final friendIds =
            friendsList.map((friend) => friend.friendPatient!.id).toList();

        return friendIds.contains(id); // 👈 use contains after mapping
      },
      loading: () {
        return true;
      },
      error: (error, _) {
        return false;
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: loginDataAsync.when(
          data: (loginData) {
            if (loginData == null) {
              return const Center(child: Text("No login data available"));
            }

            final decodedData = jsonDecode(loginData);
            final userId = decodedData["userID"];

            return patientIdResponse.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => const Center(child: Text('')),
              data: (patientProfile) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              patientProfile.pictureUrl!.startsWith('http')
                                  ? patientProfile.pictureUrl!
                                  : '${AppConstants.noSlashImageURL}${patientProfile.pictureUrl!}',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Handle name split and initials

                                return Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: getAvatarColor(
                                        patientProfile.firstName! +
                                            patientProfile.lastName!),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${patientProfile.firstName![0]}${patientProfile.lastName![0]}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 42,
                            left: 12,
                            child: CustomHeader(
                              // title: community.name ?? '',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              // onSearchPressed: () {
                              //   context.push(Routes.SEARCHCOMMUNITY);
                              // },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallSpace(),
                          Text(
                            '${patientProfile.firstName!} ${patientProfile.lastName!}',
                            style: const TextStyle(
                                color: Color(0xff3C3B3B),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          tiny5Space(),
                          Text(
                            "Public. ${community.communityGroupMembers!.length} members.",
                            style: const TextStyle(
                                color: Color(0xff595959),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          mediumSpace(),
                          buildCommunityAvatars(
                              community.communityGroupMembers!,
                              community,
                              context,
                              false),
                          mediumSpace(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "About ${patientProfile.firstName}",
                                style: const TextStyle(
                                    color: Color(0xff3C3B3B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              tiny5Space(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Gender",
                                        style: TextStyle(
                                            color: Color(0xff3C3B3B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      tinyHorSpace(),
                                      Text(
                                        patientProfile.gender ?? "",
                                        style: const TextStyle(
                                            color: Color(0xff595959),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  tinySpace(),
                                  Row(
                                    children: [
                                      const Text(
                                        "State",
                                        style: TextStyle(
                                            color: Color(0xff3C3B3B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      tinyHorSpace(),
                                      Text(
                                        patientProfile.stateOfOrigin ?? "",
                                        style: const TextStyle(
                                            color: Color(0xff595959),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  tinySpace(),
                                  Row(
                                    children: [
                                      const Text(
                                        "Marital Status",
                                        style: TextStyle(
                                            color: Color(0xff3C3B3B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      tinyHorSpace(),
                                      Text(
                                        patientProfile.maritalStatus ?? "",
                                        style: const TextStyle(
                                            color: Color(0xff595959),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  tinySpace(),
                                ],
                              ),
                              verticalSpace(context, 0.08),
                              if (id != userId)
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Column(
                                        children: [
                                          Row(
                                            children: [
                                              if (isFriend)
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffB4F0B6),
                                                      foregroundColor:
                                                          ColorConstant
                                                              .primaryColor,
                                                      minimumSize: const Size(
                                                          double.infinity, 55),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: ColorConstant
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      ref
                                                              .read(
                                                                  isLoadingProvider
                                                                      .notifier)
                                                              .state =
                                                          true; // ✅ Start loading

                                                      final allService = ref.read(
                                                          allServiceProvider);
                                                      final result =
                                                          await allService
                                                              .unFollowFriendRequest(
                                                                  patientProfile
                                                                      .id!);

                                                      if (!context.mounted)
                                                        return;

                                                      ref
                                                              .read(
                                                                  isLoadingProvider
                                                                      .notifier)
                                                              .state =
                                                          false; // ✅ Stop loading

                                                      if (result ==
                                                          'successful') {
                                                        showInfoBottomSheet(
                                                          context,
                                                          'Hello!',
                                                          '${patientProfile.firstName} has been remove from your friend list.',
                                                          buttonText: 'Close',
                                                          isAnotherTime: false,
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);

                                                            context.pushReplacement(
                                                                Routes
                                                                    .BOTTOMNAV);
                                                          },
                                                        );
                                                      } else {
                                                        CustomToast.show(
                                                            context, result,
                                                            type: ToastType
                                                                .error);
                                                      }
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Unfollow",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14,
                                                            color: ColorConstant
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(
                                                  width:
                                                      10), // spacing between buttons
                                              if (!isFriend)
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          ColorConstant
                                                              .primaryColor,
                                                      foregroundColor:
                                                          ColorConstant
                                                              .primaryColor,
                                                      minimumSize: const Size(
                                                          double.infinity, 55),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 1,
                                                            color: ColorConstant
                                                                .primaryColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      ref
                                                              .read(
                                                                  isLoadingProvider
                                                                      .notifier)
                                                              .state =
                                                          true; // ✅ Start loading

                                                      final allService = ref.read(
                                                          allServiceProvider);
                                                      final result =
                                                          await allService
                                                              .followFriendRequest(
                                                                  patientProfile
                                                                      .id!);

                                                      if (!context.mounted)
                                                        return;

                                                      ref
                                                              .read(
                                                                  isLoadingProvider
                                                                      .notifier)
                                                              .state =
                                                          false; // ✅ Stop loading

                                                      if (result ==
                                                          'Join successful') {
                                                        showInfoBottomSheet(
                                                          context,
                                                          'Hello, good news!',
                                                          '${patientProfile.firstName} has received your friend request.',
                                                          buttonText: 'Close',
                                                          isAnotherTime: false,
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);

                                                            context.pushReplacement(
                                                                Routes
                                                                    .BOTTOMNAV);
                                                          },
                                                        );
                                                      } else if (result.contains(
                                                          'already exists')) {
                                                        CustomToast.show(
                                                            context,
                                                            'There is already a pending friend request for this patient.',
                                                            type: ToastType
                                                                .error);
                                                      } else {
                                                        CustomToast.show(
                                                            context, result,
                                                            type: ToastType
                                                                .error);
                                                      }
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Follow",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          smallSpace(),
                                          if (isFriend)
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xffDDF8DE),
                                                foregroundColor:
                                                    const Color(0xffDDF8DE),
                                                minimumSize: const Size(
                                                    double.infinity, 55),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color: ColorConstant
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () async {
                                                // Create a ChatContact object
                                                final chat = ChatContact(
                                                  id: patientProfile.id!,
                                                  firstName: patientProfile
                                                          .firstName ??
                                                      '',
                                                  lastName:
                                                      patientProfile.lastName ??
                                                          '',
                                                  email: patientProfile.email ??
                                                      '',
                                                  pictureUrl: patientProfile
                                                          .pictureUrl ??
                                                      '',
                                                  unreadCount: 0,
                                                  lastMessage: "",
                                                  userType: 1,
                                                  lastMessageDate:
                                                      DateTime.now(),
                                                );

                                                await context.push(
                                                    Routes.CHATDETAILS,
                                                    extra: chat);
                                              },
                                              child: Text(
                                                "Chat with #${patientProfile.firstName}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color(0xff000000)),
                                              ),
                                            ),
                                          smallSpace(),
                                          if (!isMember)
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    ColorConstant.primaryColor,
                                                foregroundColor:
                                                    ColorConstant.primaryColor,
                                                minimumSize: const Size(
                                                    double.infinity, 55),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color: ColorConstant
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () async {
                                                ref
                                                        .read(isLoadingProvider
                                                            .notifier)
                                                        .state =
                                                    true; // ✅ Start loading

                                                final allService = ref
                                                    .read(allServiceProvider);
                                                final result = await allService
                                                    .sendInviteRequest(
                                                        patientProfile.id!,
                                                        community.id!);

                                                if (!context.mounted) return;

                                                ref
                                                        .read(isLoadingProvider
                                                            .notifier)
                                                        .state =
                                                    false; // ✅ Stop loading

                                                if (result == 'successful') {
                                                  showInfoBottomSheet(
                                                    context,
                                                    'Hello, good news!',
                                                    '${patientProfile.firstName} has received your invite to join ${community.name} group.',
                                                    buttonText: 'Close',
                                                    isAnotherTime: false,
                                                    onPressed: () async {
                                                      Navigator.pop(context);

                                                      context.pushReplacement(
                                                          Routes.BOTTOMNAV);
                                                    },
                                                  );
                                                } else {
                                                  CustomToast.show(
                                                      context, result,
                                                      type: ToastType.error);
                                                }
                                              },
                                              child: Text(
                                                "Send invite to #${patientProfile.firstName}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                        ],
                                      ),
                              const SizedBox(height: 16),
                            ],
                          ),
                          verticalSpace(context, 0.04),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const Text("Failed to load data"),
        ),
      ),
    );
  }
}
