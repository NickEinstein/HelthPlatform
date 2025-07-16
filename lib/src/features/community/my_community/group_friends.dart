// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../../chats/presentation/model/chatcontact_model.dart';
import '../presentation/widget/search_card.dart';

class GroupFriends extends ConsumerStatefulWidget {
  const GroupFriends({super.key});

  @override
  ConsumerState<GroupFriends> createState() => _GroupFriendsState();
}

class _GroupFriendsState extends ConsumerState<GroupFriends> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final friendsListAsync = ref.watch(userAllFriendsSenderProvider);

    return friendsListAsync.when(
      data: (friends) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final allFrnds = friends[index];
            String? pictureUrl = allFrnds.friendPatient?.pictureUrl;

            // Check if pictureUrl is null and provide a default value
            String imageUrl = pictureUrl ?? 'assets/images/default_image.png';

            return SearchCard(
              imageUrl: imageUrl, // Use the fallback imageUrl
              title:
                  '${allFrnds.friendPatient!.firstName ?? ''} ${allFrnds.friendPatient!.lastName ?? ''}',
              subtitle: '${allFrnds.friendPatient!.gender ?? ''} ',
              onButtonPressed: () async {
                final chat = ChatContact(
                  id: allFrnds.friendPatient!.id!,
                  firstName: allFrnds.friendPatient!.firstName ?? '',
                  lastName: allFrnds.friendPatient!.lastName ?? '',
                  email: '',
                  pictureUrl: allFrnds.friendPatient!.pictureUrl ?? '',
                  unreadCount: 0,
                  lastMessage: "",
                  userType: 1,
                  lastMessageDate: DateTime.now(),
                );

                await context.push(Routes.CHATDETAILS, extra: chat);

                // context.push(Routes.COMMUNITYDETAILS, extra: community);
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text("No Friends found")),
    );
  }
}
