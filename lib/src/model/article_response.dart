class ArticleResponse {
  int? id;
  String? title;
  String? shortDescription;
  String? fullDescription;
  String? featuredImagePath;
  String? slug;
  String? publishedDate;
  String? lastUpdatedDate;
  bool? isPublished;
  bool? isFeatured;
  int? categoryId;
  Category? category;

  ArticleResponse(
      {this.id,
      this.title,
      this.shortDescription,
      this.fullDescription,
      this.featuredImagePath,
      this.slug,
      this.publishedDate,
      this.lastUpdatedDate,
      this.isPublished,
      this.isFeatured,
      this.categoryId,
      this.category});

  ArticleResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    fullDescription = json['fullDescription'];
    featuredImagePath = json['featuredImagePath'];
    slug = json['slug'];
    publishedDate = json['publishedDate'];
    lastUpdatedDate = json['lastUpdatedDate'];
    isPublished = json['isPublished'];
    isFeatured = json['isFeatured'];
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    data['fullDescription'] = fullDescription;
    data['featuredImagePath'] = featuredImagePath;
    data['slug'] = slug;
    data['publishedDate'] = publishedDate;
    data['lastUpdatedDate'] = lastUpdatedDate;
    data['isPublished'] = isPublished;
    data['isFeatured'] = isFeatured;
    data['categoryId'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;

  Category({this.id, this.name, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
