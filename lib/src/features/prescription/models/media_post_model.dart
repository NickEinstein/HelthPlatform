class PostMediaResponse {
  int? id;
  int? groupId;
  String? groupName;
  String? mediaUrl;
  String? mediaType;

  PostMediaResponse(
      {this.id, this.groupId, this.groupName, this.mediaUrl, this.mediaType});

  PostMediaResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['mediaUrl'] = mediaUrl;
    data['mediaType'] = mediaType;
    return data;
  }
}
