import 'package:flutter/material.dart';

class MediaTabContent extends StatelessWidget {
  const MediaTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      // Use standard grid delegate
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(
                'https://picsum.photos/200?random=$index',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
