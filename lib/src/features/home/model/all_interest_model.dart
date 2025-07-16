class AllInterestResponse {
  int? id;
  Category? category;
  Patient? patient;
  Employee? employee;
  int? status;
  int? createdBy;
  int? modifiedBy;
  String? createdAt;
  String? updatedAt;

  AllInterestResponse(
      {this.id,
      this.category,
      this.patient,
      this.employee,
      this.status,
      this.createdBy,
      this.modifiedBy,
      this.createdAt,
      this.updatedAt});

  AllInterestResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
