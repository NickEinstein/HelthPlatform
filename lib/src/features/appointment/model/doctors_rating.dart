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
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    appointmentId = json['appointmentId'];
    howAttentiveWasTheDoctorRate = json['howAttentiveWasTheDoctorRate'];
    howSatisfiedAreYouRate = json['howSatisfiedAreYouRate'];
    recommendationRate = json['recommendationRate'];
    moreDetails = json['moreDetails'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['appointmentId'] = appointmentId;
    data['howAttentiveWasTheDoctorRate'] = howAttentiveWasTheDoctorRate;
    data['howSatisfiedAreYouRate'] = howSatisfiedAreYouRate;
    data['recommendationRate'] = recommendationRate;
    data['moreDetails'] = moreDetails;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
