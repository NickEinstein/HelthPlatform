import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: community.name ?? '',
                onPressed: () {
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  context.push(Routes.SEARCHCOMMUNITY);
                },
              ),
              smallSpace(),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (community.pictureUrl!.isNotEmpty &&
                        Uri.tryParse(community.pictureUrl!)?.hasAbsolutePath ==
                            true &&
                        !community.pictureUrl!.contains('uploads'))
                    ? Image.network(
                        community.pictureUrl!,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/fitnessfull.png', // 🔥 Default fallback asset
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                    : community.pictureUrl!.toString().contains('uploads')
                        ? Image.network(
                            'https://edogoverp.com/ConnectedHealthWebApi/${community.pictureUrl!}',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          )
                        : community.pictureUrl!.isEmpty
                            ? Image.asset(
                                'assets/images/fitnessfull.png', // 🔥 Ensure a valid asset is used
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                community
                                    .pictureUrl!, // 🔥 Ensure a valid asset is used
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
              ),
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
                "Public. ${community.communityMembers!.length} members.",
                style: const TextStyle(
                    color: Color(0xff595959),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              mediumSpace(),
              const Text(
                "About",
                style: TextStyle(
                    color: Color(0xff3C3B3B),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              tiny5Space(),
              Text(
                community.description ?? "No description available",
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
                timeAgo(community.createdAt),
                style: const TextStyle(
                    color: Color(0xff595959),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              verticalSpace(context, 0.08),

              // Check membership status and show "Join Group" button accordingly
              loginDataAsync.when(
                data: (loginData) {
                  if (loginData == null) {
                    return const Center(child: Text("No login data available"));
                  }

                  final decodedData = jsonDecode(loginData);
                  final userId = decodedData["userID"];

                  final isMember = community.communityMembers!.any(
                    (member) => member.patient!.id == userId,
                  );

                  return !isMember
                      ? isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primaryColor,
                                foregroundColor: ColorConstant.primaryColor,
                                minimumSize: const Size(double.infinity, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                ref.read(isLoadingProvider.notifier).state =
                                    true; // ✅ Start loading

                                final allService = ref.read(allServiceProvider);
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
                                "Join Group",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            )
                      : const SizedBox(); // Hide button if already a member
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => const Text("Failed to load data"),
              ),
              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
