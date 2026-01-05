class GroupInterestResponse {
  int? id;
  String? name;
  Category? category;
  String? pictureUrl;
  String? description;
  int? status;
  int? createdBy;
  int? modifiedBy;
  String? createdAt;
  String? updatedAt;
  CommunityGroupAdmin? communityGroupAdmin;
  List<CommunityGroupMembers>? communityGroupMembers;

  GroupInterestResponse(
      {this.id,
      this.name,
      this.category,
      this.pictureUrl,
      this.description,
      this.status,
      this.createdBy,
      this.modifiedBy,
      this.createdAt,
      this.updatedAt,
      this.communityGroupAdmin,
      this.communityGroupMembers});

  GroupInterestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null
        ?  Category.fromJson(json['category'])
        : null;
    pictureUrl = json['pictureUrl'];
    description = json['description'];
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    communityGroupAdmin = json['communityGroupAdmin'] != null
        ? CommunityGroupAdmin.fromJson(json['communityGroupAdmin'])
        : null;
    if (json['communityGroupMembers'] != null) {
      communityGroupMembers = <CommunityGroupMembers>[];
      json['communityGroupMembers'].forEach((v) {
        communityGroupMembers!.add(CommunityGroupMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['pictureUrl'] = pictureUrl;
    data['description'] = description;
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (communityGroupAdmin != null) {
      data['communityGroupAdmin'] = communityGroupAdmin!.toJson();
    }
    if (communityGroupMembers != null) {
      data['communityGroupMembers'] =
          communityGroupMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class CommunityGroupAdmin {
  int? id;
  Employee? employee;
  int? status;
  int? createdBy;
  String? createdAt;

  CommunityGroupAdmin(
      {this.id, this.employee, this.status, this.createdBy, this.createdAt});

  CommunityGroupAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Employee {
  int? id;
  String? firstName;
  String? lastName;

  Employee({this.id, this.firstName, this.lastName});

  Employee.fromJson(Map<String, dynamic> json) {
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

class CommunityGroupMembers {
  int? id;
  Patient? patient;
  Employee? employee;
  int? status;
  int? createdBy;
  String? joinAt;

  CommunityGroupMembers(
      {this.id,
      this.patient,
      this.employee,
      this.status,
      this.createdBy,
      this.joinAt});

  CommunityGroupMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
    status = json['status'];
    createdBy = json['createdBy'];
    joinAt = json['joinAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['joinAt'] = joinAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    return data;
  }
}
