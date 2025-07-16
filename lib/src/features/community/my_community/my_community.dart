// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../utils/packages.dart';
import 'general_group.dart';
import 'group_friends.dart';
import 'groups_joined.dart';
import 'pending_group_invites.dart';
import 'sent_group_invite.dart';

class MyCommunity extends ConsumerStatefulWidget {
  const MyCommunity({super.key});

  @override
  ConsumerState<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends ConsumerState<MyCommunity> {
  String searchQuery = '';
  int _selectedIndex = 0;
  final List<String> tabs = [
    "Groups",
    "Groups Joined",
    "Pending Invites",
    "Sent Invites",
    "Friends",
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
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                fontSize: 15,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Wrapping the entire body with a scroll view
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // Reduced or removed extra space
              verticalSpace(context, 0.08),

              CustomHeader(
                title: 'My Community',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              tinySpace(),

              // 🏋️ Community List
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_selectedIndex == 0) const GeneralGroups(),
                      if (_selectedIndex == 1) const GroupsJoined(),
                      if (_selectedIndex == 2) const PendingGroupInvites(),
                      if (_selectedIndex == 3) const SentGroupInvites(),
                      if (_selectedIndex == 4) const GroupFriends(),
                    ],
                  ),
                ),
              ),

              smallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
