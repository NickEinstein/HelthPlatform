class UpdatePatientPayload {
  final String firstName;
  final String lastName;
  final String gender;
  final double? weight;
  final DateTime? dateOfBirth;
  final String pictureUrl;
  final String nin;
  final String stateOfOrigin;
  final String lga;
  final String placeOfBirth;
  final String maritalStatus;
  final String nationality;
  final String phoneNumber;

  const UpdatePatientPayload({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.weight,
    required this.dateOfBirth,
    required this.pictureUrl,
    required this.nin,
    required this.stateOfOrigin,
    required this.lga,
    required this.placeOfBirth,
    required this.maritalStatus,
    required this.nationality,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        if(weight != null)
        "weight": weight,
        if(dateOfBirth != null)
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "pictureUrl": pictureUrl,
        "nin": nin,
        "stateOfOrigin": stateOfOrigin, 
        "lga": lga,
        "placeOfBirth": lga,
        "maritalStatus": maritalStatus,
        "nationality": nationality
      };
}
