class SpecialistModel {
  final int id;
  final String name;
  final String description;

  SpecialistModel({required this.id, required this.name, required this.description});

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}