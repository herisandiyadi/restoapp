import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/service/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}) {
    _getDailiyNotifPreferences();
  }
  bool _isDailyNotif = false;
  bool get isDailyNotif => _isDailyNotif;

  void _getDailiyNotifPreferences() async {
    _isDailyNotif = await preferencesHelper.isDailyNotif;
    notifyListeners();
  }

  void enableDailyNotif(bool value) {
    preferencesHelper.setDailyNotif(value);
    _getDailiyNotifPreferences();
  }
}
