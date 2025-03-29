class ArticleResponse {
  final int id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final String featuredImagePath;
  final String slug;
  final String publishedDate;
  final Category category;

  ArticleResponse({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.featuredImagePath,
    required this.slug,
    required this.publishedDate,
    required this.category,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      id: json['id'],
      title: json['title'],
      shortDescription: json['shortDescription'],
      fullDescription: json['fullDescription'],
      featuredImagePath: json['featuredImagePath'],
      slug: json['slug'],
      publishedDate: json['publishedDate'],
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'featuredImagePath': featuredImagePath,
      'slug': slug,
      'publishedDate': publishedDate,
      'category': category.toJson(),
    };
  }
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({required this.id, required this.name, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
