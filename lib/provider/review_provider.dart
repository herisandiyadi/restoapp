import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReviewProvider extends ChangeNotifier {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _review = 'review';
  Map<String, dynamic> _data = {};
  Map<String, dynamic> get data => _data;

  void postReview(String id, String name, String review) async {
    final String _reviewUrl = _baseUrl + _review;
    final response =
        await http.post(Uri.parse(_reviewUrl), headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'id': id,
      'name': name,
      'review': review,
    });

    _data = json.decode(response.body);
  }
}
