import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../provider/all_providers.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/custom_header.dart';
import 'widget/search_card.dart';

class SearchCommunity extends ConsumerStatefulWidget {
  const SearchCommunity({super.key});

  @override
  ConsumerState<SearchCommunity> createState() => _SearchCommunityState();
}

class _SearchCommunityState extends ConsumerState<SearchCommunity> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(communityListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Reduced or removed extra space
            verticalSpace(context, 0.08),

            CustomHeader(
              title: 'Community',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            tinySpace(),

            // 🔍 Search Bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffE6E6E6)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/search.png',
                          height: 32,
                          width: 25,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Search Group Name",
                              hintStyle: TextStyle(
                                  color: Color(0xff999999),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/icon/filter_icon.png',
                  height: 52,
                  width: 35,
                ),
              ],
            ),

            // 🏋️ Community List
            smallSpace(),
            Expanded(
              child: communityListAsync.when(
                data: (communityList) {
                  final filteredList = communityList
                      .where((community) =>
                          community.name!.toLowerCase().contains(searchQuery))
                      .toList();

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text("No communities found"),
                    );
                  }

                  return ListView.builder(
                    padding:
                        EdgeInsets.zero, // 🔹 Removes extra padding at the top
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final community = filteredList[index];
                      return SearchCard(
                        imageUrl: community.pictureUrl
                                .toString()
                                .contains('uploads')
                            ? 'https://edogoverp.com/ConnectedHealthWebApi/${community.pictureUrl!}'
                            : community.pictureUrl!.isNotEmpty
                                ? community.pictureUrl!
                                : 'assets/images/fitness1.png',
                        title: community.name ?? 'Unknown Community',
                        subtitle:
                            '${community.communityMembers?.length ?? 0} members',
                        onButtonPressed: () {
                          context.push(Routes.COMMUNITYDETAILS,
                              extra: community);
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text("Error: $error")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
