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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stateOfResidence'] = this.stateOfResidence;
    data['lgaResidence'] = this.lgaResidence;
    data['city'] = this.city;
    data['homeAddress'] = this.homeAddress;
    data['phone'] = this.phone;
    data['altPhone'] = this.altPhone;
    data['email'] = this.email;
    data['patientId'] = this.patientId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['relationship'] = this.relationship;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['contactAddress'] = this.contactAddress;
    data['lga'] = this.lga;
    data['city'] = this.city;
    data['altPhone'] = this.altPhone;
    data['patientId'] = this.patientId;
    data['stateOfResidence'] = this.stateOfResidence;
    data['fullName'] = this.fullName;
    return data;
  }
}
