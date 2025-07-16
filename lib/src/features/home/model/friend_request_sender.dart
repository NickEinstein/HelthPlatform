class FriendRequestSenderResponse {
  int? id;
  PatientSender? patientSender;
  PatientSender? patientReceiver;
  EmployeeSender? employeeSender;
  EmployeeSender? employeeReceiver;
  int? status;
  bool? isHealthPractitioner;
  String? createdAt;
  String? acceptedAt;
  String? rejectedAt;

  FriendRequestSenderResponse(
      {this.id,
      this.patientSender,
      this.patientReceiver,
      this.employeeSender,
      this.employeeReceiver,
      this.status,
      this.isHealthPractitioner,
      this.createdAt,
      this.acceptedAt,
      this.rejectedAt});

  FriendRequestSenderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientSender = json['patientSender'] != null
        ? new PatientSender.fromJson(json['patientSender'])
        : null;
    patientReceiver = json['patientReceiver'] != null
        ? new PatientSender.fromJson(json['patientReceiver'])
        : null;
    employeeSender = json['employeeSender'] != null
        ? new EmployeeSender.fromJson(json['employeeSender'])
        : null;
    employeeReceiver = json['employeeReceiver'] != null
        ? new EmployeeSender.fromJson(json['employeeReceiver'])
        : null;
    status = json['status'];
    isHealthPractitioner = json['isHealthPractitioner'];
    createdAt = json['createdAt'];
    acceptedAt = json['acceptedAt'];
    rejectedAt = json['rejectedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patientSender != null) {
      data['patientSender'] = this.patientSender!.toJson();
    }
    if (this.patientReceiver != null) {
      data['patientReceiver'] = this.patientReceiver!.toJson();
    }
    if (this.employeeSender != null) {
      data['employeeSender'] = this.employeeSender!.toJson();
    }
    if (this.employeeReceiver != null) {
      data['employeeReceiver'] = this.employeeReceiver!.toJson();
    }
    data['status'] = this.status;
    data['isHealthPractitioner'] = this.isHealthPractitioner;
    data['createdAt'] = this.createdAt;
    data['acceptedAt'] = this.acceptedAt;
    data['rejectedAt'] = this.rejectedAt;
    return data;
  }
}

class PatientSender {
  int? id;
  String? pictureUrl;
  String? firstName;
  String? lastName;
  String? gender;

  PatientSender(
      {this.id, this.pictureUrl, this.firstName, this.lastName, this.gender});

  PatientSender.fromJson(Map<String, dynamic> json) {
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

class EmployeeSender {
  int? id;
  String? firstName;
  String? lastName;

  EmployeeSender({this.id, this.firstName, this.lastName});

  EmployeeSender.fromJson(Map<String, dynamic> json) {
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
