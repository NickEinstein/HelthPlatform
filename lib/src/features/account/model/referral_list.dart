class ReferralList {
  int? id;
  String? pictureUrl;
  String? firstName;
  String? lastName;
  String? gender;
  int? weight;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? nin;
  String? stateOfOrigin;
  String? lga;
  String? placeOfBirth;
  String? maritalStatus;
  String? nationality;
  bool? hasHmo;
  bool? isReferred;
  int? userId;
  Null? nurseId;
  Null? doctorId;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? modifiedBy;
  String? actionTaken;
  Contact? contact;
  EmergencyContact? emergencyContact;
  List<Null>? medicalRecords;
  List<Null>? patientsHmo;

  ReferralList(
      {this.id,
      this.pictureUrl,
      this.firstName,
      this.lastName,
      this.gender,
      this.weight,
      this.dateOfBirth,
      this.email,
      this.phoneNumber,
      this.nin,
      this.stateOfOrigin,
      this.lga,
      this.placeOfBirth,
      this.maritalStatus,
      this.nationality,
      this.hasHmo,
      this.isReferred,
      this.userId,
      this.nurseId,
      this.doctorId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.modifiedBy,
      this.actionTaken,
      this.contact,
      this.emergencyContact,
      this.medicalRecords,
      this.patientsHmo});

  ReferralList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureUrl = json['pictureUrl'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    weight = json['weight'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    nin = json['nin'];
    stateOfOrigin = json['stateOfOrigin'];
    lga = json['lga'];
    placeOfBirth = json['placeOfBirth'];
    maritalStatus = json['maritalStatus'];
    nationality = json['nationality'];
    hasHmo = json['hasHmo'];
    isReferred = json['isReferred'];
    userId = json['userId'];
    nurseId = json['nurseId'];
    doctorId = json['doctorId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    emergencyContact = json['emergencyContact'] != null
        ? new EmergencyContact.fromJson(json['emergencyContact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['weight'] = weight;
    data['dateOfBirth'] = dateOfBirth;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['nin'] = nin;
    data['stateOfOrigin'] = stateOfOrigin;
    data['lga'] = lga;
    data['placeOfBirth'] = placeOfBirth;
    data['maritalStatus'] = maritalStatus;
    data['nationality'] = nationality;
    data['hasHmo'] = hasHmo;
    data['isReferred'] = isReferred;
    data['userId'] = userId;
    data['nurseId'] = nurseId;
    data['doctorId'] = doctorId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['actionTaken'] = actionTaken;
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    if (emergencyContact != null) {
      data['emergencyContact'] = emergencyContact!.toJson();
    }

    return data;
  }
}

class Contact {
  int? id;
  String? stateOfResidence;
  String? lgaResidence;
  String? city;
  String? homeAddress;
  String? phone;
  String? altPhone;
  String? email;
  int? patientId;

  Contact(
      {this.id,
      this.stateOfResidence,
      this.lgaResidence,
      this.city,
      this.homeAddress,
      this.phone,
      this.altPhone,
      this.email,
      this.patientId});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateOfResidence = json['stateOfResidence'];
    lgaResidence = json['lgaResidence'];
    city = json['city'];
    homeAddress = json['homeAddress'];
    phone = json['phone'];
    altPhone = json['altPhone'];
    email = json['email'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['stateOfResidence'] = stateOfResidence;
    data['lgaResidence'] = lgaResidence;
    data['city'] = city;
    data['homeAddress'] = homeAddress;
    data['phone'] = phone;
    data['altPhone'] = altPhone;
    data['email'] = email;
    data['patientId'] = patientId;
    return data;
  }
}

class EmergencyContact {
  int? id;
  String? relationship;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? contactAddress;
  String? stateOfResidence;
  String? lga;
  String? city;
  String? altPhone;
  int? patientId;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? modifiedBy;

  EmergencyContact(
      {this.id,
      this.relationship,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.contactAddress,
      this.stateOfResidence,
      this.lga,
      this.city,
      this.altPhone,
      this.patientId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.modifiedBy});

  EmergencyContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relationship = json['relationship'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    contactAddress = json['contactAddress'];
    stateOfResidence = json['stateOfResidence'];
    lga = json['lga'];
    city = json['city'];
    altPhone = json['altPhone'];
    patientId = json['patientId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['relationship'] = relationship;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['contactAddress'] = contactAddress;
    data['stateOfResidence'] = stateOfResidence;
    data['lga'] = lga;
    data['city'] = city;
    data['altPhone'] = altPhone;
    data['patientId'] = patientId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    return data;
  }
}
