class DoctorsRatingResponse {
  int? id;
  Patient? patient;
  Doctor? doctor;
  int? appointmentId;
  int? howAttentiveWasTheDoctorRate;
  int? howSatisfiedAreYouRate;
  int? recommendationRate;
  String? moreDetails;
  int? createdBy;
  String? createdAt;

  DoctorsRatingResponse(
      {this.id,
      this.patient,
      this.doctor,
      this.appointmentId,
      this.howAttentiveWasTheDoctorRate,
      this.howSatisfiedAreYouRate,
      this.recommendationRate,
      this.moreDetails,
      this.createdBy,
      this.createdAt});

  DoctorsRatingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    appointmentId = json['appointmentId'];
    howAttentiveWasTheDoctorRate = json['howAttentiveWasTheDoctorRate'];
    howSatisfiedAreYouRate = json['howSatisfiedAreYouRate'];
    recommendationRate = json['recommendationRate'];
    moreDetails = json['moreDetails'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    data['appointmentId'] = this.appointmentId;
    data['howAttentiveWasTheDoctorRate'] = this.howAttentiveWasTheDoctorRate;
    data['howSatisfiedAreYouRate'] = this.howSatisfiedAreYouRate;
    data['recommendationRate'] = this.recommendationRate;
    data['moreDetails'] = this.moreDetails;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Patient {
  int? id;
  String? pictureUrl;
  String? firstName;
  String? lastName;
  String? gender;

  Patient(
      {this.id, this.pictureUrl, this.firstName, this.lastName, this.gender});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureUrl = json['pictureUrl'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pictureUrl'] = this.pictureUrl;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    return data;
  }
}

class Doctor {
  int? id;
  String? firstName;
  String? lastName;

  Doctor({this.id, this.firstName, this.lastName});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
