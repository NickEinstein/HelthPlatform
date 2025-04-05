class StateModel {
  final String name;
  final int id;
  final List<String> cities;
  final List<LgaModel> locals;

  StateModel(
      {required this.name,
      required this.id,
      required this.cities,
      required this.locals});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      name: json['state']['name'],
      id: json['state']['id'],
      cities: List<String>.from(json['state']['cities']),
      locals: (json['state']['locals'] as List)
          .map((lga) => LgaModel.fromJson(lga))
          .toList(),
    );
  }
}

class LgaModel {
  final String name;
  final int id;

  LgaModel({required this.name, required this.id});

  factory LgaModel.fromJson(Map<String, dynamic> json) {
    return LgaModel(
      name: json['name'],
      id: json['id'],
    );
  }
}
