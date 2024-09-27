import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:golden_eyes/models/product_model.dart';
import 'package:golden_eyes/providers/cart.dart';

import '../../constants.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.id,
    required this.product,
    required this.quantity,
  });
  final int id, quantity;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        bottom: defaultPadding / 4,
        top: defaultPadding / 4,
      ),
      child: ListTile(
        title: Text('$quantity x ${product.name}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .removeProduct(product);
          },
        ),
      ),
    );
  }
}
