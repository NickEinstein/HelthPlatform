import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class ConversationsContent extends StatelessWidget {
  const ConversationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      {
        'name': 'Angel Harding',
        'image': 'https://i.pravatar.cc/150?img=33',
        'time': 'Friday 2:20pm',
        'message':
            'Hello!\n\nThank you for allowing to join this group! As we all know mental health is very important and I want to provide any advice that I have. I have been on this industry for many years and if you need a medical biller or credentials, I can help.\n\nLet work together to combat this major issue in 2025!',
      },
      {
        'name': 'Brennen Fernandez',
        'image': 'https://i.pravatar.cc/150?img=13',
        'time': 'Friday 2:20pm',
        'message':
            'Dancing is a great way to reduce mental stress because it combines physical movement...',
        'postImage':
            'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?q=80&w=2669&auto=format&fit=crop',
        'isVideo': true,
      },
      {
        'name': 'Karma Sykes',
        'image': 'https://i.pravatar.cc/150?img=53',
        'time': 'Friday 2:20pm',
        'message':
            'Hello!\n\nThank you for allowing to join this group! As we all know mental health is very important and I want to provide any advice that I have. I have been on this industry for many years and if you need a medical biller or credentials, I can help.',
      },
      {
        'name': 'Medical Tips',
        'image': 'https://i.pravatar.cc/150?img=60',
        'time': 'Friday 2:20pm',
        'postImage':
            'https://images.unsplash.com/photo-1589578228447-e1a4e481c6c8?q=80&w=2626&auto=format&fit=crop',
        'message': '',
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: conversations.length,
      separatorBuilder: (context, index) => 24.height,
      itemBuilder: (context, index) {
        final conv = conversations[index];
        return _buildConversationItem(
          name: conv['name'] as String,
          image: conv['image'] as String,
          time: conv['time'] as String,
          message: conv['message'] as String,
          postImage: conv['postImage'] as String?,
          isVideo: conv['isVideo'] as bool? ?? false,
        );
      },
    );
  }

  Widget _buildConversationItem({
    required String name,
    required String image,
    required String time,
    required String message,
    String? postImage,
    bool isVideo = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(image),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 10),
                      ),
                    ],
                  ),
                  if (message.isNotEmpty && postImage == null) ...[
                    8.height,
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        message,
                        style: const TextStyle(color: Color(0xFF333333)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        if (postImage != null) ...[
          12.height,
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  postImage,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(height: 300, color: Colors.grey.shade200),
                ),
              ),
              if (isVideo)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow,
                      color: Color(0xFF333333), size: 32),
                ),
              if (message.isNotEmpty)
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.reply, color: Colors.grey, size: 20),
                4.width,
                Text('Reply',
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 20),
                4.width,
                const Text('2', style: TextStyle(color: Colors.grey)),
                12.width,
                Icon(Icons.sentiment_satisfied_alt,
                    color: Colors.grey.shade600, size: 20),
                12.width,
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1B8721),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.more_horiz,
                      color: Colors.white, size: 16),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
