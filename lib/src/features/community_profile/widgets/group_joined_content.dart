import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class GroupJoinedContent extends StatelessWidget {
  const GroupJoinedContent({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      {
        'name': 'Fitness & Wellness',
        'image':
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&q=80&w=100'
      },
      {
        'name': 'Fitness & Wellness',
        'image':
            'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=100'
      },
      {
        'name': 'Health Benefit of',
        'image':
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&q=80&w=100'
      },
      {
        'name': 'Fitness & Wellness',
        'image':
            'https://images.unsplash.com/photo-1584362917165-526a968579e8?auto=format&fit=crop&q=80&w=100'
      },
      {
        'name': 'Fitness & Wellness',
        'image':
            'https://images.unsplash.com/photo-1610967510782-6a3764bbef99?auto=format&fit=crop&q=80&w=100'
      },
      {
        'name': 'Fitness & Wellness',
        'image':
            'https://images.unsplash.com/photo-1581530240506-64634f0a95d9?auto=format&fit=crop&q=80&w=100'
      },
      {
        'name': 'Fitness & Wellness',
        'image':
            'https://images.unsplash.com/photo-1551076805-e1869033e561?auto=format&fit=crop&q=80&w=100'
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Group Joined',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333)),
          ),
          12.height,
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              8.width,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          12.height,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Group Size'),
                8.width,
                _buildFilterChip('Number of Post'),
                8.width,
                _buildFilterChip('Ratings', showClose: false),
              ],
            ),
          ),
          16.height,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groups.length,
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final group = groups[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        group['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                            width: 50, height: 50, color: Colors.grey.shade200),
                      ),
                    ),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF333333),
                          ),
                        ),
                        4.height,
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            4.width,
                            Text(
                              '130+ new post',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool showClose = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFD4F3B3), // Light green
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1B8721)), // Dark green border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showClose) ...[
            const SizedBox(width: 4),
            const Icon(Icons.close, size: 14, color: Colors.black54),
          ],
        ],
      ),
    );
  }
}
