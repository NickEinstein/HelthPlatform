import 'dart:convert';
import '../../../model/safe_json.dart';

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
        code: SafeJson.asInt(json['code']),
        status: SafeJson.asString(json['status']),
        message: SafeJson.asString(json['message']),
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

  factory PatientProfileData.fromJson(Map<String, dynamic> json) {
    // json.entries.forEach(print);
    return PatientProfileData(
      id: SafeJson.asInt(json['id']),
      usersType: SafeJson.asInt(json['usersType']),
      email: SafeJson.asString(json['email']),
      userName: SafeJson.asString(json['userName']),
      pictureUrl: SafeJson.asString(json['pictureUrl']),
      firstName: SafeJson.asString(json['firstName']),
      middleName: SafeJson.asString(json['middleName']),
      lastName: SafeJson.asString(json['lastName']),
      gender: SafeJson.asString(json['gender']),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.tryParse(SafeJson.asString(json['dateOfBirth'])),
      phoneNumber: SafeJson.asString(json['phoneNumber']),
      stateOfOrigin: SafeJson.asString(json['stateOfOrigin']),
      lga: SafeJson.asString(json['lga']),
      placeOfBirth: SafeJson.asString(json['placeOfBirth']),
      maritalStatus: SafeJson.asString(json['maritalStatus']),
      nationality: SafeJson.asString(json['nationality']),
      socialAccountsJson: SafeJson.asString(json['socialAccountsJson']),
      nin: json['nin'], // Keeping dynamic as it was
      weight: SafeJson.asDouble(json['weight']),
      deviceToken: SafeJson.asString(json['deviceToken']),
      lastLoginTime: json['lastLoginTime'] == null
          ? null
          : DateTime.tryParse(SafeJson.asString(json['lastLoginTime'])),
      socialAccounts: SafeJson.asList(json['socialAccounts']),
      fullName: SafeJson.asString(json['fullName']),
      clinic: json['clinic'], // Keeping dynamic
      clinicId: SafeJson.asInt(json['clinicId']),
      hasHmo: SafeJson.asBool(json['hasHmo']),
      isReferred: json['isReferred'], // Keeping dynamic
      patientRef: SafeJson.asString(json['patientRef']),
      socialRoleId: SafeJson.asInt(json['socialRoleId']),
    );
  }

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
