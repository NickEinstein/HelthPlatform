// To parse this JSON data, do
//
//     final getPrescriptionModel = getPrescriptionModelFromJson(jsonString);

import 'dart:convert';

GetPrescriptionModel getPrescriptionModelFromJson(String str) =>
    GetPrescriptionModel.fromJson(json.decode(str));

String getPrescriptionModelToJson(GetPrescriptionModel data) =>
    json.encode(data.toJson());

class GetPrescriptionModel {
  final int? code;
  final String? status;
  final String? message;
  final List<Prescription>? data;

  GetPrescriptionModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  GetPrescriptionModel copyWith({
    int? code,
    String? status,
    String? message,
    List<Prescription>? data,
  }) =>
      GetPrescriptionModel(
        code: code ?? this.code,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetPrescriptionModel.fromJson(Map<String, dynamic> json) =>
      GetPrescriptionModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Prescription>.from(
                json["data"]!.map((x) => Prescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Prescription {
  final int? id;
  final String? diagnosis;
  final String? carePlan;
  final DateTime? dateOfVisit;
  final String? doctorNote;
  final String? pharmacistNote;
  final String? appointDate;
  final String? appointTime;
  final String? medication;
  final String? doctor;
  final int? doctorId;
  final int? treatmentId;
  final dynamic dispensedBy;
  final int? treatmentCategoryId;
  final bool? isAdmitted;
  final bool? isDispensed;
  final dynamic dispensedDate;
  final int? patientId;
  final int? clinicId;
  final String? patientName;
  final String? clinic;
  final String? tracking;
  final String? dispensedByName;
  final String? quantity;
  final String? medId;
  final dynamic dosageId;
  final int? pharmacyInventoryId;
  final String? frequency;
  final String? duration;
  final int? totalToDispense;

  Prescription({
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
    this.clinicId,
    this.patientName,
    this.clinic,
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

  Prescription copyWith({
    int? id,
    String? diagnosis,
    String? carePlan,
    DateTime? dateOfVisit,
    String? doctorNote,
    String? pharmacistNote,
    String? appointDate,
    String? appointTime,
    String? medication,
    String? doctor,
    int? doctorId,
    int? treatmentId,
    dynamic dispensedBy,
    int? treatmentCategoryId,
    bool? isAdmitted,
    bool? isDispensed,
    dynamic dispensedDate,
    int? patientId,
    int? clinicId,
    String? patientName,
    String? clinic,
    String? tracking,
    String? dispensedByName,
    String? quantity,
    String? medId,
    dynamic dosageId,
    int? pharmacyInventoryId,
    String? frequency,
    String? duration,
    int? totalToDispense,
  }) =>
      Prescription(
        id: id ?? this.id,
        diagnosis: diagnosis ?? this.diagnosis,
        carePlan: carePlan ?? this.carePlan,
        dateOfVisit: dateOfVisit ?? this.dateOfVisit,
        doctorNote: doctorNote ?? this.doctorNote,
        pharmacistNote: pharmacistNote ?? this.pharmacistNote,
        appointDate: appointDate ?? this.appointDate,
        appointTime: appointTime ?? this.appointTime,
        medication: medication ?? this.medication,
        doctor: doctor ?? this.doctor,
        doctorId: doctorId ?? this.doctorId,
        treatmentId: treatmentId ?? this.treatmentId,
        dispensedBy: dispensedBy ?? this.dispensedBy,
        treatmentCategoryId: treatmentCategoryId ?? this.treatmentCategoryId,
        isAdmitted: isAdmitted ?? this.isAdmitted,
        isDispensed: isDispensed ?? this.isDispensed,
        dispensedDate: dispensedDate ?? this.dispensedDate,
        patientId: patientId ?? this.patientId,
        clinicId: clinicId ?? this.clinicId,
        patientName: patientName ?? this.patientName,
        clinic: clinic ?? this.clinic,
        tracking: tracking ?? this.tracking,
        dispensedByName: dispensedByName ?? this.dispensedByName,
        quantity: quantity ?? this.quantity,
        medId: medId ?? this.medId,
        dosageId: dosageId ?? this.dosageId,
        pharmacyInventoryId: pharmacyInventoryId ?? this.pharmacyInventoryId,
        frequency: frequency ?? this.frequency,
        duration: duration ?? this.duration,
        totalToDispense: totalToDispense ?? this.totalToDispense,
      );

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["id"],
        diagnosis: json["diagnosis"],
        carePlan: json["carePlan"],
        dateOfVisit: json["dateOfVisit"] == null
            ? null
            : DateTime.parse(json["dateOfVisit"]),
        doctorNote: json["doctorNote"],
        pharmacistNote: json["pharmacistNote"],
        appointDate: json["appointDate"],
        appointTime: json["appointTime"],
        medication: json["medication"],
        doctor: json["doctor"],
        doctorId: json["doctorId"],
        treatmentId: json["treatmentId"],
        dispensedBy: json["dispensedBy"],
        treatmentCategoryId: json["treatmentCategoryId"],
        isAdmitted: json["isAdmitted"],
        isDispensed: json["isDispensed"],
        dispensedDate: json["dispensedDate"],
        patientId: json["patientId"],
        clinicId: json["clinicId"],
        patientName: json["patientName"],
        clinic: json["clinic"],
        tracking: json["tracking"],
        dispensedByName: json["dispensedByName"],
        quantity: json["quantity"],
        medId: json["medId"],
        dosageId: json["dosageId"],
        pharmacyInventoryId: json["pharmacyInventoryId"],
        frequency: json["frequency"],
        duration: json["duration"],
        totalToDispense: json["totalToDispense"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diagnosis": diagnosis,
        "carePlan": carePlan,
        "dateOfVisit": dateOfVisit?.toIso8601String(),
        "doctorNote": doctorNote,
        "pharmacistNote": pharmacistNote,
        "appointDate": appointDate,
        "appointTime": appointTime,
        "medication": medication,
        "doctor": doctor,
        "doctorId": doctorId,
        "treatmentId": treatmentId,
        "dispensedBy": dispensedBy,
        "treatmentCategoryId": treatmentCategoryId,
        "isAdmitted": isAdmitted,
        "isDispensed": isDispensed,
        "dispensedDate": dispensedDate,
        "patientId": patientId,
        "clinicId": clinicId,
        "patientName": patientName,
        "clinic": clinic,
        "tracking": tracking,
        "dispensedByName": dispensedByName,
        "quantity": quantity,
        "medId": medId,
        "dosageId": dosageId,
        "pharmacyInventoryId": pharmacyInventoryId,
        "frequency": frequency,
        "duration": duration,
        "totalToDispense": totalToDispense,
      };
}
