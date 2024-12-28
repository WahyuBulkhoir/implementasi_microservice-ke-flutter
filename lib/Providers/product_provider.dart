import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<dynamic> _products = [];
  bool _isLoading = true;

  List<dynamic> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.76.68:3000/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _products = data['data'];
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
