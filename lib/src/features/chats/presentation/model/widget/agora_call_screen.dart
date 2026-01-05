import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class AgoraCallScreen extends StatefulWidget {
  final String token;
  final String channelName;
  final int uid;
  final String appId;

  const AgoraCallScreen({
    required this.token,
    required this.channelName,
    required this.uid,
    required this.appId,
    super.key,
  });

  @override
  State<AgoraCallScreen> createState() => _AgoraCallScreenState();
}

class _AgoraCallScreenState extends State<AgoraCallScreen> {
  late RtcEngine _engine;
  bool isJoined = false;
  bool isMuted = false;
  bool isSpeakerEnabled = true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: widget.appId));

    _engine.registerEventHandler(
      RtcEngineEventHandler(onJoinChannelSuccess: (connection, elapsed) async {
        debugPrint("Joined channel successfully");
        setState(() => isJoined = true);
        await _engine.setEnableSpeakerphone(true); // Moved here
      }, onUserJoined: (connection, remoteUid, elapsed) {
        debugPrint('User joined: $remoteUid');
      }, onUserOffline: (connection, remoteUid, reason) {
        debugPrint('User offline: $remoteUid');
      }, onError: (code, msg) {
        debugPrint('Agora error $code: $msg');
      }),
    );

    await _engine.enableAudio();

    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channelName,
      uid: widget.uid,
      options: const ChannelMediaOptions(),
    );
  }

  void _toggleMute() {
    setState(() => isMuted = !isMuted);
    _engine.muteLocalAudioStream(isMuted);
  }

  void _toggleSpeaker() {
    setState(() => isSpeakerEnabled = !isSpeakerEnabled);
    _engine.setEnableSpeakerphone(isSpeakerEnabled);
  }

  void _endCall() {
    _engine.leaveChannel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              isJoined ? "In Call..." : "Joining...",
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _toggleMute,
                  icon: Icon(
                    isMuted ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                FloatingActionButton(
                  onPressed: _endCall,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
                IconButton(
                  onPressed: _toggleSpeaker,
                  icon: Icon(
                    isSpeakerEnabled ? Icons.volume_up : Icons.hearing,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
