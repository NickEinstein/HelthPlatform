import 'package:flutter/services.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

import '../../../../model/community_list_response.dart';
import '../../../../utils/share_button.dart';

Widget buildCommunityAvatars(
  List<CommunityGroupMembers> members,
  CommunityListResponse community,
  BuildContext context,
  bool isShowMore,
) {
  return SizedBox(
    height: 50,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: (members.length + (isShowMore ? 1 : 0)) * 30.0 +
            20, // adjust padding
        child: Stack(
          children: [
            ...List.generate(members.length, (index) {
              final member = members[index];
              final profileUrl = member.patient?.pictureUrl ?? '';
              final memberId = member.patient?.id;

              return Positioned(
                left: index * 30.0,
                child: GestureDetector(
                  onTap: () {
                    if (isShowMore && memberId != null) {
                      context.push(
                        Routes.COMMUNITYFRIENDSDETAILS,
                        extra: {
                          'community': community,
                          'id': memberId,
                        },
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          profileUrl.startsWith('http')
                              ? profileUrl
                              : '${AppConstants.noSlashImageURL}$profileUrl',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            final initials = (member
                                            .patient?.firstName?.isNotEmpty ==
                                        true &&
                                    member.patient?.lastName?.isNotEmpty ==
                                        true)
                                ? '${member.patient!.firstName![0]}${member.patient!.lastName![0]}'
                                : '?';

                            final nameForColor =
                                (member.patient?.firstName ?? '') +
                                    (member.patient?.lastName ?? '');

                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: getAvatarColor(nameForColor),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                initials.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            if (isShowMore && members.isNotEmpty)
              Positioned(
                left: members.length * 30.0,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _showTooltipMenu(
                      context,
                      details.globalPosition,
                      community.name!,
                      community,
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.withOpacity(0.2),
                    child: const Icon(
                      Icons.more_horiz_sharp,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

void _showTooltipMenu(BuildContext context, Offset position, String name,
    CommunityListResponse community) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  await showMenu<String>(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    ),
    color: ColorConstant.secondryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    items: <PopupMenuEntry<String>>[
      // PopupMenuItem<String>(
      //   value: 'reply',
      //   padding: EdgeInsets.zero,
      //   child: _buildMenuItem(Icons.reply, 'Reply'),
      // ),
      // const PopupMenuDivider(),
      PopupMenuItem<String>(
        value: 'copy',
        padding: EdgeInsets.zero,
        child: _buildMenuItem(Icons.copy, 'Copy'),
      ),
      const PopupMenuDivider(),
      PopupMenuItem<String>(
        value: 'share',
        padding: EdgeInsets.zero,
        child: _buildMenuItem(Icons.share, 'Share'),
      ),
      // const PopupMenuDivider(),
      // PopupMenuItem<String>(
      //   value: 'reaction',
      //   padding: EdgeInsets.zero,
      //   child: _buildMenuItem(Icons.emoji_emotions, 'Add Reaction'),
      // ),
    ],
    elevation: 8,
  ).then((value) {
    if (value != null) {
      // if (value == 'reply') {
      //   // TODO: Handle reply
      // } else
      if (value == 'share') {
        // TODO: Handle share
        _handleShareAction(context, name);
      }
      // else if (value == 'reaction') {
      //   // TODO: Handle reaction
      // }
      else if (value == 'copy') {
        // TODO: Handle copy
        _handleCopyAction(context, community);
      }
    }
  });
}

// Helper widget
Widget _buildMenuItem(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

// Handle Copy Action
void _handleCopyAction(BuildContext context, CommunityListResponse community) {
  Clipboard.setData(ClipboardData(
      text:
          "I'm inviting you to join ${community.name} group on Connected Health App\n Join our amazing community today. 🌟 here https:edogoveerp.com"));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Copied to clipboard!'),
      backgroundColor: Colors.black,
    ),
  );
}

void _handleShareAction(BuildContext context, String name) {
  shareContent(
    title: "I'm inviting you to join $name group on Connected Health App",
    message: "Join our amazing community today. 🌟",
  );
}
