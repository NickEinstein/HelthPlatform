class BillingResponse {
  int? id;
  int? patientId;
  int? treatmentId;
  String? patient;
  String? diagnosis;
  int? totalCost;
  int? totalHMOCover;
  int? patientTotalBalance;
  int? hmoTotalBalance;
  int? patientTotalDuePay;
  int? hmoTotalDuePay;
  int? patientTotalDeposit;
  int? hmoTotalDeposit;
  String? visitStartedOn;
  String? visitEndedOn;
  int? healthCareProviderId;
  bool? hasHmo;
  List<PaymentBreakdowns>? paymentBreakdowns;

  BillingResponse(
      {this.id,
      this.patientId,
      this.treatmentId,
      this.patient,
      this.diagnosis,
      this.totalCost,
      this.totalHMOCover,
      this.patientTotalBalance,
      this.hmoTotalBalance,
      this.patientTotalDuePay,
      this.hmoTotalDuePay,
      this.patientTotalDeposit,
      this.hmoTotalDeposit,
      this.visitStartedOn,
      this.visitEndedOn,
      this.healthCareProviderId,
      this.hasHmo,
      this.paymentBreakdowns});

  BillingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    patient = json['patient'];
    diagnosis = json['diagnosis'];
    totalCost = json['totalCost'];
    totalHMOCover = json['totalHMOCover'];
    patientTotalBalance = json['patientTotalBalance'];
    hmoTotalBalance = json['hmoTotalBalance'];
    patientTotalDuePay = json['patientTotalDuePay'];
    hmoTotalDuePay = json['hmoTotalDuePay'];
    patientTotalDeposit = json['patientTotalDeposit'];
    hmoTotalDeposit = json['hmoTotalDeposit'];
    visitStartedOn = json['visitStartedOn'];
    visitEndedOn = json['visitEndedOn'];
    healthCareProviderId = json['healthCareProviderId'];
    hasHmo = json['hasHmo'];
    if (json['paymentBreakdowns'] != null) {
      paymentBreakdowns = <PaymentBreakdowns>[];
      json['paymentBreakdowns'].forEach((v) {
        paymentBreakdowns!.add(PaymentBreakdowns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patientId'] = patientId;
    data['treatmentId'] = treatmentId;
    data['patient'] = patient;
    data['diagnosis'] = diagnosis;
    data['totalCost'] = totalCost;
    data['totalHMOCover'] = totalHMOCover;
    data['patientTotalBalance'] = patientTotalBalance;
    data['hmoTotalBalance'] = hmoTotalBalance;
    data['patientTotalDuePay'] = patientTotalDuePay;
    data['hmoTotalDuePay'] = hmoTotalDuePay;
    data['patientTotalDeposit'] = patientTotalDeposit;
    data['hmoTotalDeposit'] = hmoTotalDeposit;
    data['visitStartedOn'] = visitStartedOn;
    data['visitEndedOn'] = visitEndedOn;
    data['healthCareProviderId'] = healthCareProviderId;
    data['hasHmo'] = hasHmo;
    if (paymentBreakdowns != null) {
      data['paymentBreakdowns'] =
          paymentBreakdowns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentBreakdowns {
  int? id;
  int? hmoId;
  String? medId;
  int? categoryId;
  int? cost;
  int? hmoCover;
  int? duePay;
  int? patientPaymentId;
  int? patientId;
  int? packageBenefitId;
  int? healthCareProviderId;
  int? serviceOrProductId;
  String? productName;
  int? hmoDuePay;
  int? patientDeposit;
  int? hmoDeposit;
  int? patientBalance;
  int? hmoBalance;
  String? status;
  bool? isPharmacy;
  int? hmoPackageId;
  bool? isCategoryItem;
  bool? isBed;
  bool? isEquipment;

  PaymentBreakdowns(
      {this.id,
      this.hmoId,
      this.medId,
      this.categoryId,
      this.cost,
      this.hmoCover,
      this.duePay,
      this.patientPaymentId,
      this.patientId,
      this.packageBenefitId,
      this.healthCareProviderId,
      this.serviceOrProductId,
      this.productName,
      this.hmoDuePay,
      this.patientDeposit,
      this.hmoDeposit,
      this.patientBalance,
      this.hmoBalance,
      this.status,
      this.isPharmacy,
      this.hmoPackageId,
      this.isCategoryItem,
      this.isBed,
      this.isEquipment});

  PaymentBreakdowns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hmoId = json['hmoId'];
    medId = json['medId'];
    categoryId = json['categoryId'];
    cost = json['cost'];
    hmoCover = json['hmoCover'];
    duePay = json['duePay'];
    patientPaymentId = json['patientPaymentId'];
    patientId = json['patientId'];
    packageBenefitId = json['packageBenefitId'];
    healthCareProviderId = json['healthCareProviderId'];
    serviceOrProductId = json['serviceOrProductId'];
    productName = json['productName'];
    hmoDuePay = json['hmoDuePay'];
    patientDeposit = json['patientDeposit'];
    hmoDeposit = json['hmoDeposit'];
    patientBalance = json['patientBalance'];
    hmoBalance = json['hmoBalance'];
    status = json['status'];
    isPharmacy = json['isPharmacy'];
    hmoPackageId = json['hmoPackageId'];
    isCategoryItem = json['isCategoryItem'];
    isBed = json['isBed'];
    isEquipment = json['isEquipment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hmoId'] = hmoId;
    data['medId'] = medId;
    data['categoryId'] = categoryId;
    data['cost'] = cost;
    data['hmoCover'] = hmoCover;
    data['duePay'] = duePay;
    data['patientPaymentId'] = patientPaymentId;
    data['patientId'] = patientId;
    data['packageBenefitId'] = packageBenefitId;
    data['healthCareProviderId'] = healthCareProviderId;
    data['serviceOrProductId'] = serviceOrProductId;
    data['productName'] = productName;
    data['hmoDuePay'] = hmoDuePay;
    data['patientDeposit'] = patientDeposit;
    data['hmoDeposit'] = hmoDeposit;
    data['patientBalance'] = patientBalance;
    data['hmoBalance'] = hmoBalance;
    data['status'] = status;
    data['isPharmacy'] = isPharmacy;
    data['hmoPackageId'] = hmoPackageId;
    data['isCategoryItem'] = isCategoryItem;
    data['isBed'] = isBed;
    data['isEquipment'] = isEquipment;
    return data;
  }
}
