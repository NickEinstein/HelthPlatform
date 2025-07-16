class AllFriendRequestResponse {
  int? id;
  FriendPatient? friendPatient;
  FriendEmployee? friendEmployee;
  bool? isHealthPractitioner;
  FriendPatient? patient;
  int? status;
  int? createdBy;
  int? modifiedBy;
  String? createdAt;
  String? updatedAt;

  AllFriendRequestResponse(
      {this.id,
      this.friendPatient,
      this.friendEmployee,
      this.isHealthPractitioner,
      this.patient,
      this.status,
      this.createdBy,
      this.modifiedBy,
      this.createdAt,
      this.updatedAt});

  AllFriendRequestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    friendPatient = json['friendPatient'] != null
        ? new FriendPatient.fromJson(json['friendPatient'])
        : null;
    friendEmployee = json['friendEmployee'] != null
        ? new FriendEmployee.fromJson(json['friendEmployee'])
        : null;
    isHealthPractitioner = json['isHealthPractitioner'];
    patient = json['patient'] != null
        ? new FriendPatient.fromJson(json['patient'])
        : null;
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.friendPatient != null) {
      data['friendPatient'] = this.friendPatient!.toJson();
    }
    if (this.friendEmployee != null) {
      data['friendEmployee'] = this.friendEmployee!.toJson();
    }
    data['isHealthPractitioner'] = this.isHealthPractitioner;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class FriendPatient {
  int? id;
  String? pictureUrl;
  String? firstName;
  String? lastName;
  String? gender;

  FriendPatient(
      {this.id, this.pictureUrl, this.firstName, this.lastName, this.gender});

  FriendPatient.fromJson(Map<String, dynamic> json) {
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

class FriendEmployee {
  int? id;
  String? firstName;
  String? lastName;

  FriendEmployee({this.id, this.firstName, this.lastName});

  FriendEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
