import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/common/background_services.dart';
import 'package:restaurant_app/common/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduled Resto Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          Duration(seconds: 24), 1, BackgroundService.callback,
          startAt: DateTime.now(), exact: true, wakeup: true);
    } else {
      print('schedulling Resto Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
