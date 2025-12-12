 import 'dart:convert';

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
        id: json['id'],
        vaccine: json['vaccine'],
        vaccineBrand: json['vaccineBrand'],
        batchId: json['batchId'],
        quantity: json['quantity'],
        age: json['age'],
        weight: (json['weight'] as num?)?.toDouble(),
        temperature: (json['temperature'] as num?)?.toDouble(),
        dateGiven:
            json['dateGiven'] == null ? null : DateTime.tryParse(json['dateGiven']),
        notes: json['notes'],
        patientId: json['patientId'],
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
      };
}