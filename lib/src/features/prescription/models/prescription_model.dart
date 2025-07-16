class PrescriptionByPatientResponse {
  int? id;
  Patient? patient;
  bool? hasHmo;
  GeneralMedicine? generalMedicine;
  PharmacyInventory? pharmacyInventory;
  int? quantity;
  int? frequency;
  int? duration;
  bool? composite;
  int? totalToDispense;
  String? medId;
  int? hmoProviderId;
  int? hmoPackageId;
  int? packageBenefitId;
  int? cost;
  int? hmoCover;
  int? patientDuePay;
  int? hmoDuePay;
  int? patientDeposit;
  int? hmoDeposit;
  int? patientBalance;
  int? hmoBalance;
  int? categoryId;
  bool? isDispensed;
  String? dispensedDate;
  String? paymentDate;
  DispensedDoneBy? dispensedDoneBy;
  bool? isPaid;
  DispensedDoneBy? cashier;
  DispensedDoneBy? recordQueuedInBy;
  String? queuedInDate;
  String? pharmacistNote;
  int? pharmacyHealthCareProviderId;
  Treatment? treatment;
  int? healthCareProviderId;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? createdBy;
  int? modifiedBy;
  String? actionTaken;

  PrescriptionByPatientResponse(
      {this.id,
      this.patient,
      this.hasHmo,
      this.generalMedicine,
      this.pharmacyInventory,
      this.quantity,
      this.frequency,
      this.duration,
      this.composite,
      this.totalToDispense,
      this.medId,
      this.hmoProviderId,
      this.hmoPackageId,
      this.packageBenefitId,
      this.cost,
      this.hmoCover,
      this.patientDuePay,
      this.hmoDuePay,
      this.patientDeposit,
      this.hmoDeposit,
      this.patientBalance,
      this.hmoBalance,
      this.categoryId,
      this.isDispensed,
      this.dispensedDate,
      this.paymentDate,
      this.dispensedDoneBy,
      this.isPaid,
      this.cashier,
      this.recordQueuedInBy,
      this.queuedInDate,
      this.pharmacistNote,
      this.pharmacyHealthCareProviderId,
      this.treatment,
      this.healthCareProviderId,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.createdBy,
      this.modifiedBy,
      this.actionTaken});

  PrescriptionByPatientResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    hasHmo = json['hasHmo'];
    generalMedicine = json['generalMedicine'] != null
        ? new GeneralMedicine.fromJson(json['generalMedicine'])
        : null;
    pharmacyInventory = json['pharmacyInventory'] != null
        ? new PharmacyInventory.fromJson(json['pharmacyInventory'])
        : null;
    quantity = json['quantity'];
    frequency = json['frequency'];
    duration = json['duration'];
    composite = json['composite'];
    totalToDispense = json['totalToDispense'];
    medId = json['medId'];
    hmoProviderId = json['hmoProviderId'];
    hmoPackageId = json['hmoPackageId'];
    packageBenefitId = json['packageBenefitId'];
    cost = json['cost'];
    hmoCover = json['hmoCover'];
    patientDuePay = json['patientDuePay'];
    hmoDuePay = json['hmoDuePay'];
    patientDeposit = json['patientDeposit'];
    hmoDeposit = json['hmoDeposit'];
    patientBalance = json['patientBalance'];
    hmoBalance = json['hmoBalance'];
    categoryId = json['categoryId'];
    isDispensed = json['isDispensed'];
    dispensedDate = json['dispensedDate'];
    paymentDate = json['paymentDate'];
    dispensedDoneBy = json['dispensedDoneBy'] != null
        ? new DispensedDoneBy.fromJson(json['dispensedDoneBy'])
        : null;
    isPaid = json['isPaid'];
    cashier = json['cashier'] != null
        ? new DispensedDoneBy.fromJson(json['cashier'])
        : null;
    recordQueuedInBy = json['recordQueuedInBy'] != null
        ? new DispensedDoneBy.fromJson(json['recordQueuedInBy'])
        : null;
    queuedInDate = json['queuedInDate'];
    pharmacistNote = json['pharmacistNote'];
    pharmacyHealthCareProviderId = json['pharmacyHealthCareProviderId'];
    treatment = json['treatment'] != null
        ? new Treatment.fromJson(json['treatment'])
        : null;
    healthCareProviderId = json['healthCareProviderId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
    actionTaken = json['actionTaken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['hasHmo'] = this.hasHmo;
    if (this.generalMedicine != null) {
      data['generalMedicine'] = this.generalMedicine!.toJson();
    }
    if (this.pharmacyInventory != null) {
      data['pharmacyInventory'] = this.pharmacyInventory!.toJson();
    }
    data['quantity'] = this.quantity;
    data['frequency'] = this.frequency;
    data['duration'] = this.duration;
    data['composite'] = this.composite;
    data['totalToDispense'] = this.totalToDispense;
    data['medId'] = this.medId;
    data['hmoProviderId'] = this.hmoProviderId;
    data['hmoPackageId'] = this.hmoPackageId;
    data['packageBenefitId'] = this.packageBenefitId;
    data['cost'] = this.cost;
    data['hmoCover'] = this.hmoCover;
    data['patientDuePay'] = this.patientDuePay;
    data['hmoDuePay'] = this.hmoDuePay;
    data['patientDeposit'] = this.patientDeposit;
    data['hmoDeposit'] = this.hmoDeposit;
    data['patientBalance'] = this.patientBalance;
    data['hmoBalance'] = this.hmoBalance;
    data['categoryId'] = this.categoryId;
    data['isDispensed'] = this.isDispensed;
    data['dispensedDate'] = this.dispensedDate;
    data['paymentDate'] = this.paymentDate;
    if (this.dispensedDoneBy != null) {
      data['dispensedDoneBy'] = this.dispensedDoneBy!.toJson();
    }
    data['isPaid'] = this.isPaid;
    if (this.cashier != null) {
      data['cashier'] = this.cashier!.toJson();
    }
    if (this.recordQueuedInBy != null) {
      data['recordQueuedInBy'] = this.recordQueuedInBy!.toJson();
    }
    data['queuedInDate'] = this.queuedInDate;
    data['pharmacistNote'] = this.pharmacistNote;
    data['pharmacyHealthCareProviderId'] = this.pharmacyHealthCareProviderId;
    if (this.treatment != null) {
      data['treatment'] = this.treatment!.toJson();
    }
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    data['actionTaken'] = this.actionTaken;
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

class GeneralMedicine {
  int? id;
  String? name;

  GeneralMedicine({this.id, this.name});

  GeneralMedicine.fromJson(Map<String, dynamic> json) {
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

class PharmacyInventory {
  int? id;
  int? categoryId;
  String? productName;
  int? sellingPrice;

  PharmacyInventory(
      {this.id, this.categoryId, this.productName, this.sellingPrice});

  PharmacyInventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    productName = json['productName'];
    sellingPrice = json['sellingPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['productName'] = this.productName;
    data['sellingPrice'] = this.sellingPrice;
    return data;
  }
}

class DispensedDoneBy {
  int? id;
  String? firstName;
  String? lastName;

  DispensedDoneBy({this.id, this.firstName, this.lastName});

  DispensedDoneBy.fromJson(Map<String, dynamic> json) {
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

class Treatment {
  int? id;
  String? diagnosis;
  int? treatmentStatus;
  String? additionalNote;
  int? treatmentCategoryId;
  bool? isAdmitted;
  DispensedDoneBy? doctor;
  String? carePlan;

  Treatment(
      {this.id,
      this.diagnosis,
      this.treatmentStatus,
      this.additionalNote,
      this.treatmentCategoryId,
      this.isAdmitted,
      this.doctor,
      this.carePlan});

  Treatment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosis = json['diagnosis'];
    treatmentStatus = json['treatmentStatus'];
    additionalNote = json['additionalNote'];
    treatmentCategoryId = json['treatmentCategoryId'];
    isAdmitted = json['isAdmitted'];
    doctor = json['doctor'] != null
        ? new DispensedDoneBy.fromJson(json['doctor'])
        : null;
    carePlan = json['carePlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diagnosis'] = this.diagnosis;
    data['treatmentStatus'] = this.treatmentStatus;
    data['additionalNote'] = this.additionalNote;
    data['treatmentCategoryId'] = this.treatmentCategoryId;
    data['isAdmitted'] = this.isAdmitted;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    data['carePlan'] = this.carePlan;
    return data;
  }
}
