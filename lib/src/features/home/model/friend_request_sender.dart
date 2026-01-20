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
        ? PatientSender.fromJson(json['patientSender'])
        : null;
    patientReceiver = json['patientReceiver'] != null
        ? PatientSender.fromJson(json['patientReceiver'])
        : null;
    employeeSender = json['employeeSender'] != null
        ? EmployeeSender.fromJson(json['employeeSender'])
        : null;
    employeeReceiver = json['employeeReceiver'] != null
        ? EmployeeSender.fromJson(json['employeeReceiver'])
        : null;
    status = json['status'];
    isHealthPractitioner = json['isHealthPractitioner'];
    createdAt = json['createdAt'];
    acceptedAt = json['acceptedAt'];
    rejectedAt = json['rejectedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (patientSender != null) {
      data['patientSender'] = patientSender!.toJson();
    }
    if (patientReceiver != null) {
      data['patientReceiver'] = patientReceiver!.toJson();
    }
    if (employeeSender != null) {
      data['employeeSender'] = employeeSender!.toJson();
    }
    if (employeeReceiver != null) {
      data['employeeReceiver'] = employeeReceiver!.toJson();
    }
    data['status'] = status;
    data['isHealthPractitioner'] = isHealthPractitioner;
    data['createdAt'] = createdAt;
    data['acceptedAt'] = acceptedAt;
    data['rejectedAt'] = rejectedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
