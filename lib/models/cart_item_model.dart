import 'package:my_windows_app/models/product_model.dart';

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
