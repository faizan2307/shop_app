import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});
  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavourite(String? token,String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    // final url =
    //     Uri.https('shop-app-b3141-default-rtdb.firebaseio.com', 'products/$id.json?auth=$token');
     var url = Uri.parse(
        'https://shop-app-b3141-default-rtdb.firebaseio.com/userFavourite/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavourite),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
        _setFavValue(oldStatus);
      
    }
  }
}
