import 'package:flutter/material.dart';
import 'package:golden_eyes/models/cart_item_model.dart';
import 'package:golden_eyes/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:golden_eyes/constants.dart';
import 'package:golden_eyes/models/customer_model.dart';

class CartProvider with ChangeNotifier {
  List<CartItemModel> _items = [];
  List<ProductModel> _products = [];
  List<CustomerModel> _customers = [];

  CustomerModel _selectedCustomer =
      CustomerModel(id: 0, first_name: '', last_name: '', tags: []);

  List get items => _items;
  List get products => _products;
  List get customers => _customers;
  CustomerModel get selectedCustomer => _selectedCustomer;

  CartProvider() {
    // print("fetch data");
    // fetchProducts();
  }

  //  Fetch customers from API
  void fetchCustomers() async {
    final response = await http.get(Uri.parse('$backendUrl/customers'));

    if (response.statusCode == 201) {
      List<dynamic> body = json.decode(response.body);
      List<CustomerModel> customers =
          body.map((dynamic item) => CustomerModel.fromJson(item)).toList();

      _customers = customers;
    } else {
      throw Exception('Failed to load customers');
    }
    notifyListeners();
  }

  //  Fetch customers from API
  void fetchProducts() async {
    final response = await http.get(Uri.parse('$backendUrl/products'));

    if (response.statusCode == 201) {
      List<dynamic> body = json.decode(response.body);
      List<ProductModel> products =
          body.map((dynamic item) => ProductModel.fromJson(item)).toList();

      _products = products;
    } else {
      throw Exception('Failed to load customers');
    }
    notifyListeners();
  }

  void addProduct(ProductModel product) {
    final productIndex = _items.indexWhere((item) => item.id == product.id);
    if (productIndex >= 0) {
      _items[productIndex].quantity += 1;
    } else {
      _items.add(
        CartItemModel(
          id: product.id,
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    _items.removeWhere((item) => item.id == product.id);

    notifyListeners();
  }

  // Clear the cart
  void clearCart() {
    _items = [];
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((product) {
      total += product.product.price * product.quantity;
    });
    return total;
  }

  // Delete customer
  void deleteCustomer(int id) async {
    final response = await http.delete(Uri.parse('$backendUrl/customers/$id'));

    if (response.statusCode == 200) {
      print('Customer deleted');

      // remove customer from list
      _customers.removeWhere((customer) => customer.id == id);

      notifyListeners();
    } else {
      throw Exception('Failed to delete customer');
    }
  }

  // Set selected customer
  void setSelectedCustomer(CustomerModel customer) {
    print('setSelectedCustomer: ${customer.id}');
    _selectedCustomer = customer;
    notifyListeners();
  }
}
