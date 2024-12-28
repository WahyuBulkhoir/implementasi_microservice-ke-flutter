import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewProvider with ChangeNotifier {
  List<Map<String, dynamic>> _reviews = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get reviews => _reviews;
  bool get isLoading => _isLoading;

  Future<void> fetchReviews(int productId) async {
    if (_isLoading) {
      print('Already fetching reviews, skipping...');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      print('Fetching reviews for product ID: $productId...');
      final response = await http.get(
        Uri.parse('http://192.168.76.68:3003/products/$productId/reviews'),
      );

      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['data'] != null) {
          _reviews = List<Map<String, dynamic>>.from(data['data']);
          print('Reviews loaded: ${_reviews.length} items');
        } else {
          _reviews = [];
          print('Response data is empty or invalid');
        }
      } else {
        _reviews = [];
        print('Failed to load reviews: ${response.statusCode}');
      }
    } catch (error) {
      _reviews = [];
      print('Error occurred while fetching reviews: $error');
    } finally {
      _isLoading = false;
      print('Fetching completed');
      notifyListeners();
    }
  }
}
