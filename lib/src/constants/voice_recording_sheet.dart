import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/constants.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../utils/custom_header.dart';

class VoiceRecordingSheet extends StatefulWidget {
  final Function(String) onResult;
  final String type;

  const VoiceRecordingSheet(
      {Key? key, required this.onResult, required this.type})
      : super(key: key);

  @override
  State<VoiceRecordingSheet> createState() => _VoiceRecordingSheetState();
}

class _VoiceRecordingSheetState extends State<VoiceRecordingSheet> {
  final SpeechToText speechToText = SpeechToText();
  String spokenWords = '';
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  void startListening() async {
    bool available = await speechToText.initialize(
      onStatus: (status) {
        if (status == 'done') {
          stopListening();
        }
      },
      onError: (error) => debugPrint('Speech error: $error'),
    );

    if (available) {
      if (!mounted) return;
      setState(() => isListening = true);
      speechToText.listen(
        onResult: (result) {
          if (!mounted) return;
          setState(() {
            spokenWords = result.recognizedWords;
          });
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
        ),
      );
    }
  }

  void stopListening() async {
    await speechToText.stop();
    if (!mounted) return;
    setState(() => isListening = false);
    widget.onResult(spokenWords);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row with Back Button and Centered Title
          CustomHeader(
            title: widget.type,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 40),

          // Mic icon
          Image.asset('assets/icon/speak.png', width: 180, height: 180),

          mediumSpace(),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Don’t know which type of ${widget.type} you need, tap the audio button and explain what your needs are.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff202325)),
            ),
          ),

          const SizedBox(height: 24),

          // Speech output
          Text(
            spokenWords.isEmpty ? "Start speaking..." : spokenWords,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Stop button
          ElevatedButton.icon(
            onPressed: stopListening,
            icon: const Icon(
              Icons.stop,
              color: Colors.red,
            ),
            label: const Text(
              "Stop",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
