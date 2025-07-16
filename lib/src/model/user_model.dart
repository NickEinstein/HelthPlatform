class UserData {
  int? id;
  String? email;
  String? pictureUrl;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? phoneNumber;
  String? stateOfOrigin;
  String? lga;
  String? placeOfBirth;
  String? maritalStatus;
  String? nationality;
  String? fullName;
  String? clinic;
  int? clinicId;
  bool? hasHmo;
  String? isReferred;
  String? patientRef;

  UserData(
      {this.id,
      this.email,
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
      this.fullName,
      this.clinic,
      this.clinicId,
      this.hasHmo,
      this.isReferred,
      this.patientRef});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    pictureUrl = json['pictureUrl'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    phoneNumber = json['phoneNumber'];
    stateOfOrigin = json['stateOfOrigin'];
    lga = json['lga'];
    placeOfBirth = json['placeOfBirth'];
    maritalStatus = json['maritalStatus'];
    nationality = json['nationality'];
    fullName = json['fullName'];
    clinic = json['clinic'];
    clinicId = json['clinicId'];
    hasHmo = json['hasHmo'];
    isReferred = json['isReferred'];
    patientRef = json['patientRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['pictureUrl'] = this.pictureUrl;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['phoneNumber'] = this.phoneNumber;
    data['stateOfOrigin'] = this.stateOfOrigin;
    data['lga'] = this.lga;
    data['placeOfBirth'] = this.placeOfBirth;
    data['maritalStatus'] = this.maritalStatus;
    data['nationality'] = this.nationality;
    data['fullName'] = this.fullName;
    data['clinic'] = this.clinic;
    data['clinicId'] = this.clinicId;
    data['hasHmo'] = this.hasHmo;
    data['isReferred'] = this.isReferred;
    data['patientRef'] = this.patientRef;
    return data;
  }
}
