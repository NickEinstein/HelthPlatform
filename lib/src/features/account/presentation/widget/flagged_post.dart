import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';
import '../../../community/post/model/all_post_model.dart';

class FlaggedPostList extends ConsumerStatefulWidget {
  String fullName;

  FlaggedPostList({required this.fullName});
  @override
  ConsumerState<FlaggedPostList> createState() => _FlaggedPostListState();
}

class _FlaggedPostListState extends ConsumerState<FlaggedPostList> {
  // late final PostQueryParams _params;
  final Map<int, TextEditingController> _commentControllers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(userAllFlaggedPostProvider);
    final isLoading = ref.watch(isLoadingProvider);

    return postsAsync.when(
      data: (posts) {
        if (posts.isEmpty) {
          return Column(
            children: [
              mediumSpace(),
              const Center(child: Text('No posts found.')),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Hello ${widget.fullName}, you have ${posts.length} flagged content(s).',
                style: TextStyle(
                    color: Color(0xff615353),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            tinySpace(),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                final post = posts[index];
                _commentControllers.putIfAbsent(
                    post.id!, () => TextEditingController());

                return PostItem(
                    post: post,
                    isLoading: isLoading,
                    onLike: () async {
                      ref.read(isLoadingProvider.notifier).state = true;
                      final allService = ref.read(allServiceProvider);
                      final result = await allService.likePost(post.id!);
                      if (!context.mounted) return;
                      ref.read(isLoadingProvider.notifier).state = false;
                      if (result == 'successful') {
                        // CustomToast.show(context, 'Reaction recorded successfully',
                        //     type: ToastType.success);
                        ref.refresh(userAllFlaggedPostProvider);
                      } else {
                        // CustomToast.show(context, result, type: ToastType.error);
                      }
                    },
                    onRepost: () async {},
                    commentController: _commentControllers[post.id!]!,
                    onSendComment: () async {
                      final text = _commentControllers[post.id!]!.text;
                      if (text.trim().isNotEmpty) {
                        // handle sending logic

                        ref.read(isLoadingProvider.notifier).state = true;
                        final allService = ref.read(allServiceProvider);
                        final result = await allService.addPostToComment(
                            post.id!, text); // ✅ pass ID here

                        if (!context.mounted) return;
                        ref.read(isLoadingProvider.notifier).state = false;

                        if (result == 'successful') {
                          // CustomToast.show(
                          //     context, 'Reaction recorded successfully',
                          //     type: ToastType.success);
                          ref.refresh(userAllFlaggedPostProvider);
                        } else {
                          // CustomToast.show(context, result,
                          //     type: ToastType.error);
                        }

                        print("Send comment for post ${post.id}: $text");
                        _commentControllers[post.id!]!.clear();
                      }
                    });
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Column(
        children: [
          mediumSpace(),
          const Center(child: Text('No posts found.')),
        ],
      ),
    );
  }
}

class PostItem extends ConsumerStatefulWidget {
  final AllPostResponse post;
  final VoidCallback onLike;
  final VoidCallback onRepost;
  final bool isLoading;
  final TextEditingController commentController;
  final VoidCallback onSendComment;

  const PostItem({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onRepost,
    required this.isLoading,
    required this.commentController,
    required this.onSendComment,
  }) : super(key: key);

  @override
  ConsumerState<PostItem> createState() => _PostItemState();
}

class _PostItemState extends ConsumerState<PostItem> {
  String? selectedReaction;
  bool _showAllComments = false; // Add this state

  @override
  Widget build(BuildContext context) {
    ref.watch(userAllFlaggedPostProvider);

    final post = widget.post;
    final comments = post.comments ?? [];
    final displayedComments =
        _showAllComments ? comments : comments.take(2).toList();

    final isLoading = widget.isLoading;
    final Map<String, int> reactionMap = {
      '👍${post.likesCount}': 1,
      '🥰${post.loveCount}': 2,
      '😂${post.laughCount}': 3,
      '😮${post.wowCount}': 4,
      '😢${post.sadCount}': 5,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Top Row: Profile Picture, Name, Time ---
          Row(
            children: [
              Text(
                'Group:',
                style: TextStyle(
                    color: Color(0xff059909),
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
              tiny5HorSpace(),
              Text(
                post.groupName ?? '',
                style: TextStyle(
                    color: Color(0xff383838),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ],
          ),
          tinySpace(),
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        post.pictureUrl!.startsWith('http')
                            ? post.pictureUrl!
                            : '${AppConstants.imageURL}${post.pictureUrl}',
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  post.memberFullName ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff344054),
                  ),
                ),
              ),
              Text(
                formatWeekDate(post.createdAt!),
                style: const TextStyle(color: Color(0xff475467), fontSize: 13),
              ),
            ],
          ),

          // --- Post Content ---
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width(context),
                  color: const Color(0xffF2F4F7),
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                  child: Text(
                    post.content ?? '',
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xff101828)),
                  ),
                ),
                const SizedBox(height: 8),
                if (post.mediaUrl != null && post.mediaUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      post.mediaUrl!.startsWith('http')
                          ? post.mediaUrl!
                          : '${AppConstants.imageURL}${post.mediaUrl}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),
              ],
            ),
          ),
          smallSpace(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show total comment count

              // Bottom row: Like and Reaction buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : GestureDetector(
                          onTap: widget.onLike,
                          child: Row(
                            children: [
                              const Icon(Icons.favorite, color: Colors.red),
                              const SizedBox(width: 4),
                              Text(
                                post.likeCount.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(width: 16),
                  isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : GestureDetector(
                          onTap: () async {
                            final selectedEmoji =
                                await showModalBottomSheet<String>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: reactionMap.keys.map((emoji) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop(emoji);
                                        },
                                        child: Text(
                                          emoji,
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            );

                            if (selectedEmoji != null) {
                              final reactionId = reactionMap[selectedEmoji]!;

                              setState(() {
                                selectedReaction = selectedEmoji;
                              });

                              ref.read(isLoadingProvider.notifier).state = true;
                              final allService = ref.read(allServiceProvider);
                              final result = await allService.reactToPost(
                                  post.id!, reactionId);

                              if (!context.mounted) return;
                              ref.read(isLoadingProvider.notifier).state =
                                  false;

                              if (result == 'successful') {
                                ref.refresh(userAllFlaggedPostProvider);
                              } else {
                                // Handle error or show message
                              }
                            }
                          },
                          child: const Icon(Icons.add_reaction,
                              color: Colors.grey),
                        ),
                  const SizedBox(width: 24),
                ],
              ),
            ],
          ),

          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
