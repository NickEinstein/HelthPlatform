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
    state = json['state'] != null ? State.fromJson(json['state']) : null;
    nationality = json['nationality'] != null
        ? State.fromJson(json['nationality'])
        : null;
    motherMaidenName = json['motherMaidenName'];
    weddingAnniversary = json['weddingAnniversary'];
    phoneNumber = json['phoneNumber'];
    profilePicture = json['profilePicture'];
    if (json['userRoles'] != null) {
      userRoles = <UserRoles>[];
      json['userRoles'].forEach((v) {
        userRoles!.add(UserRoles.fromJson(v));
      });
    }
    workGrade = json['workGrade'];
    resumptionDate = json['resumptionDate'];
    lastLoginTime = json['lastLoginTime'];
    signature = json['signature'];
    department = json['department'];
    accountStatus = json['accountStatus'];
    healthCareProvider = json['healthCareProvider'] != null
        ? HealthCareProvider.fromJson(json['healthCareProvider'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['title'] = title;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['salaryAccountNumber'] = salaryAccountNumber;
    data['salaryDomiciledBank'] = salaryDomiciledBank;
    data['nin'] = nin;
    data['bvn'] = bvn;
    data['staffId'] = staffId;
    data['dateOfBirth'] = dateOfBirth;
    data['placeOfBirth'] = placeOfBirth;
    data['maritalStatus'] = maritalStatus;
    data['religion'] = religion;
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (nationality != null) {
      data['nationality'] = nationality!.toJson();
    }
    data['motherMaidenName'] = motherMaidenName;
    data['weddingAnniversary'] = weddingAnniversary;
    data['phoneNumber'] = phoneNumber;
    data['profilePicture'] = profilePicture;
    if (userRoles != null) {
      data['userRoles'] = userRoles!.map((v) => v.toJson()).toList();
    }
    data['workGrade'] = workGrade;
    data['resumptionDate'] = resumptionDate;
    data['lastLoginTime'] = lastLoginTime;
    data['signature'] = signature;
    data['department'] = department;
    data['accountStatus'] = accountStatus;
    if (healthCareProvider != null) {
      data['healthCareProvider'] = healthCareProvider!.toJson();
    }
    data['onboardingDate'] = onboardingDate;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['modifiedAt'] = modifiedAt;
    data['modifiedBy'] = modifiedBy;
    data['actionTaken'] = actionTaken;
    data['workingHours'] = workingHours;
    data['aboutCareGiver'] = aboutCareGiver;
    data['rating'] = rating;
    data['reviews'] = reviews;
    data['usersType'] = usersType;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    role = json['role'] != null ? State.fromJson(json['role']) : null;
    roleSpecialist = json['roleSpecialist'] != null
        ? RoleSpecialist.fromJson(json['roleSpecialist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
    if (roleSpecialist != null) {
      data['roleSpecialist'] = roleSpecialist!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
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
    role = json['role'] != null ? State.fromJson(json['role']) : null;
    specialistName = json['specialistName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['specialistName'] = specialistName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rcNumber'] = rcNumber;
    data['brandName'] = brandName;
    data['logoPath'] = logoPath;
    data['location'] = location;
    data['category'] = category;
    return data;
  }
}
