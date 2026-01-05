import '../../../model/community_list_response.dart';
import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import 'widget/search_card.dart';

class FriendWithSearchPage extends ConsumerStatefulWidget {
  final CommunityListResponse community;
  const FriendWithSearchPage({super.key, required this.community});

  @override
  ConsumerState<FriendWithSearchPage> createState() =>
      _FriendWithSearchPageState();
}

class _FriendWithSearchPageState extends ConsumerState<FriendWithSearchPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final friendsListAsync = ref.watch(userAllFriendsSenderProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Reduced or removed extra space
            verticalSpace(context, 0.08),

            CustomHeader(
              title: 'Friends',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            tinySpace(),

            // 🔍 Search Bar
            Row(
              children: [
                const SizedBox(width: 10),

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
                              hintText: "Search friends by name",
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
                // Image.asset(
                //   'assets/icon/filter_icon.png',
                //   height: 52,
                //   width: 35,
                // ),
              ],
            ),

            // 🏋️ Community List
            smallSpace(),
            Expanded(
              child: friendsListAsync.when(
                data: (communityList) {
                  final filteredList = communityList
                      .where((community) =>
                          community.friendPatient!.firstName!
                              .toLowerCase()
                              .contains(searchQuery) ||
                          community.friendPatient!.lastName!
                              .toLowerCase()
                              .contains(searchQuery))
                      .toList();

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text("No friend found"),
                    );
                  }

                  return ListView.builder(
                    padding:
                        EdgeInsets.zero, // 🔹 Removes extra padding at the top
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final allcommunity = filteredList[index];
                      final friendPatient = allcommunity.friendPatient;

                      if (friendPatient == null) {
                        return const SizedBox
                            .shrink(); // or show a fallback widget
                      }

                      return SearchCard(
                        imageUrl: friendPatient.pictureUrl ?? '',
                        title:
                            '${friendPatient.firstName ?? ''} ${friendPatient.lastName ?? ''}',
                        subtitle: friendPatient.gender ?? '',
                        onButtonPressed: () {
                          context.push(
                            Routes.COMMUNITYFRIENDSDETAILS,
                            extra: {
                              'community': widget.community,
                              'id': friendPatient.id,
                            },
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    const Center(child: Text("No friend record found")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
