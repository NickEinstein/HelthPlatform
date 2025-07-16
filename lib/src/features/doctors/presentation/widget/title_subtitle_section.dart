import 'package:flutter/material.dart';

class TitleSubtitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSubtitleSection({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xff595959),
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w400)),
        const SizedBox(height: 4), // Tiny space between title and subtitle
        Text(
          subtitle,
          style: TextStyle(
              color: Color(0xff3C3B3B),
              fontSize: 15,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16), // Medium space after each section
      ],
    );
  }
}
