class CategoryModel {
  final int id;
  final int? parent_id;
  final String slug;
  final String name;

  CategoryModel({
    required this.id,
    this.parent_id,
    required this.slug,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      parent_id: json['parent_id'],
      slug: json['slug'],
      name: json['name'],
    );
  }
}
