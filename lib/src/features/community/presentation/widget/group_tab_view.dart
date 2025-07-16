import '../../../../model/community_list_response.dart';
import '../../../../utils/packages.dart';
import '../../post/presentation/group_post_list.dart';
import '../../post/presentation/media_list.dart';

class GroupTabView extends StatefulWidget {
  final CommunityListResponse community; // Receive the community object

  const GroupTabView({super.key, required this.community});

  @override
  // ignore: library_private_types_in_public_api
  _GroupTabViewState createState() => _GroupTabViewState();
}

class _GroupTabViewState extends State<GroupTabView> {
  int _selectedIndex = 0;
  final List<String> tabs = [
    "Group Chats",
    "Media",
    // "Files",
    "Members",
    "About Group"
  ];

  Widget _buildTab(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedIndex = tabs.indexOf(label);
        }),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.green : Colors.grey[800],
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width:
                    label.length * 10.0, // Adjust width based on label length
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabs
                  .asMap()
                  .entries
                  .map((entry) =>
                      _buildTab(entry.value, _selectedIndex == entry.key))
                  .toList(),
            ),
          ),
        ),
        // Use a Column for the selected tab content
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Container(
            key: ValueKey<int>(_selectedIndex),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show content based on selected tab
                if (_selectedIndex == 0)
                  GroupPostList(
                    groupId: widget.community.id!,
                    pageNumber: 1,
                    pageSize: 98,
                  ),

                if (_selectedIndex == 1)
                  MediaGallery(
                    groupId: widget.community.id!,
                  ),
                if (_selectedIndex == 2)
                  // Members content
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // Optional, prevents nested scroll
                    padding: EdgeInsets.zero, // Remove default padding
                    itemCount: widget.community.communityGroupMembers!.length,
                    itemBuilder: (context, index) {
                      final member =
                          widget.community.communityGroupMembers![index];
                      return ListTile(
                        dense: true, // More compact vertically
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0), // Adjust spacing
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            (member.patient?.pictureUrl ?? '')
                                    .startsWith('http')
                                ? member.patient!.pictureUrl!
                                : '${AppConstants.noSlashImageURL}${member.patient?.pictureUrl ?? ''}',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              final firstName = member.patient?.firstName ?? '';
                              final lastName = member.patient?.lastName ?? '';
                              final initials =
                                  (firstName.isNotEmpty ? firstName[0] : '') +
                                      (lastName.isNotEmpty ? lastName[0] : '');

                              return Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: getAvatarColor(firstName + lastName),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  initials,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        16, // Adjusted from 24 to better fit the avatar
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          '${member.patient!.firstName ?? ''} ${member.patient!.lastName ?? ''}',
                          style: const TextStyle(
                              fontSize: 14), // Optional: smaller text
                        ),
                        subtitle: Text(
                          timeAgo(member.joinAt, 'Join'),
                          style: const TextStyle(
                              fontSize: 12), // Optional: smaller text
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 14), // Optional: smaller icon
                        onTap: () {
                          // handle tap
                          context.push(
                            Routes.COMMUNITYFRIENDSDETAILS,
                            extra: {
                              'community': widget.community,
                              'id': member.patient!.id!,
                            },
                          );
                        },
                      );
                    },
                  ),

                if (_selectedIndex == 3)
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About",
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        tiny5Space(),
                        Text(
                          widget.community.description ??
                              "No description available",
                          style: const TextStyle(
                              color: Color(0xff595959),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        mediumSpace(),
                        const Text(
                          "Group Activity",
                          style: TextStyle(
                              color: Color(0xff3C3B3B),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        tiny5Space(),
                        Text(
                          timeAgo(widget.community.createdAt, 'Created'),
                          style: const TextStyle(
                              color: Color(0xff595959),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
