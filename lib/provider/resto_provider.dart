import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoInternet }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchAllResto();
  }
  Restaurant? _restaurant;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  Restaurant? get result => _restaurant;
  ResultState? get state => _state;

  Future<dynamic> _fetchAllResto() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getData();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } on SocketException {
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    } catch (e) {
      _state = ResultState.HasData;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
