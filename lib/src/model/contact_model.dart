class UserContact {
  int? id;
  String? stateOfResidence;
  String? lgaResidence;
  String? city;
  String? homeAddress;
  String? phone;
  String? altPhone;
  String? email;
  int? patientId;

  UserContact(
      {this.id,
      this.stateOfResidence,
      this.lgaResidence,
      this.city,
      this.homeAddress,
      this.phone,
      this.altPhone,
      this.email,
      this.patientId});

  UserContact.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class UserEmergency {
  int? id;
  String? relationship;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? contactAddress;
  String? lga;
  String? city;
  String? altPhone;
  int? patientId;
  String? stateOfResidence;
  String? fullName;

  UserEmergency(
      {this.id,
      this.relationship,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.contactAddress,
      this.lga,
      this.city,
      this.altPhone,
      this.patientId,
      this.stateOfResidence,
      this.fullName});

  UserEmergency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relationship = json['relationship'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    contactAddress = json['contactAddress'];
    lga = json['lga'];
    city = json['city'];
    altPhone = json['altPhone'];
    patientId = json['patientId'];
    stateOfResidence = json['stateOfResidence'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['relationship'] = relationship;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['contactAddress'] = contactAddress;
    data['lga'] = lga;
    data['city'] = city;
    data['altPhone'] = altPhone;
    data['patientId'] = patientId;
    data['stateOfResidence'] = stateOfResidence;
    data['fullName'] = fullName;
    return data;
  }
}
