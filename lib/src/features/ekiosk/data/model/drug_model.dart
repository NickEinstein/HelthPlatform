// {
//                 "id": 1081,
//                 "name": "Acetaminophane (Paracetamol) - [Serum]",
//                 "description": "Acetaminophane (Paracetamol) - [Serum]",
//                 "cost": 4493,
//                 "clinicId": 24,
//                 "clinicName": "Health Fountain Hospital",
//                 "clinicLocation": "77 NTA/Uniport Road",
//                 "phoneNumber": "",
//                 "email": "",
//                 "rating": 1,
//                 "logoPath": "",
//                 "clinicContactPerson": "",
//                 "clinicContactDesignation": "",
//                 "clinicContactPhoneNumber": "",
//                 "clinicContactEmail": ""
//             }
class DrugModel {
  final int id;
  final String name;
  final String description;
  final int cost;
  final int clinicId;
  final String clinicName;
  final String clinicLocation;
  final String phoneNumber;
  final String email;
  final int rating;
  final String logoPath;
  final String clinicContactPerson;
  final String clinicContactDesignation;
  final String clinicContactPhoneNumber;
  final String clinicContactEmail;

  const DrugModel({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.clinicId,
    required this.clinicName,
    required this.clinicLocation,
    required this.phoneNumber,
    required this.email,
    required this.rating,
    required this.logoPath,
    required this.clinicContactPerson,
    required this.clinicContactDesignation,
    required this.clinicContactPhoneNumber,
    required this.clinicContactEmail,
  });

  factory DrugModel.fromJson(Map<String, dynamic> json) {
    return DrugModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      cost: json['cost'] ?? 0,
      clinicId: json['clinicId'] ?? 0,
      clinicName: json['clinicName'] ?? '',
      clinicLocation: json['clinicLocation'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      rating: json['rating'] ?? 0,
      logoPath: json['logoPath'] ?? '',
      clinicContactPerson: json['clinicContactPerson'] ?? '',
      clinicContactDesignation: json['clinicContactDesignation'] ?? '',
      clinicContactPhoneNumber: json['clinicContactPhoneNumber'] ?? '',
      clinicContactEmail: json['clinicContactEmail'] ?? '',
    );
  }
}
