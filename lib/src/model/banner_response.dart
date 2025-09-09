class BannerResponse {
  int? id;
  String? imageUrl;
  String? dateCreated;
  int? status;

  BannerResponse({this.id, this.imageUrl, this.dateCreated, this.status});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    dateCreated = json['dateCreated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['dateCreated'] = this.dateCreated;
    data['status'] = this.status;
    return data;
  }
}

// class BannerResponse {
//   int? id;
//   String? name;
//   String? imageUrl;
//   String? linkUrl;
//   int? displayOrder;
//   bool? isActive;
//   String? createdAt;
//   String? updatedAt;

//   BannerResponse(
//       {this.id,
//       this.name,
//       this.imageUrl,
//       this.linkUrl,
//       this.displayOrder,
//       this.isActive,
//       this.createdAt,
//       this.updatedAt});

//   BannerResponse.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     imageUrl = json['imageUrl'];
//     linkUrl = json['linkUrl'];
//     displayOrder = json['displayOrder'];
//     isActive = json['isActive'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['imageUrl'] = this.imageUrl;
//     data['linkUrl'] = this.linkUrl;
//     data['displayOrder'] = this.displayOrder;
//     data['isActive'] = this.isActive;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }
