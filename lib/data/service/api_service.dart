// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _list = 'list';
  static final String _detail = 'detail/';
  static final String _search = 'search?q=';
  static final String _review = 'review';
  final http.Client client;

  ApiService({required this.client});

  Future<Restaurant> getData() async {
    final response = await client.get(
      Uri.parse(_baseUrl + _list),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetail> getDetail(String id) async {
    final String _detailUrl = _baseUrl + _detail + id;
    final response = await client.get(
      Uri.parse(_detailUrl),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantSearch> getSearch(String query) async {
    final String _searchUrl = _baseUrl + _search + query;
    final response = await client.get(Uri.parse(_searchUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search data');
    }
  }

  Future<CustomerReview> addReview(
      String id, String name, String review) async {
    final String _reviewUrl = _baseUrl + _review;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
        _reviewUrl,
      ),
    );
    request.body = json.encode({"id": id, "name": name, "review": review});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      var tanggal = DateTime.now();
      return CustomerReview(
          name: name, review: review, date: tanggal.toIso8601String());
    } else {
      throw Exception('Data tidak berhasil ditambah');
    }
  }
}
