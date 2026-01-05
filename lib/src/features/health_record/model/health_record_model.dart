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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vaccine'] = vaccine;
    data['vaccineBrand'] = vaccineBrand;
    data['batchId'] = batchId;
    data['quantity'] = quantity;
    data['age'] = age;
    data['weight'] = weight;
    data['temperature'] = temperature;
    data['dateGiven'] = dateGiven;
    data['notes'] = notes;
    data['patientId'] = patientId;
    return data;
  }
}

class MedicalRecordResponse {
  final int id;
  final DateTime dateOfVisit;
  final double temperature;
  final String age;
  final double weight;
  final int treatmentCategoryId;
  final String diagnosis;
  final String? additonalNote;
  final String specialistType;
  final bool isAdmitted;
  final int userId;
  final int doctorId;
  final int? clinicId;
  final int patientId;
  final int appointmentId;
  final String bloodPressure;
  final int heartPulse;
  final String respiratory;
  final String oxygenSaturation;
  final String bloodSugar;
  final double height;
  final String doctor;
  final int? vitalNurseId;
  final String carePlan;
  final int quantity;
  final int frequency;
  final int duration;
  final String? pharmacistNote;
  final int otherMedicationsQuantity;
  final int otherMedicationsFrequency;
  final int otherMedicationsDuration;
  final String? otherMedicationsNote;
  final String? drugName;
  final List<Medication> medications;

  MedicalRecordResponse({
    required this.id,
    required this.dateOfVisit,
    required this.temperature,
    required this.age,
    required this.weight,
    required this.treatmentCategoryId,
    required this.diagnosis,
    this.additonalNote,
    required this.specialistType,
    required this.isAdmitted,
    required this.userId,
    required this.doctorId,
    this.clinicId,
    required this.patientId,
    required this.appointmentId,
    required this.bloodPressure,
    required this.heartPulse,
    required this.respiratory,
    required this.oxygenSaturation,
    required this.bloodSugar,
    required this.height,
    required this.doctor,
    this.vitalNurseId,
    required this.carePlan,
    required this.quantity,
    required this.frequency,
    required this.duration,
    this.pharmacistNote,
    required this.otherMedicationsQuantity,
    required this.otherMedicationsFrequency,
    required this.otherMedicationsDuration,
    this.otherMedicationsNote,
    this.drugName,
    required this.medications,
  });

  factory MedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    return MedicalRecordResponse(
      id: json['id'] ?? 0,
      dateOfVisit: DateTime.parse(json['dateOfVisit']),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      age: json['age'] ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      treatmentCategoryId: json['treatmentCategoryId'] ?? 0,
      diagnosis: json['diagnosis'] ?? '',
      additonalNote: json['additonalNote'],
      specialistType: json['specialistType'] ?? '',
      isAdmitted: json['isAdmitted'] ?? false,
      userId: json['userId'] ?? 0,
      doctorId: json['doctorId'] ?? 0,
      clinicId: json['clinicId'],
      patientId: json['patientId'] ?? 0,
      appointmentId: json['appointmentId'] ?? 0,
      bloodPressure: json['bloodPressure'] ?? '',
      heartPulse: json['heartPulse'] ?? 0,
      respiratory: json['respiratory'] ?? '',
      oxygenSaturation: json['oxygenSaturation'] ?? '',
      bloodSugar: json['bloodSugar'] ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      doctor: json['doctor'] ?? '',
      vitalNurseId: json['vitalNurseId'],
      carePlan: json['carePlan'] ?? '',
      quantity: json['quantity'] ?? 0,
      frequency: json['frequency'] ?? 0,
      duration: json['duration'] ?? 0,
      pharmacistNote: json['pharmacistNote'],
      otherMedicationsQuantity: json['otherMedicationsQuantity'] ?? 0,
      otherMedicationsFrequency: json['otherMedicationsFrequency'] ?? 0,
      otherMedicationsDuration: json['otherMedicationsDuration'] ?? 0,
      otherMedicationsNote: json['otherMedicationsNote'],
      drugName: json['drugName'],
      medications: (json['medications'] as List<dynamic>?)
              ?.map((e) => Medication.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateOfVisit': dateOfVisit.toIso8601String(),
      'temperature': temperature,
      'age': age,
      'weight': weight,
      'treatmentCategoryId': treatmentCategoryId,
      'diagnosis': diagnosis,
      'additonalNote': additonalNote,
      'specialistType': specialistType,
      'isAdmitted': isAdmitted,
      'userId': userId,
      'doctorId': doctorId,
      'clinicId': clinicId,
      'patientId': patientId,
      'appointmentId': appointmentId,
      'bloodPressure': bloodPressure,
      'heartPulse': heartPulse,
      'respiratory': respiratory,
      'oxygenSaturation': oxygenSaturation,
      'bloodSugar': bloodSugar,
      'height': height,
      'doctor': doctor,
      'vitalNurseId': vitalNurseId,
      'carePlan': carePlan,
      'quantity': quantity,
      'frequency': frequency,
      'duration': duration,
      'pharmacistNote': pharmacistNote,
      'otherMedicationsQuantity': otherMedicationsQuantity,
      'otherMedicationsFrequency': otherMedicationsFrequency,
      'otherMedicationsDuration': otherMedicationsDuration,
      'otherMedicationsNote': otherMedicationsNote,
      'drugName': drugName,
      'medications': medications.map((e) => e.toJson()).toList(),
    };
  }

  static List<MedicalRecordResponse> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => MedicalRecordResponse.fromJson(e)).toList();
  }
}

class Medication {
  final String drugName;
  final int drugStrengthUnit;
  final int quantity;
  final int frequency;
  final int duration;
  final String pharmacistNote;

  Medication({
    required this.drugName,
    required this.drugStrengthUnit,
    required this.quantity,
    required this.frequency,
    required this.duration,
    required this.pharmacistNote,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      drugName: json['drugName'] ?? '',
      drugStrengthUnit: json['drugStrengthUnit'] ?? 0,
      quantity: json['quantity'] ?? 0,
      frequency: json['frequency'] ?? 0,
      duration: json['duration'] ?? 0,
      pharmacistNote: json['pharmacistNote'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drugName': drugName,
      'drugStrengthUnit': drugStrengthUnit,
      'quantity': quantity,
      'frequency': frequency,
      'duration': duration,
      'pharmacistNote': pharmacistNote,
    };
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['note'] = note;
    data['treatment'] = treatment;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['docName'] = docName;
    data['docPath'] = docPath;
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
