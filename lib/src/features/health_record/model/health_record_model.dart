class ImmunizationResponse {
  int? id;
  String? vaccine;
  String? vaccineBrand;
  String? batchId;
  double? quantity;
  int? age;
  double? weight;
  double? temperature;
  String? dateGiven;
  String? notes;
  int? patientId;

  ImmunizationResponse(
      {this.id,
      this.vaccine,
      this.vaccineBrand,
      this.batchId,
      this.quantity,
      this.age,
      this.weight,
      this.temperature,
      this.dateGiven,
      this.notes,
      this.patientId});

  ImmunizationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vaccine = json['vaccine'];
    vaccineBrand = json['vaccineBrand'];
    batchId = json['batchId'];
    quantity = json['quantity'];
    age = json['age'];
    weight = json['weight'];
    temperature = json['temperature'];
    dateGiven = json['dateGiven'];
    notes = json['notes'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vaccine'] = this.vaccine;
    data['vaccineBrand'] = this.vaccineBrand;
    data['batchId'] = this.batchId;
    data['quantity'] = this.quantity;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['temperature'] = this.temperature;
    data['dateGiven'] = this.dateGiven;
    data['notes'] = this.notes;
    data['patientId'] = this.patientId;
    return data;
  }
}

class MedicalRecordResponse {
  int? id;
  int? medicationId;
  String? diagnosis;
  int? temperature;
  String? age;
  int? weight;
  String? additionalNote;
  int? patientId;
  int? treatmentStatus;
  String? carePlan;
  int? treatmentCategoryId;
  int? doctorId;
  bool? isAdmitted;
  int? appointmentId;
  int? healthCareProviderId;
  String? dateOfVisit;
  String? doctorNote;
  String? pharmacistNote;
  String? appointmentDate;
  String? appointmentTime;
  String? medication;
  String? otherMedication;
  String? doctor;
  int? treatmentId;
  int? dispensedBy;
  bool? isDispensed;
  String? dispensedDate;
  String? patientName;
  String? initiatedHealthCareProvider;
  String? tracking;
  String? dispensedByName;
  List<Vitals>? vitals;

  MedicalRecordResponse({
    this.id,
    this.medicationId,
    this.diagnosis,
    this.temperature,
    this.age,
    this.weight,
    this.additionalNote,
    this.patientId,
    this.treatmentStatus,
    this.carePlan,
    this.treatmentCategoryId,
    this.doctorId,
    this.isAdmitted,
    this.appointmentId,
    this.healthCareProviderId,
    this.dateOfVisit,
    this.doctorNote,
    this.pharmacistNote,
    this.appointmentDate,
    this.appointmentTime,
    this.medication,
    this.otherMedication,
    this.doctor,
    this.treatmentId,
    this.dispensedBy,
    this.isDispensed,
    this.dispensedDate,
    this.patientName,
    this.initiatedHealthCareProvider,
    this.tracking,
    this.dispensedByName,
    this.vitals,
  });

  MedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicationId = json['medicationId'];
    diagnosis = json['diagnosis']?.toString();
    temperature = (json['temperature'] as num?)?.toInt();
    age = json['age']?.toString();
    weight = (json['weight'] as num?)?.toInt();
    additionalNote = json['additionalNote']?.toString();
    patientId = json['patientId'];
    treatmentStatus = json['treatmentStatus'];
    carePlan = json['carePlan']?.toString();
    treatmentCategoryId = json['treatmentCategoryId'];
    doctorId = json['doctorId'];
    isAdmitted = json['isAdmitted'];
    appointmentId = json['appointmentId'];
    healthCareProviderId = json['healthCareProviderId'];
    dateOfVisit = json['dateOfVisit']?.toString();
    doctorNote = json['doctorNote']?.toString();
    pharmacistNote = json['pharmacistNote']?.toString();
    appointmentDate = json['appointmentDate']?.toString();
    appointmentTime = json['appointmentTime']?.toString();
    medication = json['medication']?.toString();
    otherMedication = json['otherMedication']?.toString();
    doctor = json['doctor']?.toString();
    treatmentId = json['treatmentId'];
    dispensedBy = json['dispensedBy'];
    isDispensed = json['isDispensed'];
    dispensedDate = json['dispensedDate']?.toString();
    patientName = json['patientName']?.toString();
    initiatedHealthCareProvider =
        json['initiatedHealthCareProvider']?.toString();
    tracking = json['tracking']?.toString();
    dispensedByName = json['dispensedByName']?.toString();

    if (json['vitals'] != null) {
      vitals = <Vitals>[];
      json['vitals'].forEach((v) {
        vitals!.add(Vitals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['medicationId'] = medicationId;
    data['diagnosis'] = diagnosis;
    data['temperature'] = temperature;
    data['age'] = age;
    data['weight'] = weight;
    data['additionalNote'] = additionalNote;
    data['patientId'] = patientId;
    data['treatmentStatus'] = treatmentStatus;
    data['carePlan'] = carePlan;
    data['treatmentCategoryId'] = treatmentCategoryId;
    data['doctorId'] = doctorId;
    data['isAdmitted'] = isAdmitted;
    data['appointmentId'] = appointmentId;
    data['healthCareProviderId'] = healthCareProviderId;
    data['dateOfVisit'] = dateOfVisit;
    data['doctorNote'] = doctorNote;
    data['pharmacistNote'] = pharmacistNote;
    data['appointmentDate'] = appointmentDate;
    data['appointmentTime'] = appointmentTime;
    data['medication'] = medication;
    data['otherMedication'] = otherMedication;
    data['doctor'] = doctor;
    data['treatmentId'] = treatmentId;
    data['dispensedBy'] = dispensedBy;
    data['isDispensed'] = isDispensed;
    data['dispensedDate'] = dispensedDate;
    data['patientName'] = patientName;
    data['initiatedHealthCareProvider'] = initiatedHealthCareProvider;
    data['tracking'] = tracking;
    data['dispensedByName'] = dispensedByName;
    if (vitals != null) {
      data['vitals'] = vitals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vitals {
  final int? id;
  final String? dateOfVisit;
  final double? temperature;
  final String? bloodPressure;
  final int? heartPulse;
  final String? respiratory;
  final double? height;
  final double? weight;
  final int? vitalNurseId;
  final String? vitalNurse;
  final int? patientId;
  final int? appointmentId;
  final List<Notes>? notes;
  final List<VitalDocuments>? vitalDocuments;

  Vitals({
    this.id,
    this.dateOfVisit,
    this.temperature,
    this.bloodPressure,
    this.heartPulse,
    this.respiratory,
    this.height,
    this.weight,
    this.vitalNurseId,
    this.vitalNurse,
    this.patientId,
    this.appointmentId,
    this.notes,
    this.vitalDocuments,
  });

  factory Vitals.fromJson(Map<String, dynamic> json) {
    return Vitals(
      id: json['id'],
      dateOfVisit: json['dateOfVisit'],
      temperature: (json['temperature'] as num?)?.toDouble(),
      bloodPressure: json['bloodPressure'],
      heartPulse: json['heartPulse'],
      respiratory: json['respiratory'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      vitalNurseId: json['vitalNurseId'],
      vitalNurse: json['vitalNurse'],
      patientId: json['patientId'],
      appointmentId: json['appointmentId'],
      notes: (json['notes'] as List<dynamic>?)
          ?.map((n) => Notes.fromJson(n))
          .toList(),
      vitalDocuments: (json['vitalDocuments'] as List<dynamic>?)
          ?.map((d) => VitalDocuments.fromJson(d))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateOfVisit': dateOfVisit,
        'temperature': temperature,
        'bloodPressure': bloodPressure,
        'heartPulse': heartPulse,
        'respiratory': respiratory,
        'height': height,
        'weight': weight,
        'vitalNurseId': vitalNurseId,
        'vitalNurse': vitalNurse,
        'patientId': patientId,
        'appointmentId': appointmentId,
        'notes': notes?.map((n) => n.toJson()).toList(),
        'vitalDocuments': vitalDocuments?.map((d) => d.toJson()).toList(),
      };
}

class Notes {
  int? id;
  String? createdAt;
  String? note;
  String? treatment;

  Notes({this.id, this.createdAt, this.note, this.treatment});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    note = json['note'];
    treatment = json['treatment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['note'] = this.note;
    data['treatment'] = this.treatment;
    return data;
  }
}

class VitalDocuments {
  int? id;
  String? docName;
  String? docPath;

  VitalDocuments({this.id, this.docName, this.docPath});

  VitalDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docName = json['docName'];
    docPath = json['docPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['docName'] = this.docName;
    data['docPath'] = this.docPath;
    return data;
  }
}

class PrescriptionByIDResponse {
  int? id;
  String? diagnosis;
  String? carePlan;
  String? dateOfVisit;
  String? doctorNote;
  String? pharmacistNote;
  String? appointDate;
  String? appointTime;
  String? medication;
  String? doctor;
  int? doctorId;
  int? treatmentId;
  int? dispensedBy;
  int? treatmentCategoryId;
  bool? isAdmitted;
  bool? isDispensed;
  String? dispensedDate;
  int? patientId;
  int? healthCareProviderId;
  String? patientName;
  String? healthCareProvider;
  String? tracking;
  String? dispensedByName;
  int? quantity; // updated from String? to int?
  String? medId;
  int? dosageId;
  int? pharmacyInventoryId;
  int? frequency; // updated from String? to int?
  int? duration; // updated from String? to int?
  int? totalToDispense;

  PrescriptionByIDResponse({
    this.id,
    this.diagnosis,
    this.carePlan,
    this.dateOfVisit,
    this.doctorNote,
    this.pharmacistNote,
    this.appointDate,
    this.appointTime,
    this.medication,
    this.doctor,
    this.doctorId,
    this.treatmentId,
    this.dispensedBy,
    this.treatmentCategoryId,
    this.isAdmitted,
    this.isDispensed,
    this.dispensedDate,
    this.patientId,
    this.healthCareProviderId,
    this.patientName,
    this.healthCareProvider,
    this.tracking,
    this.dispensedByName,
    this.quantity,
    this.medId,
    this.dosageId,
    this.pharmacyInventoryId,
    this.frequency,
    this.duration,
    this.totalToDispense,
  });

  PrescriptionByIDResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosis = json['diagnosis'];
    carePlan = json['carePlan'];
    dateOfVisit = json['dateOfVisit'];
    doctorNote = json['doctorNote'];
    pharmacistNote = json['pharmacistNote'];
    appointDate = json['appointDate'];
    appointTime = json['appointTime'];
    medication = json['medication'];
    doctor = json['doctor'];
    doctorId = json['doctorId'];
    treatmentId = json['treatmentId'];
    dispensedBy = json['dispensedBy'];
    treatmentCategoryId = json['treatmentCategoryId'];
    isAdmitted = json['isAdmitted'];
    isDispensed = json['isDispensed'];
    dispensedDate = json['dispensedDate'];
    patientId = json['patientId'];
    healthCareProviderId = json['healthCareProviderId'];
    patientName = json['patientName'];
    healthCareProvider = json['healthCareProvider'];
    tracking = json['tracking'];
    dispensedByName = json['dispensedByName'];
    quantity = json['quantity'];
    medId = json['medId'];
    dosageId = json['dosageId'];
    pharmacyInventoryId = json['pharmacyInventoryId'];
    frequency = json['frequency'];
    duration = json['duration'];
    totalToDispense = json['totalToDispense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diagnosis'] = diagnosis;
    data['carePlan'] = carePlan;
    data['dateOfVisit'] = dateOfVisit;
    data['doctorNote'] = doctorNote;
    data['pharmacistNote'] = pharmacistNote;
    data['appointDate'] = appointDate;
    data['appointTime'] = appointTime;
    data['medication'] = medication;
    data['doctor'] = doctor;
    data['doctorId'] = doctorId;
    data['treatmentId'] = treatmentId;
    data['dispensedBy'] = dispensedBy;
    data['treatmentCategoryId'] = treatmentCategoryId;
    data['isAdmitted'] = isAdmitted;
    data['isDispensed'] = isDispensed;
    data['dispensedDate'] = dispensedDate;
    data['patientId'] = patientId;
    data['healthCareProviderId'] = healthCareProviderId;
    data['patientName'] = patientName;
    data['healthCareProvider'] = healthCareProvider;
    data['tracking'] = tracking;
    data['dispensedByName'] = dispensedByName;
    data['quantity'] = quantity;
    data['medId'] = medId;
    data['dosageId'] = dosageId;
    data['pharmacyInventoryId'] = pharmacyInventoryId;
    data['frequency'] = frequency;
    data['duration'] = duration;
    data['totalToDispense'] = totalToDispense;
    return data;
  }
}
