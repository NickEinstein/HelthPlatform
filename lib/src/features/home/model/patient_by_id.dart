class PatientByIDResponse {
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

  PatientByIDResponse(
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

  PatientByIDResponse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['phoneNumber'] = phoneNumber;
    data['stateOfOrigin'] = stateOfOrigin;
    data['lga'] = lga;
    data['placeOfBirth'] = placeOfBirth;
    data['maritalStatus'] = maritalStatus;
    data['nationality'] = nationality;
    data['fullName'] = fullName;
    data['clinic'] = clinic;
    data['clinicId'] = clinicId;
    data['hasHmo'] = hasHmo;
    data['isReferred'] = isReferred;
    data['patientRef'] = patientRef;
    return data;
  }
}
