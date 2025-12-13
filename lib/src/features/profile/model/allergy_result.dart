class AllergyResult {
  final String allergyName;

  const AllergyResult({required this.allergyName});

  factory AllergyResult.fromJson(Map<String, dynamic> json) => AllergyResult(
        allergyName: json['allergyName'],
      );
}
