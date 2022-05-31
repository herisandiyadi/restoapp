import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

enum RestaurantState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchSearchRestaurant(query);
  }

  RestaurantSearch? _searchResto;
  RestaurantState? _restaurantState;
  String _message = '';
  String _query = '';

  String get message => _message;
  RestaurantSearch? get searchResto => _searchResto;
  String get query => _query;
  RestaurantState? get restaurantState => _restaurantState;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _restaurantState = RestaurantState.loading;
        _query = query;
        final searchRes = await apiService.getSearch(query);
        if (searchRes.restaurantSearchs.isEmpty) {
          _restaurantState = RestaurantState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _restaurantState = RestaurantState.hasData;
          notifyListeners();
          return _searchResto = searchRes;
        }
      }
    } catch (e) {
      _restaurantState = RestaurantState.error;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    }
  }
}
