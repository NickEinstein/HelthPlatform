import '../../../model/safe_json.dart';

class PatientContactModel {
  final String stateOfResidence;
  final String lgaResidence;
  final String city;
  final String homeAddress;
  final String phone;
  final String email;
  final String altPhone;

  PatientContactModel({
    required this.stateOfResidence,
    required this.lgaResidence,
    required this.city,
    required this.homeAddress,
    required this.phone,
    required this.email,
    required this.altPhone,
  });

  factory PatientContactModel.fromJson(Map<String, dynamic> json) {
    return PatientContactModel(
      stateOfResidence: SafeJson.asString(json['stateOfResidence']),
      lgaResidence: SafeJson.asString(json['lgaResidence']),
      city: SafeJson.asString(json['city']),
      homeAddress: SafeJson.asString(json['homeAddress']),
      phone: SafeJson.asString(json['phone']),
      email: SafeJson.asString(json['email']),
      altPhone: SafeJson.asString(json['altPhone']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stateOfResidence': stateOfResidence,
      'lgaResidence': lgaResidence,
      'city': city,
      'homeAddress': homeAddress,
      'phone': phone,
      'email': email,
      'altPhone': altPhone,
    };
  }
}
