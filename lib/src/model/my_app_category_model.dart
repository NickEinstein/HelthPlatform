class MyAppCategoryModel {
  final int id;
  final String name;
  final String description;
  final String iconUrl;

  MyAppCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
  });

  factory MyAppCategoryModel.fromJson(Map<String, dynamic> json) {
    return MyAppCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['iconUrl'],
    );
  }
}