import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class MyFriendsContent extends StatelessWidget {
  const MyFriendsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final friends = [
      {
        'name': 'Goodness Chibueze',
        'image': 'https://i.pravatar.cc/150?img=11'
      },
      {'name': 'Williams Fatayo', 'image': 'https://i.pravatar.cc/150?img=12'},
      {'name': 'Oghenemaro Julius', 'image': 'https://i.pravatar.cc/150?img=5'},
      {'name': 'Abimbola Oretayo', 'image': 'https://i.pravatar.cc/150?img=9'},
      {'name': 'Gloria Onileola', 'image': 'https://i.pravatar.cc/150?img=1'},
      {'name': 'Adekoya Adenireti', 'image': 'https://i.pravatar.cc/150?img=8'},
      {'name': 'Favour Buhari', 'image': 'https://i.pravatar.cc/150?img=3'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Friends (Followers)',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333)),
          ),
          12.height,
          TextField(
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
          16.height,
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final friend = friends[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          friend['name'] == 'Goodness Chibueze'
                              ? 'https://randomuser.me/api/portraits/men/1.jpg' // Placeholder for blue shirt guy
                              : friend['image']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person,
                                  size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          friend['name']!,
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
}
