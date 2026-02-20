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
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    hasHmo = json['hasHmo'];
    generalMedicine = json['generalMedicine'] != null
        ? GeneralMedicine.fromJson(json['generalMedicine'])
        : null;
    pharmacyInventory = json['pharmacyInventory'] != null
        ? PharmacyInventory.fromJson(json['pharmacyInventory'])
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
        ? DispensedDoneBy.fromJson(json['dispensedDoneBy'])
        : null;
    isPaid = json['isPaid'];
    cashier = json['cashier'] != null
        ? DispensedDoneBy.fromJson(json['cashier'])
        : null;
    recordQueuedInBy = json['recordQueuedInBy'] != null
        ? DispensedDoneBy.fromJson(json['recordQueuedInBy'])
        : null;
    queuedInDate = json['queuedInDate'];
    pharmacistNote = json['pharmacistNote'];
    pharmacyHealthCareProviderId = json['pharmacyHealthCareProviderId'];
    treatment = json['treatment'] != null
        ? Treatment.fromJson(json['treatment'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    data['hasHmo'] = hasHmo;
    if (generalMedicine != null) {
      data['generalMedicine'] = generalMedicine!.toJson();
    }
    if (pharmacyInventory != null) {
      data['pharmacyInventory'] = pharmacyInventory!.toJson();
    }
    data['quantity'] = quantity;
    data['frequency'] = frequency;
    data['duration'] = duration;
    data['composite'] = composite;
    data['totalToDispense'] = totalToDispense;
    data['medId'] = medId;
    data['hmoProviderId'] = hmoProviderId;
    data['hmoPackageId'] = hmoPackageId;
    data['packageBenefitId'] = packageBenefitId;
    data['cost'] = cost;
    data['hmoCover'] = hmoCover;
    data['patientDuePay'] = patientDuePay;
    data['hmoDuePay'] = hmoDuePay;
    data['patientDeposit'] = patientDeposit;
    data['hmoDeposit'] = hmoDeposit;
    data['patientBalance'] = patientBalance;
    data['hmoBalance'] = hmoBalance;
    data['categoryId'] = categoryId;
    data['isDispensed'] = isDispensed;
    data['dispensedDate'] = dispensedDate;
    data['paymentDate'] = paymentDate;
    if (dispensedDoneBy != null) {
      data['dispensedDoneBy'] = dispensedDoneBy!.toJson();
    }
    data['isPaid'] = isPaid;
    if (cashier != null) {
      data['cashier'] = cashier!.toJson();
    }
    if (recordQueuedInBy != null) {
      data['recordQueuedInBy'] = recordQueuedInBy!.toJson();
    }
    data['queuedInDate'] = queuedInDate;
    data['pharmacistNote'] = pharmacistNote;
    data['pharmacyHealthCareProviderId'] = pharmacyHealthCareProviderId;
    if (treatment != null) {
      data['treatment'] = treatment!.toJson();
    }
    data['healthCareProviderId'] = healthCareProviderId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['status'] = status;
    data['createdBy'] = createdBy;
    data['modifiedBy'] = modifiedBy;
    data['actionTaken'] = actionTaken;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pictureUrl'] = pictureUrl;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['productName'] = productName;
    data['sellingPrice'] = sellingPrice;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
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
        ? DispensedDoneBy.fromJson(json['doctor'])
        : null;
    carePlan = json['carePlan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diagnosis'] = diagnosis;
    data['treatmentStatus'] = treatmentStatus;
    data['additionalNote'] = additionalNote;
    data['treatmentCategoryId'] = treatmentCategoryId;
    data['isAdmitted'] = isAdmitted;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['carePlan'] = carePlan;
    return data;
  }
}
