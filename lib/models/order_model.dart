import 'package:my_windows_app/models/customer_model.dart';
import 'package:my_windows_app/models/order_item_model.dart';
import 'package:intl/intl.dart';

class OrderModel {
  final int id;
  final CustomerModel customer;
  final List<OrderItemModel> items;
  final double total;
  final DateTime created_at;

  OrderModel({
    required this.id,
    required this.customer,
    required this.items,
    required this.total,
    required this.created_at,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      customer: CustomerModel.fromJson(json['customer']),
      items: (json['items'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      created_at: DateTime.parse(json['created_at']),
      total: double.parse(json['total']), // Convert to double
    );
  }

  // Method to get the date in Swedish format
  String getFormattedDate() {
    final DateFormat swedishFormat = DateFormat('yyyy-MM-dd HH:mm');
    return swedishFormat.format(created_at);
  }
}
