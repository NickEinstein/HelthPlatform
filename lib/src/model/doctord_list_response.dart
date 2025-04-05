class DoctorListResponse {
  int? id;
  String? email;
  String? title;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? placeOfBirth;
  String? maritalStatus;
  String? motherMaidenName;
  String? weddingAnniversary;
  String? authToken;
  int? stateId;
  int? nationalityId;
  int? religionId;
  String? designation;
  String? staffId;
  String? bvn;
  String? nin;
  String? salaryAccountNumber;
  String? salaryDomiciledBank;
  int? clinicId;
  String? clinic;
  int? healthCareProviderId;
  String? profilePicture;
  String? role;
  String? employeePrivilegeAccesses;
  String? department;
  String? workGrade;
  int? userId;
  String? username;
  bool? isSuperAdmin;
  String? resumptionDate;
  String? onboardingDate;
  String? lastLoginTime;
  String? signature;
  String? createdAt;
  int? createdBy;
  String? modifiedAt;
  int? modifiedBy;
  String? actionTaken;
  String? workingHours;
  String? aboutCareGiver;
  int? rating;
  int? reviews;
  int? status;
  String? accountStatus;

  DoctorListResponse(
      {this.id,
      this.email,
      this.title,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.dateOfBirth,
      this.placeOfBirth,
      this.maritalStatus,
      this.motherMaidenName,
      this.weddingAnniversary,
      this.authToken,
      this.stateId,
      this.nationalityId,
      this.religionId,
      this.designation,
      this.staffId,
      this.bvn,
      this.nin,
      this.salaryAccountNumber,
      this.salaryDomiciledBank,
      this.clinicId,
      this.clinic,
      this.healthCareProviderId,
      this.profilePicture,
      this.role,
      this.employeePrivilegeAccesses,
      this.department,
      this.workGrade,
      this.userId,
      this.username,
      this.isSuperAdmin,
      this.resumptionDate,
      this.onboardingDate,
      this.lastLoginTime,
      this.signature,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.actionTaken,
      this.workingHours,
      this.aboutCareGiver,
      this.rating,
      this.reviews,
      this.status,
      this.accountStatus});

  DoctorListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    title = json['title'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    placeOfBirth = json['placeOfBirth'];
    maritalStatus = json['maritalStatus'];
    motherMaidenName = json['motherMaidenName'];
    weddingAnniversary = json['weddingAnniversary'];
    authToken = json['authToken'];
    stateId = json['stateId'];
    nationalityId = json['nationalityId'];
    religionId = json['religionId'];
    designation = json['designation'];
    staffId = json['staffId'];
    bvn = json['bvn'];
    nin = json['nin'];
    salaryAccountNumber = json['salaryAccountNumber'];
    salaryDomiciledBank = json['salaryDomiciledBank'];
    clinicId = json['clinicId'];
    clinic = json['clinic'];
    healthCareProviderId = json['healthCareProviderId'];
    profilePicture = json['profilePicture'];
    role = json['role'];
    employeePrivilegeAccesses = json['employeePrivilegeAccesses'];
    department = json['department'];
    workGrade = json['workGrade'];
    userId = json['userId'];
    username = json['username'];
    isSuperAdmin = json['isSuperAdmin'];
    resumptionDate = json['resumptionDate'];
    onboardingDate = json['onboardingDate'];
    lastLoginTime = json['lastLoginTime'];
    signature = json['signature'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
    workingHours = json['workingHours'];
    aboutCareGiver = json['aboutCareGiver'];
    rating = json['rating'];
    reviews = json['reviews'];
    status = json['status'];
    accountStatus = json['accountStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['placeOfBirth'] = this.placeOfBirth;
    data['maritalStatus'] = this.maritalStatus;
    data['motherMaidenName'] = this.motherMaidenName;
    data['weddingAnniversary'] = this.weddingAnniversary;
    data['authToken'] = this.authToken;
    data['stateId'] = this.stateId;
    data['nationalityId'] = this.nationalityId;
    data['religionId'] = this.religionId;
    data['designation'] = this.designation;
    data['staffId'] = this.staffId;
    data['bvn'] = this.bvn;
    data['nin'] = this.nin;
    data['salaryAccountNumber'] = this.salaryAccountNumber;
    data['salaryDomiciledBank'] = this.salaryDomiciledBank;
    data['clinicId'] = this.clinicId;
    data['clinic'] = this.clinic;
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['profilePicture'] = this.profilePicture;
    data['role'] = this.role;
    data['employeePrivilegeAccesses'] = this.employeePrivilegeAccesses;
    data['department'] = this.department;
    data['workGrade'] = this.workGrade;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['isSuperAdmin'] = this.isSuperAdmin;
    data['resumptionDate'] = this.resumptionDate;
    data['onboardingDate'] = this.onboardingDate;
    data['lastLoginTime'] = this.lastLoginTime;
    data['signature'] = this.signature;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['actionTaken'] = this.actionTaken;
    data['workingHours'] = this.workingHours;
    data['aboutCareGiver'] = this.aboutCareGiver;
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['status'] = this.status;
    data['accountStatus'] = this.accountStatus;
    return data;
  }
}
