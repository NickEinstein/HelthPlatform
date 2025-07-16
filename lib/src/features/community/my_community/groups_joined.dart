// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/all_providers.dart';
import '../../../routes/app_pages.dart';
import '../presentation/widget/search_card.dart';

class GroupsJoined extends ConsumerStatefulWidget {
  const GroupsJoined({super.key});

  @override
  ConsumerState<GroupsJoined> createState() => _GroupsJoinedState();
}

class _GroupsJoinedState extends ConsumerState<GroupsJoined> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(myCommunityListProvider);

    return communityListAsync.when(
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
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final community = filteredList[index];
            return SearchCard(
              imageUrl: community.pictureUrl!,
              title: community.name ?? 'Unknown Community',
              subtitle:
                  '${community.communityGroupMembers?.length ?? 0} members',
              onButtonPressed: () {
                context.push(Routes.COMMUNITYDETAILS, extra: community);
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          const Center(child: Text("No CommunityGroup found")),
    );
  }
}
