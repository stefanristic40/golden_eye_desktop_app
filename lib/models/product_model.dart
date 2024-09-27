import 'package:golden_eyes/models/category_model.dart';

class ProductModel {
  final int id;
  final String thumbnail, name;
  final double price;
  final int? category_id;
  final CategoryModel category;
  final int sort;

  ProductModel({
    required this.id,
    required this.thumbnail,
    required this.name,
    required this.price,
    this.category_id,
    required this.category,
    required this.sort,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      price: double.parse(json['price']),
      category_id: json['category_id'],
      category: CategoryModel.fromJson(json['category']),
      sort: json['sort'],
    );
  }
}
