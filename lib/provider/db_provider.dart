import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/resto_favorite.dart';
import 'package:restaurant_app/data/service/database_helper.dart';

class DbProvider extends ChangeNotifier {
  List<RestoFavorite> _restoFavorite = [];
  late DatabaseHelper _dbHelper;

  List<RestoFavorite> get restoFavorite => _restoFavorite;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllData();
  }

  void _getAllData() async {
    _restoFavorite = await _dbHelper.getRestos();
    notifyListeners();
  }

  Future<void> addData(RestoFavorite restoFavorite) async {
    await _dbHelper.insertFavorite(restoFavorite);
    _getAllData();
  }

  void deleteFavorite(String id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllData();
    notifyListeners();
  }

  Future<RestoFavorite> getFavById(String id) async {
    return await _dbHelper.getFavById(id);
  }
}
