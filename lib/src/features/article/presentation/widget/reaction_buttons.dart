import 'package:flutter/material.dart';

class ReactionButtons extends StatefulWidget {
  const ReactionButtons({super.key});

  @override
  State<ReactionButtons> createState() => _ReactionButtonsState();
}

class _ReactionButtonsState extends State<ReactionButtons> {
  Map<String, int> reactions = {
    '❤️': 0,
    '👌': 2,
    '😶': 0,
  };

  void incrementReaction(String emoji) {
    setState(() {
      reactions[emoji] = (reactions[emoji] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...reactions.entries.map((entry) {
          final emoji = entry.key;
          final count = entry.value;
          return GestureDetector(
            onTap: () => incrementReaction(emoji),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 18)),
                  if (count > 0) ...[
                    const SizedBox(width: 4),
                    Text(count.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
        // Optional: green circle with 3 dots
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.green,
          child: Icon(Icons.more_horiz, size: 16, color: Colors.white),
        ),
      ],
    );
  }
}
