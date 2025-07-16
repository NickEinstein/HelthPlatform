import 'package:greenzone_medical/src/features/chats/services/ChatDateFormatter.dart';

import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(chatPaginationProvider.notifier).fetchInitial();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(chatPaginationProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatAsync = ref.watch(chatPaginationProvider);
    final notifier = ref.watch(chatPaginationProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          verticalSpace(context, 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomHeader(
              title: 'Chats',
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Divider(color: ColorConstant.primaryColor, thickness: 2),
          tinySpace(),
          Expanded(
            child: chatAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => const Center(
                child: Text('Something went wrong,\nPlease try again later...'),
              ),
              data: (contacts) {
                if (contacts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No chats yet',
                      style: TextStyle(
                        color: Color(0xff8E8E93),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }

                final sortedContacts = [...contacts]..sort(
                    (a, b) => b.lastMessageDate.compareTo(a.lastMessageDate));

                return ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: sortedContacts.length + (notifier.hasMore ? 1 : 0),
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    if (index >= sortedContacts.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final chat = sortedContacts[index];

                    return ListTile(
                      leading: Stack(
                        children: [
                          chat.pictureUrl != null && chat.pictureUrl!.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    chat.pictureUrl!.contains('uploads')
                                        ? '${AppConstants.imageURL}${chat.pictureUrl!}'
                                        : chat.pictureUrl!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return CircleAvatar(
                                        radius: 20,
                                        backgroundColor: getAvatarColor(
                                            chat.firstName + chat.lastName),
                                        child: Text(
                                          '${chat.firstName[0]}${chat.lastName[0]}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundColor: getAvatarColor(
                                      chat.firstName + chat.lastName),
                                  child: Text(
                                    '${chat.firstName[0]}${chat.lastName[0]}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        '${chat.firstName} ${chat.lastName}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle:
                          (chat.lastMessage == null || chat.lastMessage.isEmpty)
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 17,
                                      color: Color(0xff8E8E93),
                                    ),
                                    tiny5HorSpace(),
                                    const Text(
                                      'Photo',
                                      style: TextStyle(
                                        color: Color(0xff8E8E93),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  chat.lastMessage,
                                  style: const TextStyle(
                                    color: Color(0xff8E8E93),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            chat.lastMessageDate.toChatFormat(),
                            style: const TextStyle(
                              color: Color(0xff8E8E93),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (chat.unreadCount > 0)
                            Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              child: Text(
                                chat.unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () async {
                        await context.push(Routes.CHATDETAILS, extra: chat);
                        ref
                            .read(chatPaginationProvider.notifier)
                            .fetchInitial();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
