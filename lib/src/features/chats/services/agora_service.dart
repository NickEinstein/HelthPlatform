// import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// class AgoraService {
//   static const String appId = "YOUR_AGORA_APP_ID";
//   static const String? token = null;
//   static const String channelName = "test";

//   static late RtcEngine _engine;

//   static Future<void> initAgora() async {
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(RtcEngineContext(appId: appId));

//     await _engine.enableVideo();
//     await _engine.startPreview();

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (connection, elapsed) {
//           print('Joined channel: ${connection.channelId}');
//         },
//         onUserJoined: (connection, remoteUid, elapsed) {
//           print('Remote user joined: $remoteUid');
//         },
//       ),
//     );
//   }

//   static Future<void> joinChannel(String channelName) async {
//     await _engine.joinChannel(
//       token: token!,
//       channelId: channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   static Future<void> leaveChannel() async {
//     await _engine.leaveChannel();
//   }

//   static void dispose() {
//     _engine.release();
//   }
// }
