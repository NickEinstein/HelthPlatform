import 'dart:async';
import 'dart:math';

import 'package:greenzone_medical/src/features/chats/presentation/model/chatcontact_model.dart';
import 'package:intl/intl.dart';

import '../../../../../provider/all_providers.dart';
import '../../../../../utils/packages.dart';
import '../conversation_mode.dart';
import 'agora_call_screen.dart';
import 'full_image_preview.dart';

// --- Assuming these are your imports for providers, models, and constants ---

// Mock `getAvatarColor` and `Routes` for demonstration if they are not provided

class ChatDetailScreen extends ConsumerStatefulWidget {
  final ChatContact chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  // ignore: library_private_types_in_public_api
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  Timer? _pollingTimer;
  String? callerId;
  String? callerName;

  File? _selectedImage;
  int currentPage = 1;
  bool isFetchingMore = false;
  // Initialize allMessages as an empty list or let it be populated by the provider
  // It will be updated by the polling logic.
  List<ConversationResponse> allMessages = [];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isFetchingMore) {
          _fetchMoreMessages();
        }
      }
    });

    // Start polling for new messages every 5 seconds
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _fetchLatestMessages(),
    );
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> takePhotoWithCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _fetchMoreMessages() async {
    // Prevent fetching if already fetching or if there are no initial messages to paginate from.
    // This helps avoid fetching page 2 before page 1 is loaded.
    if (isFetchingMore || allMessages.isEmpty) return;

    setState(() {
      isFetchingMore = true;
    });

    final nextPage = currentPage + 1;

    final response = await ref
        .read(allServiceProvider)
        .fetchChatConversationList(widget.chat.id.toString(),
            widget.chat.userType.toString(), nextPage, 20);

    if (response.isNotEmpty) {
      setState(() {
        allMessages.addAll(response);
        currentPage = nextPage;
      });
    }
    setState(() {
      isFetchingMore = false;
    });
  }

  Future<void> _fetchLatestMessages() async {
    // If we're already fetching more messages, don't conflict with polling.
    if (isFetchingMore) return;

    // Fetch the first page to get the most recent messages
    final response =
        await ref.read(allServiceProvider).fetchChatConversationList(
              widget.chat.id.toString(),
              widget.chat.userType.toString(),
              1, // Always fetch page 1 for the latest
              20, // Keep fetching a reasonable size to catch recent ones
            );

    if (response.isNotEmpty) {
      // Create a set of existing message IDs for efficient lookup
      final existingIds = allMessages.map((e) => e.id).toSet();
      // Find new messages that are not already in our current list
      final newMessages =
          response.where((msg) => !existingIds.contains(msg.id)).toList();

      if (newMessages.isNotEmpty) {
        setState(() {
          // Add new messages to the END of the list,
          // as the ListView is not reversed and new messages are at the bottom.
          allMessages.addAll(newMessages);
          // Sort `allMessages` by `sentAt` if the API doesn't guarantee order
          // This is crucial if your API doesn't return page 1 sorted by sentAt ascending
          allMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));
        });

        // Optionally, scroll to the bottom to show the newest message
        // Ensure this happens after the build cycle completes to avoid errors.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginDataAsync = ref.watch(loginDataProvider);
    final isLoading = ref.watch(isLoadingProvider);
    // Watch the chatConversationProvider for the initial set of messages
    final conversationAsync = ref.watch(
      chatConversationProvider((
        userIdTwo: widget.chat.id.toString(),
        userTypeTwo: widget.chat.userType.toString(),
        page: 1, // Always load initial page 1
        size: 20 // Initial size
      )),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff059909),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        title: InkWell(
          onTap: () {
            context.push(Routes.CONTACTINFOPAGE, extra: widget.chat.id);
          },
          child: Row(
            children: [
              widget.chat.pictureUrl != null &&
                      widget.chat.pictureUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        widget.chat.pictureUrl!.contains('uploads')
                            ? '${AppConstants.imageURL}${widget.chat.pictureUrl!}'
                            : widget.chat.pictureUrl!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: getAvatarColor(
                                widget.chat.firstName + widget.chat.lastName),
                            child: Text(
                              '${widget.chat.firstName[0]}${widget.chat.lastName[0]}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    )
                  : CircleAvatar(
                      radius: 20,
                      backgroundColor: getAvatarColor(
                          widget.chat.firstName + widget.chat.lastName),
                      child: Text(
                        '${widget.chat.firstName[0]}${widget.chat.lastName[0]}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.chat.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  const Text("tap here for contact info",
                      style: TextStyle(fontSize: 14, color: Color(0xffB4F0B6))),
                ],
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final uid = Random().nextInt(4294967295);
              final channelName = '$callerName';

              final tokenResponse = await ref
                  .read(allServiceProvider)
                  .getAgoraToken(uid, channelName);
              if (tokenResponse == null) {
                return;
              }

              await ref.read(allServiceProvider).sendCallNotification(
                    callerId: callerId.toString(),
                    callerName: callerName.toString(),
                    receiverId: widget.chat.id.toString(),
                    channelName: channelName,
                  );

              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AgoraCallScreen(
                    token: tokenResponse.token,
                    channelName: tokenResponse.channelName,
                    uid: tokenResponse.uid,
                    appId: tokenResponse.appId,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () async {
              final uid = Random().nextInt(4294967295);
              final channelName = '$callerName';

              final tokenResponse = await ref
                  .read(allServiceProvider)
                  .getAgoraToken(uid, channelName);
              if (tokenResponse == null) {
                return;
              }

              await ref.read(allServiceProvider).sendCallNotification(
                    callerId: callerId.toString(),
                    callerName: callerName.toString(),
                    receiverId: widget.chat.id.toString(),
                    channelName: channelName,
                  );

              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AgoraCallScreen(
                    token: tokenResponse.token,
                    channelName: tokenResponse.channelName,
                    uid: tokenResponse.uid,
                    appId: tokenResponse.appId,
                  ),
                ),
              );
            },
            child: const Icon(Icons.videocam, color: Colors.white),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: loginDataAsync.when(
        data: (loginData) {
          if (loginData == null) {
            return const Center(child: Text("No login data available"));
          }

          final decodedData = jsonDecode(loginData);
          final userId = decodedData["userID"];
          callerId = userId.toString();
          callerName = decodedData['name'];

          return conversationAsync.when(
            data: (initialMessages) {
              // ONLY update allMessages if it's the very first load or if the initialMessages
              // from the provider are different from what we currently have.
              // This prevents resetting `allMessages` every rebuild if we've already added new ones via polling.
              if (allMessages.isEmpty && initialMessages.isNotEmpty) {
                // Ensure initial messages are sorted if your API doesn't guarantee it for page 1
                initialMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));
                allMessages = List.from(initialMessages);
                // Scroll to bottom after initial messages are loaded and rendered
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });
              } else if (initialMessages.isNotEmpty && allMessages.isNotEmpty) {
                // This block handles cases where the provider updates due to `invalidate`
                // and we need to merge new data.
                final existingIds = allMessages.map((e) => e.id).toSet();
                final newMessagesFromProvider = initialMessages
                    .where((msg) => !existingIds.contains(msg.id))
                    .toList();

                if (newMessagesFromProvider.isNotEmpty) {
                  setState(() {
                    allMessages.addAll(newMessagesFromProvider);
                    allMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));
                  });
                }
              }

              // if (allMessages.isEmpty) {
              //   return const Center(child: Text("Start a conversation!"));
              // }

              final groupedMessages = <String, List<ConversationResponse>>{};
              for (final msg in allMessages) {
                final dateKey = DateFormat('EE, MMM d').format(msg.sentAt);
                groupedMessages.putIfAbsent(dateKey, () => []).add(msg);
              }

              final dateKeys = groupedMessages.keys.toList();

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse:
                          false, // Keep it as is: oldest at top, newest at bottom
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: groupedMessages.length,
                      itemBuilder: (context, index) {
                        final dateKey = dateKeys[index];
                        final msgs = groupedMessages[dateKey]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xffDDDDE9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  dateKey,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff3C3C43),
                                  ),
                                ),
                              ),
                            ),
                            ...msgs.asMap().entries.map((entry) {
                              final i = entry.key;
                              final msg = entry.value;
                              final isSentByMe = msg.senderId == userId;

                              bool isNewSender = i == 0 ||
                                  msgs[i - 1].senderId != msg.senderId;

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: isNewSender ? 12 : 4,
                                  bottom: 4,
                                ),
                                child: Align(
                                  alignment: isSentByMe
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(8),
                                    shadowColor:
                                        Colors.black.withValues(alpha: 0.25),
                                    color: isSentByMe
                                        ? const Color(0xffDCF7C5)
                                        : const Color(0xffFAFAFA),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (msg.imageUrl != null)
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        FullImageView(
                                                      imageUrl:
                                                          '${AppConstants.imageURL}${msg.imageUrl!}',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Image.network(
                                                '${AppConstants.imageURL}${msg.imageUrl!}',
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    height: 100,
                                                    width: 100,
                                                    color: Colors.grey[200],
                                                    child: const Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 40,
                                                        color: Colors.grey),
                                                  );
                                                },
                                              ),
                                            ),
                                          if (msg.text != null)
                                            Text(
                                              msg.text ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          const SizedBox(height: 4),
                                          Text(
                                            DateFormat('h:mm a').format(
                                                msg.sentAt), // e.g., 8:49 AM
                                            style:
                                                const TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        );
                      },
                    ),
                  ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_selectedImage != null)
                          Stack(
                            children: [
                              Image.file(
                                _selectedImage!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImage = null;
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add, color: Colors.grey),
                                onPressed: pickImageFromGallery,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    hintText: "Type a message",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.camera_alt),
                                onPressed: takePhotoWithCamera,
                              ),
                              IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () async {
                                  final text = _controller.text.trim();

                                  if (_selectedImage == null && text.isEmpty) {
                                    return;
                                  }

                                  if (_selectedImage == null) {
                                    await sendTextMessage(text);
                                  } else {
                                    await sendImageMessage(
                                        _selectedImage!, text);
                                  }

                                  _controller.clear();
                                  setState(() {
                                    _selectedImage = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                Center(child: Text('Error loading messages: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text("Failed to load data: $error")),
      ),
    );
  }

  Future<void> sendTextMessage(String text) async {
    if (text.isNotEmpty) {
      ref.read(isLoadingProvider.notifier).state = true;
      final allService = ref.read(allServiceProvider);
      final result = await allService.sendChatWithText(
          widget.chat.id, widget.chat.userType, text);

      if (!context.mounted) return;
      ref.read(isLoadingProvider.notifier).state = false;

      if (result == 'successful') {
        // Invalidate the provider to force a fresh fetch,
        // which will then be merged into `allMessages` in the `build` method's `data` block.
        ref.invalidate(
          chatConversationProvider(
            (
              userIdTwo: widget.chat.id.toString(),
              userTypeTwo: widget.chat.userType.toString(),
              page: 1, // Ensure it fetches page 1 for the newest message
              size: 20
            ),
          ),
        );
        // Optional: Scroll to the bottom to see the new message immediately
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      } else {
        if (mounted) {
          CustomToast.show(context, "Failed to send message",
              type: ToastType.error);
        }
      }
    }
  }

  Future<void> sendImageMessage(File image, String? text) async {
    if (image.path.isNotEmpty) {
      ref.read(isLoadingProvider.notifier).state = true;
      final allService = ref.read(allServiceProvider);
      final result = await allService.sendChatWithImage(
          widget.chat.id, widget.chat.userType, text ?? '', image);

      if (!context.mounted) return;
      ref.read(isLoadingProvider.notifier).state = false;

      if (result == 'successful') {
        ref.invalidate(
          chatConversationProvider(
            (
              userIdTwo: widget.chat.id.toString(),
              userTypeTwo: widget.chat.userType.toString(),
              page: 1,
              size: 20
            ),
          ),
        );
        // Optional: Scroll to the bottom to see the new message immediately
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      } else {
        if (mounted) {
          CustomToast.show(context, "Failed to send message",
              type: ToastType.error);
        }
      }
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
