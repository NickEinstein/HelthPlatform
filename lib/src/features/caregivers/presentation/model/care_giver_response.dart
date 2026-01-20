class CareGiverResponse {
  int? id;
  String? name;
  String? location;
  String? dateEstablished;
  String? mandate;
  String? createdAt;
  int? createdBy;
  String? logoPath;
  String? cacPath;
  String? rcNumber;
  String? brandName;
  int? stateId;
  int? lgaId;
  String? phone;
  String? email;
  String? website;
  String? updatedAt;
  int? modifiedBy;
  String? actionTaken;
  int? status;

  CareGiverResponse(
      {this.id,
      this.name,
      this.location,
      this.dateEstablished,
      this.mandate,
      this.createdAt,
      this.createdBy,
      this.logoPath,
      this.cacPath,
      this.rcNumber,
      this.brandName,
      this.stateId,
      this.lgaId,
      this.phone,
      this.email,
      this.website,
      this.updatedAt,
      this.modifiedBy,
      this.actionTaken,
      this.status});

  CareGiverResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    dateEstablished = json['dateEstablished'];
    mandate = json['mandate'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    logoPath = json['logoPath'];
    cacPath = json['cacPath'];
    rcNumber = json['rcNumber'];
    brandName = json['brandName'];
    stateId = json['stateId'];
    lgaId = json['lgaId'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    updatedAt = json['updatedAt'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['dateEstablished'] = dateEstablished;
    data['mandate'] = mandate;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['logoPath'] = logoPath;
    data['cacPath'] = cacPath;
    data['rcNumber'] = rcNumber;
    data['brandName'] = brandName;
    data['stateId'] = stateId;
    data['lgaId'] = lgaId;
    data['phone'] = phone;
    data['email'] = email;
    data['website'] = website;
    data['updatedAt'] = updatedAt;
    data['modifiedBy'] = modifiedBy;
    data['actionTaken'] = actionTaken;
    data['status'] = status;
    return data;
  }
}
