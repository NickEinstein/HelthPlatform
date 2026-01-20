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
        ? FriendPatient.fromJson(json['friendPatient'])
        : null;
    friendEmployee = json['friendEmployee'] != null
        ? FriendEmployee.fromJson(json['friendEmployee'])
        : null;
    isHealthPractitioner = json['isHealthPractitioner'];
    patient = json['patient'] != null
        ? FriendPatient.fromJson(json['patient'])
        : null;
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (friendPatient != null) {
      data['friendPatient'] = friendPatient!.toJson();
    }
    if (friendEmployee != null) {
      data['friendEmployee'] = friendEmployee!.toJson();
    }
    data['isHealthPractitioner'] = isHealthPractitioner;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
