class CategoryResponse {
  final int id;
  final String name;
  final String description;

  CategoryResponse(
      {required this.id, required this.name, required this.description});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
