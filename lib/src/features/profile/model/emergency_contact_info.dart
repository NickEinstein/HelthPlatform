import '../../../model/safe_json.dart';

class EmergencyContactInfo {
  final String relationship;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String contactAddress;
  final String lga;
  final String city;
  final String altPhone;
  final int? patientId;
  final String stateOfResidence;
  final String fullName;

  EmergencyContactInfo({
    required this.relationship,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.contactAddress,
    required this.lga,
    required this.city,
    required this.altPhone,
    this.patientId,
    required this.stateOfResidence,
    required this.fullName,
  });

  factory EmergencyContactInfo.fromJson(Map<String, dynamic> json) {
    return EmergencyContactInfo(
      relationship: SafeJson.asString(json['relationship']),
      firstName: SafeJson.asString(json['firstName']),
      lastName: SafeJson.asString(json['lastName']),
      phone: SafeJson.asString(json['phone']),
      email: SafeJson.asString(json['email']),
      contactAddress: SafeJson.asString(json['contactAddress']),
      lga: SafeJson.asString(json['lga']),
      city: SafeJson.asString(json['city']),
      altPhone: SafeJson.asString(json['altPhone']),
      patientId:
          json['patientId'] != null ? SafeJson.asInt(json['patientId']) : null,
      stateOfResidence: SafeJson.asString(json['stateOfResidence']),
      fullName: SafeJson.asString(json['fullName']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationship': relationship,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'contactAddress': contactAddress,
      'lga': lga,
      'city': city,
      'altPhone': altPhone,
      'patientId': patientId,
      'stateOfResidence': stateOfResidence,
      'fullName': fullName,
    };
  }
}
