// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../../../constants/helper.dart';

// const String appId = "f0f8b95720d245f0bb483dac1d70c7b7";
// const String channelName = "test_channel";
// const String? token = null;

// class CallScreen extends StatefulWidget {
//   final bool isVideo;

//   const CallScreen({super.key, required this.isVideo});

//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }

// class _CallScreenState extends State<CallScreen> {
//   int? _remoteUid;
//   late RtcEngine _engine;

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   Future<void> initAgora() async {
//     await requestPermissions();

//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(appId: appId));

//     if (widget.isVideo) {
//       await _engine.enableVideo();
//     }

//     _engine.registerEventHandler(RtcEngineEventHandler(
//       onUserJoined: (connection, remoteUid, elapsed) {
//         setState(() => _remoteUid = remoteUid);
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         setState(() => _remoteUid = null);
//       },
//     ));

//     await _engine.joinChannel(
//       token: token ?? "", // if token is null, send empty string
//       channelId: channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   @override
//   void dispose() {
//     _engine.leaveChannel();
//     _engine.release();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.isVideo ? 'Video Call' : 'Voice Call')),
//       body: Center(
//         child: widget.isVideo
//             ? (_remoteUid != null
//                 ? AgoraVideoView(
//                     controller: VideoViewController.remote(
//                     rtcEngine: _engine,
//                     canvas: VideoCanvas(uid: _remoteUid),
//                     connection: RtcConnection(channelId: channelName),
//                   ))
//                 : const Text("Waiting for user..."))
//             : const Text("Voice call in progress..."),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.pop(context),
//         child: const Icon(Icons.call_end),
//       ),
//     );
//   }
// }
