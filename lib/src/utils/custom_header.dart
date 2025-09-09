import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/voice_recording_sheet.dart';

class CustomHeader extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final bool isVoice;
  final VoidCallback? onSearchPressed; // Optional search button callback
  final Function(String)? onVoiceResult; // Add this

  const CustomHeader(
      {Key? key,
      this.title, // Optional title
      required this.onPressed, // Required back button function
      this.onSearchPressed, // Optional search button function
      this.onVoiceResult,
      this.isVoice = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Back button with green background
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryLightColor, // Light green color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.keyboard_arrow_left_rounded,
                      color: Colors.white),
                ),
              ),

              // Optional title (if provided)
              if (title != null) ...[
                const SizedBox(width: 12), // Spacing
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff3C3B3B),
                  ),
                ),
              ],
            ],
          ),

          // Optional search icon (if onSearchPressed is provided)
          Row(
            children: [
              if (onSearchPressed != null)
                GestureDetector(
                  onTap: onSearchPressed,
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 20,
                    height: 20,
                  ),
                ),
              if (isVoice)
                Row(
                  children: [
                    tinyHorSpace(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isDismissible: false,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (ctx) => VoiceRecordingSheet(
                            type: title ?? '',
                            onResult: (text) {
                              if (onVoiceResult != null) {
                                onVoiceResult!(text);
                              }
                              // Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      child: Image.asset('assets/icon/voice.png',
                          width: 35, height: 35),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
