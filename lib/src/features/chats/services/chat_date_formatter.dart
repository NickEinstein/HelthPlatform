import 'package:intl/intl.dart';

extension ChatDateFormatter on DateTime {
  String toChatFormat() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);

    final difference = today.difference(date).inDays;

    if (difference == 0) {
      // Today → Show time (e.g., 11:00 AM)
      return DateFormat.jm().format(this);
    } else if (difference == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (difference < 7) {
      // Within this week → Weekday name
      return DateFormat.EEEE().format(this); // e.g., Wednesday
    } else {
      // Older → MM/dd/yy
      return DateFormat('M/d/yy').format(this); // e.g., 5/29/25
    }
  }
}
