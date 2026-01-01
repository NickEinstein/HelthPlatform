import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/color_constant.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class GeneralChatContent extends StatelessWidget {
  const GeneralChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What's on your mind today ...",
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          8.height,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4), // Light green background
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share your thoughts, ask a question, or post an update...',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
                40.height,
                Row(
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        color: ColorConstant.primaryColor),
                    12.width,
                    Icon(Icons.videocam_outlined,
                        color: ColorConstant.primaryColor),
                    Spacer(),
                    Icon(Icons.attach_file, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          12.height,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B8721), // Strong green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Publish Post',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          24.height,
          _buildPostItem(),
        ],
      ),
    );
  }

  Widget _buildPostItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=32'),
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
                      const Text(
                        'Jessica Humphrey',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Text(
                        'Friday 2:20pm',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 10),
                      ),
                    ],
                  ),
                  8.height,
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'I feel like its Christmas',
                      style: TextStyle(color: Color(0xFF333333)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        12.height,
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://images.unsplash.com/photo-1576919228636-1e0e85bf0c2f?q=80&w=2574&auto=format&fit=crop',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(height: 300, color: Colors.grey.shade200),
          ),
        ),
        12.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.favorite, color: Colors.red, size: 20),
            4.width,
            const Text('2',
                style: TextStyle(color: Colors.grey)), // Hand emoji replacement
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
              child:
                  const Icon(Icons.more_horiz, color: Colors.white, size: 16),
            ),
          ],
        ),
      ],
    );
  }
}
