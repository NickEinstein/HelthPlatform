import 'dart:convert';

PatientProfileResult patientProfileResultFromJson(String str) =>
    PatientProfileResult.fromJson(json.decode(str));

String patientProfileResultToJson(PatientProfileResult data) =>
    json.encode(data.toJson());

class PatientProfileResult {
  final int? code;
  final String? status;
  final String? message;
  final PatientProfileData? data;

  const PatientProfileResult({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory PatientProfileResult.fromJson(Map<String, dynamic> json) =>
      PatientProfileResult(
        code: json['code'],
        status: json['status'],
        message: json['message'],
        data: json['data'] == null
            ? null
            : PatientProfileData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class PatientProfileData {
  final int? id;
  final int? usersType;
  final String? email;
  final String? userName;
  final String? pictureUrl;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? stateOfOrigin;
  final String? lga;
  final String? placeOfBirth;
  final String? maritalStatus;
  final String? nationality;
  final String? socialAccountsJson;
  final dynamic nin;
  final double? weight;
  final String? deviceToken;
  final DateTime? lastLoginTime;
  final List<dynamic>? socialAccounts;
  final String? fullName;
  final dynamic clinic;
  final int? clinicId;
  final bool? hasHmo;
  final dynamic isReferred;
  final String? patientRef;
  final int? socialRoleId;

  const PatientProfileData({
    this.id,
    this.usersType,
    this.email,
    this.userName,
    this.pictureUrl,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.stateOfOrigin,
    this.lga,
    this.placeOfBirth,
    this.maritalStatus,
    this.nationality,
    this.socialAccountsJson,
    this.nin,
    this.weight,
    this.deviceToken,
    this.lastLoginTime,
    this.socialAccounts,
    this.fullName,
    this.clinic,
    this.clinicId,
    this.hasHmo,
    this.isReferred,
    this.patientRef,
    this.socialRoleId,
  });

  factory PatientProfileData.fromJson(Map<String, dynamic> json) =>
      PatientProfileData(
        id: json['id'],
        usersType: json['usersType'],
        email: json['email'],
        userName: json['userName'],
        pictureUrl: json['pictureUrl'],
        firstName: json['firstName'],
        middleName: json['middleName'],
        lastName: json['lastName'],
        gender: json['gender'],
        dateOfBirth: json['dateOfBirth'] == null
            ? null
            : DateTime.tryParse(json['dateOfBirth']),
        phoneNumber: json['phoneNumber'],
        stateOfOrigin: json['stateOfOrigin'],
        lga: json['lga'],
        placeOfBirth: json['placeOfBirth'],
        maritalStatus: json['maritalStatus'],
        nationality: json['nationality'],
        socialAccountsJson: json['socialAccountsJson'],
        nin: json['nin'],
        weight: (json['weight'] as num?)?.toDouble(),
        deviceToken: json['deviceToken'],
        lastLoginTime: json['lastLoginTime'] == null
            ? null
            : DateTime.tryParse(json['lastLoginTime']),
        socialAccounts: json['socialAccounts'] == null
            ? []
            : List<dynamic>.from(json['socialAccounts'].map((x) => x)),
        fullName: json['fullName'],
        clinic: json['clinic'],
        clinicId: json['clinicId'],
        hasHmo: json['hasHmo'],
        isReferred: json['isReferred'],
        patientRef: json['patientRef'],
        socialRoleId: json['socialRoleId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'usersType': usersType,
        'email': email,
        'userName': userName,
        'pictureUrl': pictureUrl,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'gender': gender,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'phoneNumber': phoneNumber,
        'stateOfOrigin': stateOfOrigin,
        'lga': lga,
        'placeOfBirth': placeOfBirth,
        'maritalStatus': maritalStatus,
        'nationality': nationality,
        'socialAccountsJson': socialAccountsJson,
        'nin': nin,
        'weight': weight,
        'deviceToken': deviceToken,
        'lastLoginTime': lastLoginTime?.toIso8601String(),
        'socialAccounts': socialAccounts == null
            ? []
            : List<dynamic>.from(socialAccounts!.map((x) => x)),
        'fullName': fullName,
        'clinic': clinic,
        'clinicId': clinicId,
        'hasHmo': hasHmo,
        'isReferred': isReferred,
        'patientRef': patientRef,
        'socialRoleId': socialRoleId,
      };
}