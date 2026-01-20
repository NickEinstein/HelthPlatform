import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';

class CommunityTab extends ConsumerStatefulWidget {
  const CommunityTab({super.key});

  @override
  ConsumerState<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends ConsumerState<CommunityTab> {
  late TextEditingController _searchController;
  List<CommunityListResponse> _filteredCommunities = [];
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void search(List<CommunityListResponse> allCommunities) {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        isSearch = false;
      } else {
        _filteredCommunities = allCommunities
            .where((community) =>
                community.name?.toLowerCase().contains(query) ?? false)
            .toList();
        isSearch = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final communities = ref.watch(communityListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: communities.when(
        data: (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (value) => search(data),
              decoration: InputDecoration(
                hintText: 'Find a Group',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 15,
                ),
              ),
            ),

            12.height,
            ...List.generate(
              isSearch
                  ? _filteredCommunities.length
                  : data.length > 30
                      ? 30
                      : data.length,
              (index) => _buildCommunityCard(
                context,
                community: isSearch ? _filteredCommunities[index] : data[index],
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const ListLoader(
          height: 180,
        ),
      ),
    );
  }
}

Widget _buildCommunityCard(
  BuildContext context, {
  required CommunityListResponse community,
}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10, top: 10),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    community.pictureUrl ?? '',
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {},
                ),
              ),
            ),
            15.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          community.name ?? '',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  2.height,
                  Text(
                    community.communityGroupAdmin?.employee?.firstName ?? '',
                    style: context.textTheme.bodySmall,
                  ),
                  2.height,
                  Text(
                    community.description ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  5.height,
                  Row(
                    children: [
                      Text(
                        community.communityGroupMembers == null
                            ? ''
                            : '${community.communityGroupMembers!.length} members',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      10.width,
                      const Icon(Icons.circle, color: Colors.green, size: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        10.height,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF109615),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0),
              minimumSize: const Size(0, 35),
            ),
            child: const Text('View', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}
