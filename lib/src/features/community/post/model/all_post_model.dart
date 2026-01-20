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
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['groupId'] = groupId;
    data['groupName'] = groupName;
    data['memberFullName'] = memberFullName;
    data['mediaUrl'] = mediaUrl;
    data['mediaType'] = mediaType;
    data['pictureUrl'] = pictureUrl;
    data['createdAt'] = createdAt;
    data['likeCount'] = likeCount;
    data['repostCount'] = repostCount;
    data['likesCount'] = likesCount;
    data['loveCount'] = loveCount;
    data['laughCount'] = laughCount;
    data['wowCount'] = wowCount;
    data['sadCount'] = sadCount;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postId'] = postId;
    data['memberId'] = memberId;
    data['employeeId'] = employeeId;
    data['commenterFullName'] = commenterFullName;
    data['profilePictureUrl'] = profilePictureUrl;
    data['userType'] = userType;
    data['commentText'] = commentText;
    data['createdAt'] = createdAt;
    return data;
  }
}
