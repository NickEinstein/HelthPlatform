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
        paymentBreakdowns!.add(new PaymentBreakdowns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['treatmentId'] = this.treatmentId;
    data['patient'] = this.patient;
    data['diagnosis'] = this.diagnosis;
    data['totalCost'] = this.totalCost;
    data['totalHMOCover'] = this.totalHMOCover;
    data['patientTotalBalance'] = this.patientTotalBalance;
    data['hmoTotalBalance'] = this.hmoTotalBalance;
    data['patientTotalDuePay'] = this.patientTotalDuePay;
    data['hmoTotalDuePay'] = this.hmoTotalDuePay;
    data['patientTotalDeposit'] = this.patientTotalDeposit;
    data['hmoTotalDeposit'] = this.hmoTotalDeposit;
    data['visitStartedOn'] = this.visitStartedOn;
    data['visitEndedOn'] = this.visitEndedOn;
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['hasHmo'] = this.hasHmo;
    if (this.paymentBreakdowns != null) {
      data['paymentBreakdowns'] =
          this.paymentBreakdowns!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hmoId'] = this.hmoId;
    data['medId'] = this.medId;
    data['categoryId'] = this.categoryId;
    data['cost'] = this.cost;
    data['hmoCover'] = this.hmoCover;
    data['duePay'] = this.duePay;
    data['patientPaymentId'] = this.patientPaymentId;
    data['patientId'] = this.patientId;
    data['packageBenefitId'] = this.packageBenefitId;
    data['healthCareProviderId'] = this.healthCareProviderId;
    data['serviceOrProductId'] = this.serviceOrProductId;
    data['productName'] = this.productName;
    data['hmoDuePay'] = this.hmoDuePay;
    data['patientDeposit'] = this.patientDeposit;
    data['hmoDeposit'] = this.hmoDeposit;
    data['patientBalance'] = this.patientBalance;
    data['hmoBalance'] = this.hmoBalance;
    data['status'] = this.status;
    data['isPharmacy'] = this.isPharmacy;
    data['hmoPackageId'] = this.hmoPackageId;
    data['isCategoryItem'] = this.isCategoryItem;
    data['isBed'] = this.isBed;
    data['isEquipment'] = this.isEquipment;
    return data;
  }
}
