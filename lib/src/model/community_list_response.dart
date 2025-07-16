class CommunityListResponse {
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

  CommunityListResponse(
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

  CommunityListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    pictureUrl = json['pictureUrl'];
    description = json['description'];
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    communityGroupAdmin = json['communityGroupAdmin'] != null
        ? new CommunityGroupAdmin.fromJson(json['communityGroupAdmin'])
        : null;
    if (json['communityGroupMembers'] != null) {
      communityGroupMembers = <CommunityGroupMembers>[];
      json['communityGroupMembers'].forEach((v) {
        communityGroupMembers!.add(new CommunityGroupMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['pictureUrl'] = this.pictureUrl;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.communityGroupAdmin != null) {
      data['communityGroupAdmin'] = this.communityGroupAdmin!.toJson();
    }
    if (this.communityGroupMembers != null) {
      data['communityGroupMembers'] =
          this.communityGroupMembers!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
        ? new Employee.fromJson(json['employee'])
        : null;
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
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
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
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
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
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
