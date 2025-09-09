class DoctorListResponse {
  int? id;
  String? email;
  String? title;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? salaryAccountNumber;
  String? salaryDomiciledBank;
  String? nin;
  String? bvn;
  String? staffId;
  String? dateOfBirth;
  String? placeOfBirth;
  String? maritalStatus;
  String? religion;
  State? state;
  State? nationality;
  String? motherMaidenName;
  String? weddingAnniversary;
  String? phoneNumber;
  String? profilePicture;
  List<UserRoles>? userRoles;
  String? workGrade;
  String? resumptionDate;
  String? lastLoginTime;
  String? signature;
  String? department;
  String? accountStatus;
  HealthCareProvider? healthCareProvider;
  String? onboardingDate;
  String? createdAt;
  int? createdBy;
  String? modifiedAt;
  int? modifiedBy;
  String? actionTaken;
  String? workingHours;
  String? aboutCareGiver;
  int? rating;
  int? reviews;
  int? usersType;

  DoctorListResponse(
      {this.id,
      this.email,
      this.title,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.salaryAccountNumber,
      this.salaryDomiciledBank,
      this.nin,
      this.bvn,
      this.staffId,
      this.dateOfBirth,
      this.placeOfBirth,
      this.maritalStatus,
      this.religion,
      this.state,
      this.nationality,
      this.motherMaidenName,
      this.weddingAnniversary,
      this.phoneNumber,
      this.profilePicture,
      this.userRoles,
      this.workGrade,
      this.resumptionDate,
      this.lastLoginTime,
      this.signature,
      this.department,
      this.accountStatus,
      this.healthCareProvider,
      this.onboardingDate,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.actionTaken,
      this.workingHours,
      this.aboutCareGiver,
      this.rating,
      this.reviews,
      this.usersType});

  DoctorListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    title = json['title'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    gender = json['gender'];
    salaryAccountNumber = json['salaryAccountNumber'];
    salaryDomiciledBank = json['salaryDomiciledBank'];
    nin = json['nin'];
    bvn = json['bvn'];
    staffId = json['staffId'];
    dateOfBirth = json['dateOfBirth'];
    placeOfBirth = json['placeOfBirth'];
    maritalStatus = json['maritalStatus'];
    religion = json['religion'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    nationality = json['nationality'] != null
        ? new State.fromJson(json['nationality'])
        : null;
    motherMaidenName = json['motherMaidenName'];
    weddingAnniversary = json['weddingAnniversary'];
    phoneNumber = json['phoneNumber'];
    profilePicture = json['profilePicture'];
    if (json['userRoles'] != null) {
      userRoles = <UserRoles>[];
      json['userRoles'].forEach((v) {
        userRoles!.add(new UserRoles.fromJson(v));
      });
    }
    workGrade = json['workGrade'];
    resumptionDate = json['resumptionDate'];
    lastLoginTime = json['lastLoginTime'];
    signature = json['signature'];
    department = json['department'];
    accountStatus = json['accountStatus'];
    healthCareProvider = json['healthCareProvider'] != null
        ? new HealthCareProvider.fromJson(json['healthCareProvider'])
        : null;
    onboardingDate = json['onboardingDate'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
    workingHours = json['workingHours'];
    aboutCareGiver = json['aboutCareGiver'];
    rating = json['rating'];
    reviews = json['reviews'];
    usersType = json['usersType'];
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
    data['salaryAccountNumber'] = this.salaryAccountNumber;
    data['salaryDomiciledBank'] = this.salaryDomiciledBank;
    data['nin'] = this.nin;
    data['bvn'] = this.bvn;
    data['staffId'] = this.staffId;
    data['dateOfBirth'] = this.dateOfBirth;
    data['placeOfBirth'] = this.placeOfBirth;
    data['maritalStatus'] = this.maritalStatus;
    data['religion'] = this.religion;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.nationality != null) {
      data['nationality'] = this.nationality!.toJson();
    }
    data['motherMaidenName'] = this.motherMaidenName;
    data['weddingAnniversary'] = this.weddingAnniversary;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePicture'] = this.profilePicture;
    if (this.userRoles != null) {
      data['userRoles'] = this.userRoles!.map((v) => v.toJson()).toList();
    }
    data['workGrade'] = this.workGrade;
    data['resumptionDate'] = this.resumptionDate;
    data['lastLoginTime'] = this.lastLoginTime;
    data['signature'] = this.signature;
    data['department'] = this.department;
    data['accountStatus'] = this.accountStatus;
    if (this.healthCareProvider != null) {
      data['healthCareProvider'] = this.healthCareProvider!.toJson();
    }
    data['onboardingDate'] = this.onboardingDate;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['actionTaken'] = this.actionTaken;
    data['workingHours'] = this.workingHours;
    data['aboutCareGiver'] = this.aboutCareGiver;
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['usersType'] = this.usersType;
    return data;
  }
}

class State {
  int? id;
  String? name;

  State({this.id, this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class UserRoles {
  int? id;
  Employee? employee;
  State? role;
  RoleSpecialist? roleSpecialist;

  UserRoles({this.id, this.employee, this.role, this.roleSpecialist});

  UserRoles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    role = json['role'] != null ? new State.fromJson(json['role']) : null;
    roleSpecialist = json['roleSpecialist'] != null
        ? new RoleSpecialist.fromJson(json['roleSpecialist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.roleSpecialist != null) {
      data['roleSpecialist'] = this.roleSpecialist!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  String? firstName;
  String? lastName;

  Employee({this.id, this.firstName, this.lastName});

  Employee.fromJson(Map<String, dynamic> json) {
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

class RoleSpecialist {
  int? id;
  State? role;
  String? specialistName;

  RoleSpecialist({this.id, this.role, this.specialistName});

  RoleSpecialist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'] != null ? new State.fromJson(json['role']) : null;
    specialistName = json['specialistName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['specialistName'] = this.specialistName;
    return data;
  }
}

class HealthCareProvider {
  int? id;
  String? name;
  String? rcNumber;
  String? brandName;
  String? logoPath;
  String? location;
  String? category;

  HealthCareProvider(
      {this.id,
      this.name,
      this.rcNumber,
      this.brandName,
      this.logoPath,
      this.location,
      this.category});

  HealthCareProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rcNumber = json['rcNumber'];
    brandName = json['brandName'];
    logoPath = json['logoPath'];
    location = json['location'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rcNumber'] = this.rcNumber;
    data['brandName'] = this.brandName;
    data['logoPath'] = this.logoPath;
    data['location'] = this.location;
    data['category'] = this.category;
    return data;
  }
}
