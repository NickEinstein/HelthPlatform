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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupId'] = this.groupId;
    data['groupName'] = this.groupName;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    return data;
  }
}
