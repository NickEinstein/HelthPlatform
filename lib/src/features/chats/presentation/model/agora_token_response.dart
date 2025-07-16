class AgoraTokenResponse {
  final String token;
  final String appId;
  final String channelName;
  final int uid;

  AgoraTokenResponse({
    required this.token,
    required this.appId,
    required this.channelName,
    required this.uid,
  });

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) {
    return AgoraTokenResponse(
      token: json['token'],
      appId: json['appId'],
      channelName: json['channelName'],
      uid: json['uid'],
    );
  }
}
