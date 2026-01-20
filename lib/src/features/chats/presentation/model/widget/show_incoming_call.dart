import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../provider/all_providers.dart';
import 'agora_call_screen.dart';

void showIncomingCallDialog(
  WidgetRef ref,
  BuildContext context,
  String channelName,
  String callerName,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text('Incoming Call'),
      content: Text('$callerName is calling you...'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Reject'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await acceptCall(context, ref, channelName);
          },
          child: const Text('Answer'),
        ),
      ],
    ),
  );
}

Future<void> acceptCall(
    BuildContext context, WidgetRef ref, String channelName) async {
  final uid = Random().nextInt(4294967295);
  final tokenResponse =
      await ref.read(allServiceProvider).getAgoraToken(uid, channelName);

  if (tokenResponse == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to join call")),
      );
    }
    return;
  }

  if (context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AgoraCallScreen(
          token: tokenResponse.token,
          channelName: tokenResponse.channelName,
          uid: tokenResponse.uid,
          appId: tokenResponse.appId,
        ),
      ),
    );
  }
}
