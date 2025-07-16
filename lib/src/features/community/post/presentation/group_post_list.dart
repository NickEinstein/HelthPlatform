import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';
import '../model/all_post_model.dart';
import '../model/post_query_params.dart';

class GroupPostList extends ConsumerStatefulWidget {
  final int groupId;
  final int pageNumber;
  final int pageSize;

  const GroupPostList({
    Key? key,
    required this.groupId,
    required this.pageNumber,
    required this.pageSize,
  }) : super(key: key);

  @override
  ConsumerState<GroupPostList> createState() => _GroupPostListState();
}

class _GroupPostListState extends ConsumerState<GroupPostList> {
  late final PostQueryParams _params;
  final Map<int, TextEditingController> _commentControllers = {};

  @override
  void initState() {
    super.initState();
    _params = PostQueryParams(
      groupId: widget.groupId,
      pageNumber: widget.pageNumber,
      pageSize: widget.pageSize,
    );
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
    final postsAsync = ref.watch(userAllPostProvider(_params));
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
        return ListView.builder(
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
                    ref.refresh(userAllPostProvider(_params));
                  } else {
                    // CustomToast.show(context, result, type: ToastType.error);
                  }
                },
                onRepost: () async {},
                params: _params, // <-- Add this line
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
                      ref.refresh(userAllPostProvider(_params));
                    } else {
                      // CustomToast.show(context, result,
                      //     type: ToastType.error);
                    }

                    print("Send comment for post ${post.id}: $text");
                    _commentControllers[post.id!]!.clear();
                  }
                });
          },
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
  final PostQueryParams params; // <-- Added this param
  final TextEditingController commentController;
  final VoidCallback onSendComment;

  const PostItem({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onRepost,
    required this.isLoading,
    required this.params,
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
    final params = widget.params;
    ref.watch(userAllPostProvider(params));

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
              Text(
                'Comments (${post.comments?.length ?? 0})',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Comments container with background and padding
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: (comments.isNotEmpty)
                    ? Column(
                        children: [
                          ...displayedComments.map((comment) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name and Date row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        comment.commenterFullName ?? 'Unknown',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        formatPostDate(comment.createdAt),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // Comment text
                                  Text(
                                    comment.commentText ?? '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),

                          // Show More / Show Less button if comments > 2
                          if (comments.length > 2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showAllComments = !_showAllComments;
                                    });
                                  },
                                  child: Text(
                                    _showAllComments
                                        ? 'Show less'
                                        : 'Show more',
                                    style: TextStyle(
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    : const Text(
                        'No comments yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
              ),

              tinySpace(),

              // Comment input field
              TextField(
                controller: widget.commentController,
                decoration: InputDecoration(
                  hintText: 'Add comment',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: ColorConstant.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send,
                                color: Colors.white, size: 18),
                            onPressed: widget.onSendComment,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 8),

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
                                ref.refresh(userAllPostProvider(params));
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
