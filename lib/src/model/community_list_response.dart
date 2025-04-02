class CommunityListResponse {
  int? id;
  String? name;
  String? pictureUrl;
  String? description;
  int? status;
  int? createdBy;
  int? modifiedBy;
  String? createdAt;
  String? updatedAt;
  List<CommunityMembers>? communityMembers;

  CommunityListResponse(
      {this.id,
      this.name,
      this.pictureUrl,
      this.description,
      this.status,
      this.createdBy,
      this.modifiedBy,
      this.createdAt,
      this.updatedAt,
      this.communityMembers});

  CommunityListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pictureUrl = json['pictureUrl'];
    description = json['description'];
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['communityMembers'] != null) {
      communityMembers = <CommunityMembers>[];
      json['communityMembers'].forEach((v) {
        communityMembers!.add(new CommunityMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pictureUrl'] = this.pictureUrl;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.communityMembers != null) {
      data['communityMembers'] =
          this.communityMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommunityMembers {
  int? id;
  Patient? patient;
  int? status;
  int? createdBy;
  String? joinAt;

  CommunityMembers(
      {this.id, this.patient, this.status, this.createdBy, this.joinAt});

  CommunityMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    status = json['status'];
    createdBy = json['createdBy'];
    joinAt = json['joinAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['joinAt'] = this.joinAt;
    return data;
  }
}

class Patient {
  int? id;
  String? pictureUrl;
  String? firstName;
  String? lastName;
  String? gender;

  Patient(
      {this.id, this.pictureUrl, this.firstName, this.lastName, this.gender});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureUrl = json['pictureUrl'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pictureUrl'] = this.pictureUrl;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    return data;
  }
}
