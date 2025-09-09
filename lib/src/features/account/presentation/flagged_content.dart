import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../utils/custom_header.dart';
import '../../community/post/presentation/group_post_list.dart';
import 'widget/flagged_post.dart';

class FlaggedContentPage extends ConsumerStatefulWidget {
  FlaggedContentPage({
    super.key,
  });

  @override
  ConsumerState<FlaggedContentPage> createState() => _FlaggedContentPageState();
}

class _FlaggedContentPageState extends ConsumerState<FlaggedContentPage> {
  String fullname = '';

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHeader(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: 'Flagged Content',
                    ),
                    userAsync.when(
                      data: (user) {
                        final imageUrl = user.pictureUrl!.contains('https')
                            ? user.pictureUrl!
                            : user.pictureUrl!.contains('/UploadedFiles')
                                ? '${AppConstants.noSlashImageURL}${user.pictureUrl!}'
                                : '${AppConstants.noSlashImageURL}/${user.pictureUrl!}';
                        final initials =
                            '${user.firstName![0]}${user.lastName![0]}';
                        fullname = user.firstName!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: Image.network(
                                imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => CircleAvatar(
                                  radius: 20,
                                  backgroundColor: getAvatarColor(
                                      user.firstName! + user.lastName!),
                                  child: Text(initials,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => const Text('User info unavailable',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
                tinySpace(),
                FlaggedPostList(
                  fullName: fullname,
                ),
                smallSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
