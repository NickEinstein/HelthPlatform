import 'package:flutter/material.dart';

class IncomingCallScreen extends StatelessWidget {
  final String callerId;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const IncomingCallScreen({
    required this.callerId,
    required this.onAccept,
    required this.onDecline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Incoming Call from $callerId"),
      actions: [
        TextButton(onPressed: onDecline, child: Text("Decline")),
        ElevatedButton(onPressed: onAccept, child: Text("Accept")),
      ],
    );
  }
}
