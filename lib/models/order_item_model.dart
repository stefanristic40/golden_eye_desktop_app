import 'package:golden_eyes/models/product_model.dart';

class OrderItemModel {
  final int id;
  int quantity;
  final ProductModel product;

  OrderItemModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      quantity: json['quantity'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
