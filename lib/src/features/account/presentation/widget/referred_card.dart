// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/dimens.dart';
import '../../../../provider/all_providers.dart';
import '../../../community/presentation/widget/search_card.dart';

class RefferredCard extends ConsumerStatefulWidget {
  String fullName;

  RefferredCard({super.key, required this.fullName});

  @override
  ConsumerState<RefferredCard> createState() => _RefferredCardState();
}

class _RefferredCardState extends ConsumerState<RefferredCard> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final communityListAsync = ref.watch(myRefferredListProvider);

    return communityListAsync.when(
      data: (communityList) {
        final filteredList = communityList
            .where((community) =>
                community.firstName!.toLowerCase().contains(searchQuery))
            .toList();

        if (filteredList.isEmpty) {
          return const Center(
            child: Text("No referrals found"),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Hello ${widget.fullName}, you have invited ${filteredList.length} friends to CHP.',
                style: TextStyle(
                    color: Color(0xff615353),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            tinySpace(),
            Divider(),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final community = filteredList[index];
                return Column(
                  children: [
                    SearchCard(
                      imageUrl: community.pictureUrl,
                      title:
                          '${community.firstName ?? ""} ${community.lastName ?? ""}',
                      subtitle: community.gender,
                      onButtonPressed: () {
                        // context.push(Routes.COMMUNITYDETAILS, extra: community);
                      },
                    ),
                    if (index != filteredList.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: const Divider(
                          height: 0.5,
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text("No referrals found")),
    );
  }
}
