import 'package:golden_eyes/models/product_model.dart';

class CartItemModel {
  final int id;
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
  });
}
