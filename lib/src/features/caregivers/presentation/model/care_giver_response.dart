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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['dateEstablished'] = this.dateEstablished;
    data['mandate'] = this.mandate;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['logoPath'] = this.logoPath;
    data['cacPath'] = this.cacPath;
    data['rcNumber'] = this.rcNumber;
    data['brandName'] = this.brandName;
    data['stateId'] = this.stateId;
    data['lgaId'] = this.lgaId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    data['updatedAt'] = this.updatedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['actionTaken'] = this.actionTaken;
    data['status'] = this.status;
    return data;
  }
}
