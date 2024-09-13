import 'package:flutter/material.dart';
import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/models/customer_model.dart';
import 'package:my_windows_app/models/order_item_model.dart';
import 'package:my_windows_app/models/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.customer,
      required this.items,
      required this.total,
      required this.press,
      required this.id,
      required this.created_at});

  final int id;
  final double total;
  final CustomerModel customer;
  final List<OrderItemModel> items;
  final VoidCallback press;
  final DateTime created_at;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 30,
            color: const Color(0xFFB7B7B7).withOpacity(0.16),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bestelling $id',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                '$total kr',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Items list
          Column(
            children: items
                .map((item) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${item.quantity} x ${item.product.name} ',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' ${(item.product.price * item.quantity).toStringAsFixed(2)} kr',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          // Creatd A
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              OrderModel(
                      id: id,
                      customer: customer,
                      items: items,
                      total: total,
                      created_at: created_at)
                  .getFormattedDate(),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
