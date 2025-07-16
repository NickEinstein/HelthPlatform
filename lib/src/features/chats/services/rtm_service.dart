// import 'package:agora_rtm/agora_rtm.dart';

// class RtmService {
//   static const String appId = "YOUR_AGORA_APP_ID";
//   static late AgoraRtmClient _client;
//   static late AgoraRtmChannel _channel;

//   static Future<void> init(String userId) async {
//     _client = await AgoraRtmClient.createInstance(appId);
//     _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
//       print('Message from $peerId: ${message.text}');
//       // Handle incoming call invites or responses here
//     };

//     await _client.login(null, userId);
//   }

//   static Future<void> sendInvite(String peerId) async {
//     final message = AgoraRtmMessage.fromText("CALL_INVITE");
//     await _client.sendMessageToPeer(peerId, message, false);
//   }

//   static Future<void> logout() async {
//     await _client.logout();
//   }

//   static void dispose() {
//     _client.release();
//   }
// }
