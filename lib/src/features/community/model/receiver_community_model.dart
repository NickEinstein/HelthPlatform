class CommunityGroupReceiverResponse {
  final int id;
  final Patient? patientSender;
  final Patient? patientReceiver;
  final Employee? employeeSender;
  final Employee? employeeReceiver;
  final int status;
  final bool isHealthPractitioner;
  final CommunityGroup? communityGroup;
  final DateTime? createdAt;
  final DateTime? acceptedAt;
  final DateTime? rejectedAt;

  CommunityGroupReceiverResponse({
    required this.id,
    this.patientSender,
    this.patientReceiver,
    this.employeeSender,
    this.employeeReceiver,
    required this.status,
    required this.isHealthPractitioner,
    this.communityGroup,
    this.createdAt,
    this.acceptedAt,
    this.rejectedAt,
  });

  factory CommunityGroupReceiverResponse.fromJson(Map<String, dynamic> json) {
    return CommunityGroupReceiverResponse(
      id: json['id'],
      patientSender: json['patientSender'] != null
          ? Patient.fromJson(json['patientSender'])
          : null,
      patientReceiver: json['patientReceiver'] != null
          ? Patient.fromJson(json['patientReceiver'])
          : null,
      employeeSender: json['employeeSender'] != null
          ? Employee.fromJson(json['employeeSender'])
          : null,
      employeeReceiver: json['employeeReceiver'] != null
          ? Employee.fromJson(json['employeeReceiver'])
          : null,
      status: json['status'],
      isHealthPractitioner: json['isHealthPractitioner'] ?? false,
      communityGroup: json['communityGroup'] != null
          ? CommunityGroup.fromJson(json['communityGroup'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.parse(json['acceptedAt'])
          : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.parse(json['rejectedAt'])
          : null,
    );
  }
}

class Patient {
  final int id;
  final String? pictureUrl;
  final String? firstName;
  final String? lastName;
  final String? gender;

  Patient({
    required this.id,
    this.pictureUrl,
    this.firstName,
    this.lastName,
    this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      pictureUrl: json['pictureUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
    );
  }
}

class Employee {
  final int id;
  final String? firstName;
  final String? lastName;

  Employee({
    required this.id,
    this.firstName,
    this.lastName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class CommunityGroup {
  final int id;
  final String? name;

  CommunityGroup({
    required this.id,
    this.name,
  });

  factory CommunityGroup.fromJson(Map<String, dynamic> json) {
    return CommunityGroup(
      id: json['id'],
      name: json['name'],
    );
  }
}
