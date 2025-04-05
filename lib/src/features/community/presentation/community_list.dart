import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';
import '../../article/presentation/widget/category_selector.dart';
import 'widget/group_card.dart';

// final isLoadingProvider = StateProvider<bool>((ref) => false);
final loadingMapProvider = StateProvider<Map<int, bool>>((ref) => {});

class CommunityList extends ConsumerStatefulWidget {
  const CommunityList({super.key});

  @override
  ConsumerState<CommunityList> createState() => _CommunityListState();
}

class _CommunityListState extends ConsumerState<CommunityList> {
  int selectedIndex = 0;
  List<String> categories = ["All"];

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(communityListProvider);
    final loginDataAsync = ref.watch(loginDataProvider);
    // final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Community',
                onPressed: () {
                  Navigator.pop(context);
                },
                onSearchPressed: () {
                  context.push(Routes.SEARCHCOMMUNITY);
                },
              ),
              smallSpace(),

              // Handle login data state
              loginDataAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Text('Error loading user data: $error'),
                ),
                data: (loginData) {
                  if (loginData == null || loginData.isEmpty) {
                    return const Center(child: Text("User data not found"));
                  }

                  final decodedData = jsonDecode(loginData);
                  final userId = decodedData["userID"];

                  return communityListAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
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

                      return Column(
                        children: [
                          CategorySelector(
                            categories: categories,
                            selectedIndex: selectedIndex,
                            onCategorySelected: (index) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          filteredList.isEmpty
                              ? const Center(
                                  child: Text("No communities found"))
                              : Column(
                                  children: filteredList.map((community) {
                                    bool isMember =
                                        community.communityMembers!.any(
                                      (member) => member.patient!.id == userId,
                                    );

                                    return Column(
                                      children: [
                                        GroupCard(
                                          onPressed: () {
                                            context.push(
                                              Routes.COMMUNITYDETAILS,
                                              extra: community,
                                            );
                                          },
                                          imageUrl: community.pictureUrl
                                                  .toString()
                                                  .contains('uploads')
                                              ? 'https://edogoverp.com/ConnectedHealthWebApi/${community.pictureUrl!}'
                                              : community.pictureUrl!.isNotEmpty
                                                  ? community.pictureUrl!
                                                  : 'assets/images/fitness1.png',
                                          title: community.name!,
                                          subtitle:
                                              '${community.communityMembers!.length} members',
                                          buttonText:
                                              isMember ? 'Joined' : 'Join',
                                          isMember: isMember,
                                          isLoading:
                                              ref.watch(loadingMapProvider)[
                                                      community.id] ??
                                                  false, // ✅ Track per card
                                          onButtonPressed: () async {
                                            final loadingMap = ref.read(
                                                loadingMapProvider.notifier);

                                            // ✅ Set loading for this specific ID
                                            loadingMap.state = {
                                              ...loadingMap.state,
                                              community.id!: true
                                            };

                                            final allService =
                                                ref.read(allServiceProvider);
                                            final result = await allService
                                                .joinCommunity(community.id!);

                                            if (!context.mounted) return;

                                            // ✅ Stop loading for this specific ID
                                            loadingMap.state = {
                                              ...loadingMap.state,
                                              community.id!: false
                                            };

                                            if (result == 'Join successful') {
                                              CustomToast.show(context,
                                                  'Joined the Community Successfully',
                                                  type: ToastType.success);
                                              context.pushReplacement(
                                                  Routes.BOTTOMNAV);
                                            } else {
                                              CustomToast.show(context, result,
                                                  type: ToastType.error);
                                            }
                                          },
                                        ),
                                        smallSpace(),
                                      ],
                                    );
                                  }).toList(),
                                ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
