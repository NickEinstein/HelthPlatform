import 'package:greenzone_medical/src/features/community/presentation/widget/group_tab_view.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../../../utils/share_button.dart';
import 'widget/build_group_avatars.dart';

class CommunityDetails extends ConsumerWidget {
  final CommunityListResponse community; // Receive the community object

  const CommunityDetails({super.key, required this.community});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginDataAsync = ref.watch(loginDataProvider);
    final isLoading = ref.watch(isLoadingProvider);

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

            final isMember = community.communityGroupMembers!.any(
              (member) => member.patient!.id == userId,
            );

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
                          community.pictureUrl!.startsWith('http')
                              ? community.pictureUrl!
                              : '${AppConstants.noSlashImageURL}${community.pictureUrl}',
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Handle name split and initials
                            final fullName = "${community.name}";
                            final nameParts =
                                fullName.trim().split(RegExp(r'\s+'));
                            String initials = '';
                            final nonTitleParts = nameParts
                                .where((p) => !p.endsWith('.'))
                                .toList();
                            if (nonTitleParts.isNotEmpty) {
                              initials += nonTitleParts.first[0];
                              if (nonTitleParts.length > 1) {
                                initials += nonTitleParts.last[0];
                              }
                            }

                            return Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                color: getAvatarColor(fullName),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                initials.toUpperCase(),
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
                      // NetworkImageWithFallback(
                      //   imageUrl: community.pictureUrl!,
                      //   width: double.infinity,
                      //   height: 300,
                      //   borderRadius: 0,
                      //   fallbackAsset: 'assets/images/fitnessfull.png',
                      // ),
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
                        community.name!,
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
                      buildCommunityAvatars(community.communityGroupMembers!,
                          community, context, true),
                      mediumSpace(),
                      if (isMember)
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorConstant.primaryColor,
                                      foregroundColor:
                                          ColorConstant.primaryColor,
                                      minimumSize:
                                          const Size(double.infinity, 55),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () async {
                                      context.push(
                                        Routes.FRIENDWITHSEARCHPAGE,
                                        extra: {
                                          'community': community,
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        tiny5HorSpace(),
                                        const Text(
                                          "Invite Members",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width: 8), // spacing between buttons
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffDDF8DE),
                                      foregroundColor:
                                          ColorConstant.primaryColor,
                                      minimumSize:
                                          const Size(double.infinity, 55),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1,
                                            color: ColorConstant.primaryColor),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () async {
                                      shareContent(
                                        title:
                                            "I'm inviting you to join ${community.name} group on Connected Health App",
                                        message:
                                            "Join our amazing community today. 🌟 here https:edogoveerp.com",
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.share,
                                          color: ColorConstant.primaryColor,
                                        ),
                                        smallHorSpace(),
                                        const Text(
                                          "Share",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: ColorConstant.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            smallSpace(),
                            if (isMember)
                              GroupTabView(
                                community: community,
                              ),
                            // GroupPostList(
                            //   groupId: 3,
                            //   pageNumber: 1,
                            //   pageSize: 20,
                            // ),
                            smallSpace(),
                          ],
                        ),

                      if (!isMember)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About",
                              style: TextStyle(
                                  color: Color(0xff3C3B3B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            tiny5Space(),
                            Text(
                              community.description ??
                                  "No description available",
                              style: const TextStyle(
                                  color: Color(0xff595959),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            mediumSpace(),
                            const Text(
                              "Group Activity",
                              style: TextStyle(
                                  color: Color(0xff3C3B3B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            tiny5Space(),
                            Text(
                              timeAgo(community.createdAt, 'Created'),
                              style: const TextStyle(
                                  color: Color(0xff595959),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),

                      // dd
                      //   GroupTabView(
                      //     community: community,
                      //   ),
                      verticalSpace(context, 0.03),

                      !isMember
                          ? isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConstant.primaryColor,
                                    foregroundColor: ColorConstant.primaryColor,
                                    minimumSize:
                                        const Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    ref.read(isLoadingProvider.notifier).state =
                                        true; // ✅ Start loading

                                    final allService =
                                        ref.read(allServiceProvider);
                                    final result = await allService
                                        .joinCommunity(community.id!);

                                    if (!context.mounted) return;

                                    ref.read(isLoadingProvider.notifier).state =
                                        false; // ✅ Stop loading

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
                                  child: const Text(
                                    "Follow Group",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                )
                          : const SizedBox(), // Hide button if already a member

                      verticalSpace(context, 0.04),
                    ],
                  ),
                )
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const Text("Failed to load data"),
        ),
      ),
    );
  }
}
