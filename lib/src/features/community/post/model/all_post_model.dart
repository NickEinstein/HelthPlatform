class AllPostResponse {
  int? id;
  String? content;
  int? groupId;
  String? groupName;
  String? memberFullName;
  String? mediaUrl;
  String? mediaType;
  String? pictureUrl;
  String? createdAt;
  int? likeCount;
  int? repostCount;
  int? likesCount;
  int? loveCount;
  int? laughCount;
  int? wowCount;
  int? sadCount;
  List<Comments>? comments;

  AllPostResponse(
      {this.id,
      this.content,
      this.groupId,
      this.groupName,
      this.memberFullName,
      this.mediaUrl,
      this.mediaType,
      this.pictureUrl,
      this.createdAt,
      this.likeCount,
      this.repostCount,
      this.likesCount,
      this.loveCount,
      this.laughCount,
      this.wowCount,
      this.sadCount,
      this.comments});

  AllPostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    groupId = json['groupId'];
    groupName = json['groupName'];
    memberFullName = json['memberFullName'];
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
    pictureUrl = json['pictureUrl'];
    createdAt = json['createdAt'];
    likeCount = json['likeCount'];
    repostCount = json['repostCount'];
    likesCount = json['likesCount'];
    loveCount = json['loveCount'];
    laughCount = json['laughCount'];
    wowCount = json['wowCount'];
    sadCount = json['sadCount'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['groupId'] = this.groupId;
    data['groupName'] = this.groupName;
    data['memberFullName'] = this.memberFullName;
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    data['pictureUrl'] = this.pictureUrl;
    data['createdAt'] = this.createdAt;
    data['likeCount'] = this.likeCount;
    data['repostCount'] = this.repostCount;
    data['likesCount'] = this.likesCount;
    data['loveCount'] = this.loveCount;
    data['laughCount'] = this.laughCount;
    data['wowCount'] = this.wowCount;
    data['sadCount'] = this.sadCount;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  int? postId;
  int? memberId;
  int? employeeId;
  String? commenterFullName;
  String? profilePictureUrl;
  String? userType;
  String? commentText;
  String? createdAt;

  Comments(
      {this.id,
      this.postId,
      this.memberId,
      this.employeeId,
      this.commenterFullName,
      this.profilePictureUrl,
      this.userType,
      this.commentText,
      this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    memberId = json['memberId'];
    employeeId = json['employeeId'];
    commenterFullName = json['commenterFullName'];
    profilePictureUrl = json['profilePictureUrl'];
    userType = json['userType'];
    commentText = json['commentText'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['memberId'] = this.memberId;
    data['employeeId'] = this.employeeId;
    data['commenterFullName'] = this.commenterFullName;
    data['profilePictureUrl'] = this.profilePictureUrl;
    data['userType'] = this.userType;
    data['commentText'] = this.commentText;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
