class HmoResponse {
  int? id;
  int? hmoPackageId;
  String? hmoPackage;
  List<Benefit>? benefit;
  int? patientHMOId;
  String? membershipValidity;
  String? notes;
  String? patientHMOCardDocumentUrl;
  int? patientId;
  int? hmoProviderId;
  String? hmoProvider;
  int? healthCareProviderId;

  HmoResponse(
      {this.id,
      this.hmoPackageId,
      this.hmoPackage,
      this.benefit,
      this.patientHMOId,
      this.membershipValidity,
      this.notes,
      this.patientHMOCardDocumentUrl,
      this.patientId,
      this.hmoProviderId,
      this.hmoProvider,
      this.healthCareProviderId});

  HmoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hmoPackageId = json['hmoPackageId'];
    hmoPackage = json['hmoPackage'];
    if (json['benefit'] != null) {
      benefit = <Benefit>[];
      json['benefit'].forEach((v) {
        benefit!.add(new Benefit.fromJson(v));
      });
    }
    patientHMOId = json['patientHMOId'];
    membershipValidity = json['membershipValidity'];
    notes = json['notes'];
    patientHMOCardDocumentUrl = json['patientHMOCardDocumentUrl'];
    patientId = json['patientId'];
    hmoProviderId = json['hmoProviderId'];
    hmoProvider = json['hmoProvider'];
    healthCareProviderId = json['healthCareProviderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hmoPackageId'] = this.hmoPackageId;
    data['hmoPackage'] = this.hmoPackage;
    if (this.benefit != null) {
      data['benefit'] = this.benefit!.map((v) => v.toJson()).toList();
    }
    data['patientHMOId'] = this.patientHMOId;
    data['membershipValidity'] = this.membershipValidity;
    data['notes'] = this.notes;
    data['patientHMOCardDocumentUrl'] = this.patientHMOCardDocumentUrl;
    data['patientId'] = this.patientId;
    data['hmoProviderId'] = this.hmoProviderId;
    data['hmoProvider'] = this.hmoProvider;
    data['healthCareProviderId'] = this.healthCareProviderId;
    return data;
  }
}

class Benefit {
  int? id;
  int? categoryId;
  Category? category;
  int? hmoId;
  int? packageId;
  int? serviceOrProductId;
  String? benefitProvision;
  String? benefitLimit;
  int? limitAmount;
  bool? isLab;
  bool? isBed;
  bool? isEquipment;
  bool? isPharmacy;
  int? healthCareProviderId;
  int? createdBy;
  int? modifiedBy;
  String? createdOn;
  String? modifiedOn;
  String? actionTaken;
  Packages? package;

  Benefit(
      {this.id,
      this.categoryId,
      this.category,
      this.hmoId,
      this.packageId,
      this.serviceOrProductId,
      this.benefitProvision,
      this.benefitLimit,
      this.limitAmount,
      this.isLab,
      this.isBed,
      this.isEquipment,
      this.isPharmacy,
      this.healthCareProviderId,
      this.createdBy,
      this.modifiedBy,
      this.createdOn,
      this.modifiedOn,
      this.actionTaken,
      this.package});

  Benefit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    hmoId = json['hmoId'];
    packageId = json['packageId'];
    serviceOrProductId = json['serviceOrProductId'];
    benefitProvision = json['benefitProvision'];
    benefitLimit = json['benefitLimit'];
    limitAmount = json['limitAmount'];
    isLab = json['isLab'];
    isBed = json['isBed'];
    isEquipment = json['isEquipment'];
    isPharmacy = json['isPharmacy'];
    healthCareProviderId = json['healthCareProviderId'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    actionTaken = json['actionTaken'];
    package =
        json['package'] != null ? new Packages.fromJson(json['package']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['hmoId'] = this.hmoId;
    data['packageId'] = this.packageId;
    data['serviceOrProductId'] = this.serviceOrProductId;
    data['benefitProvision'] = this.benefitProvision;
    data['benefitLimit'] = this.benefitLimit;
    data['limitAmount'] = this.limitAmount;
    data['isLab'] = this.isLab;
    data['isBed'] = this.isBed;
    data['isEquipment'] = this.isEquipment;
    data['isPharmacy'] = this.isPharmacy;
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['actionTaken'] = this.actionTaken;
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? createdBy;
  int? modifiedBy;
  String? actionTaken;
  int? clinicId;

  Category(
      {this.id,
      this.name,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.createdBy,
      this.modifiedBy,
      this.actionTaken,
      this.clinicId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
    clinicId = json['clinicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['actionTaken'] = this.actionTaken;
    data['clinicId'] = this.clinicId;
    return data;
  }
}

class Package {
  int? id;
  String? name;
  int? hmoId;
  int? userId;
  int? createdBy;
  int? modifiedBy;
  String? createdOn;
  String? modifiedOn;
  String? actionTaken;
  int? healthCareProviderId;
  Hmo? hmo;

  Package({
    this.id,
    this.name,
    this.hmoId,
    this.userId,
    this.createdBy,
    this.modifiedBy,
    this.createdOn,
    this.modifiedOn,
    this.actionTaken,
    this.healthCareProviderId,
    this.hmo,
  });

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hmoId = json['hmoId'];
    userId = json['userId'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    actionTaken = json['actionTaken'];
    healthCareProviderId = json['healthCareProviderId'];
    hmo = json['hmo'] != null ? new Hmo.fromJson(json['hmo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hmoId'] = this.hmoId;
    data['userId'] = this.userId;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['actionTaken'] = this.actionTaken;
    data['healthCareProviderId'] = this.healthCareProviderId;

    return data;
  }
}

class Hmo {
  int? id;
  String? vendorName;
  String? phoneNumber;
  String? email;
  String? contactPerson;
  String? rcNumber;
  String? taxIdentityNumber;
  String? officeAddress;
  int? countryId;
  int? stateId;
  State? state;
  String? lga;
  String? city;
  String? altPhoneNumber;
  List<Packages>? packages;
  int? userId;
  int? healthCareProviderId;
  int? createdBy;
  int? modifiedBy;
  String? createdOn;
  String? modifiedOn;
  String? actionTaken;

  Hmo(
      {this.id,
      this.vendorName,
      this.phoneNumber,
      this.email,
      this.contactPerson,
      this.rcNumber,
      this.taxIdentityNumber,
      this.officeAddress,
      this.countryId,
      this.stateId,
      this.state,
      this.lga,
      this.city,
      this.altPhoneNumber,
      this.packages,
      this.userId,
      this.healthCareProviderId,
      this.createdBy,
      this.modifiedBy,
      this.createdOn,
      this.modifiedOn,
      this.actionTaken});

  Hmo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendorName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    contactPerson = json['contactPerson'];
    rcNumber = json['rcNumber'];
    taxIdentityNumber = json['taxIdentityNumber'];
    officeAddress = json['officeAddress'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    lga = json['lga'];
    city = json['city'];
    altPhoneNumber = json['altPhoneNumber'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
    userId = json['userId'];
    healthCareProviderId = json['healthCareProviderId'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    actionTaken = json['actionTaken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendorName'] = this.vendorName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['contactPerson'] = this.contactPerson;
    data['rcNumber'] = this.rcNumber;
    data['taxIdentityNumber'] = this.taxIdentityNumber;
    data['officeAddress'] = this.officeAddress;
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    data['lga'] = this.lga;
    data['city'] = this.city;
    data['altPhoneNumber'] = this.altPhoneNumber;
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['actionTaken'] = this.actionTaken;
    return data;
  }
}

class State {
  int? id;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? actionTaken;
  String? status;
  String? name;

  State(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.actionTaken,
      this.status,
      this.name});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['actionTaken'] = this.actionTaken;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}

class Packages {
  int? id;
  String? name;
  int? hmoId;
  int? userId;
  int? createdBy;
  int? modifiedBy;
  String? createdOn;
  String? modifiedOn;
  String? actionTaken;
  int? healthCareProviderId;
  Hmo? hmo;
  List<String>? packageBenefits;

  Packages(
      {this.id,
      this.name,
      this.hmoId,
      this.userId,
      this.createdBy,
      this.modifiedBy,
      this.createdOn,
      this.modifiedOn,
      this.actionTaken,
      this.healthCareProviderId,
      this.hmo,
      this.packageBenefits});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hmoId = json['hmoId'];
    userId = json['userId'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    actionTaken = json['actionTaken'];
    healthCareProviderId = json['healthCareProviderId'];
    hmo = json['hmo'] != null ? new Hmo.fromJson(json['hmo']) : null;
    packageBenefits = json['packageBenefits'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hmoId'] = this.hmoId;
    data['userId'] = this.userId;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['actionTaken'] = this.actionTaken;
    data['healthCareProviderId'] = this.healthCareProviderId;
    if (this.hmo != null) {
      data['hmo'] = this.hmo!.toJson();
    }
    data['packageBenefits'] = this.packageBenefits;
    return data;
  }
}

class HmoIS {
  int? id;
  String? vendorName;
  String? phoneNumber;
  String? email;
  String? contactPerson;
  String? rcNumber;
  String? taxIdentityNumber;
  String? officeAddress;
  int? countryId;
  int? stateId;
  State? state;
  String? lga;
  String? city;
  String? altPhoneNumber;
  List<String>? packages;
  int? userId;
  int? healthCareProviderId;
  int? createdBy;
  int? modifiedBy;
  String? createdOn;
  String? modifiedOn;
  String? actionTaken;

  HmoIS(
      {this.id,
      this.vendorName,
      this.phoneNumber,
      this.email,
      this.contactPerson,
      this.rcNumber,
      this.taxIdentityNumber,
      this.officeAddress,
      this.countryId,
      this.stateId,
      this.state,
      this.lga,
      this.city,
      this.altPhoneNumber,
      this.packages,
      this.userId,
      this.healthCareProviderId,
      this.createdBy,
      this.modifiedBy,
      this.createdOn,
      this.modifiedOn,
      this.actionTaken});

  HmoIS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendorName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    contactPerson = json['contactPerson'];
    rcNumber = json['rcNumber'];
    taxIdentityNumber = json['taxIdentityNumber'];
    officeAddress = json['officeAddress'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    lga = json['lga'];
    city = json['city'];
    altPhoneNumber = json['altPhoneNumber'];
    packages = json['packages'].cast<String>();
    userId = json['userId'];
    healthCareProviderId = json['healthCareProviderId'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    createdOn = json['createdOn'];
    modifiedOn = json['modifiedOn'];
    actionTaken = json['actionTaken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendorName'] = this.vendorName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['contactPerson'] = this.contactPerson;
    data['rcNumber'] = this.rcNumber;
    data['taxIdentityNumber'] = this.taxIdentityNumber;
    data['officeAddress'] = this.officeAddress;
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    data['lga'] = this.lga;
    data['city'] = this.city;
    data['altPhoneNumber'] = this.altPhoneNumber;
    data['packages'] = this.packages;
    data['userId'] = this.userId;
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['createdOn'] = this.createdOn;
    data['modifiedOn'] = this.modifiedOn;
    data['actionTaken'] = this.actionTaken;
    return data;
  }
}
