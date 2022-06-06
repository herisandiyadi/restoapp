import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { Loading, NoData, HasData, Error, NoInternet }

class RestoDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestoDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailResto(id);
  }
  late RestaurantDetail _restaurantDetail;
  late ResultState _detailstate;
  String _message = '';
  String get message => _message;
  RestaurantDetail get result => _restaurantDetail;
  ResultState get state => _detailstate;

  Future<dynamic> _fetchDetailResto(String id) async {
    try {
      _detailstate = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getDetail(id);
      if (result.restaurantDetails.id.isEmpty) {
        _detailstate = ResultState.NoData;
        _message = 'Detail Restaurant is empty';
        notifyListeners();
        return _message;
      } else {
        _detailstate = ResultState.HasData;
        _restaurantDetail = result;
        notifyListeners();
        return _restaurantDetail;
      }
    } on SocketException {
      _detailstate = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    } catch (e) {
      _detailstate = ResultState.HasData;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
