import 'dart:convert';
import '../../../model/safe_json.dart';

ImmunizationResult immunizationResultFromJson(String str) =>
    ImmunizationResult.fromJson(json.decode(str));

String immunizationResultToJson(ImmunizationResult data) =>
    json.encode(data.toJson());

class ImmunizationResult {
  final int? id;
  final String? vaccine;
  final String? vaccineBrand;
  final String? batchId;
  final int? quantity;
  final int? age;
  final double? weight;
  final double? temperature;
  final DateTime? dateGiven;
  final String? notes;
  final int? patientId;

  const ImmunizationResult({
    this.id,
    this.vaccine,
    this.vaccineBrand,
    this.batchId,
    this.quantity,
    this.age,
    this.weight,
    this.temperature,
    this.dateGiven,
    this.notes,
    this.patientId,
  });

  factory ImmunizationResult.fromJson(Map<String, dynamic> json) =>
      ImmunizationResult(
        id: SafeJson.asInt(json['id']),
        vaccine: SafeJson.asString(json['vaccine']),
        vaccineBrand: SafeJson.asString(json['vaccineBrand']),
        batchId: SafeJson.asString(json['batchId']),
        quantity: SafeJson.asInt(json['quantity']),
        age: SafeJson.asInt(json['age']),
        weight: SafeJson.asDouble(json['weight']),
        temperature: SafeJson.asDouble(json['temperature']),
        dateGiven: json['dateGiven'] == null
            ? null
            : DateTime.tryParse(SafeJson.asString(json['dateGiven'])),
        notes: SafeJson.asString(json['notes']),
        patientId: SafeJson.asInt(json['patientId']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'vaccine': vaccine,
        'vaccineBrand': vaccineBrand,
        'batchId': batchId,
        'quantity': quantity,
        'age': age,
        'weight': weight,
        'temperature': temperature,
        'dateGiven': dateGiven?.toIso8601String(),
        'notes': notes,
        'patientId': patientId,
        'immunizationDocuments': [],
      };
}
