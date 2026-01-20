import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class MyPageContent extends StatelessWidget {
  const MyPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About Me'),
          8.height,
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus, nulla a accumsan at morbi bibendum tortor id a. Nullam amet, ultricies orci ultrices odio condimentum, Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
          24.height,
          _buildSectionTitle('Health Goals'),
          8.height,
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus, nulla a accumsan at morbi bibendum tortor id a. Nullam amet, ultricies orci ultrices odio condimentum...',
            style: TextStyle(color: Colors.black54, height: 1.5),
          ),
          24.height,
          _buildSectionTitle('What makes me better when I feel unwell'),
          8.height,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip('Music'),
              _buildChip('Meditation'),
              _buildChip('Friends'),
              _buildChip('Prayers'),
              _buildChip('Motivationals'),
              _buildChip('Food'),
              _buildChip('Shopping'),
            ],
          ),
          24.height,
          _buildSectionTitle('Interests'),
          8.height,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip('Music'),
              _buildChip('Meditation'),
              _buildChip('Friends'),
              _buildChip('Prayers'),
              _buildChip('Motivationals'),
              _buildChip('Food'),
              _buildChip('Shopping'),
            ],
          ),
          40.height,
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
        ),
      ),
    );
  }
}
