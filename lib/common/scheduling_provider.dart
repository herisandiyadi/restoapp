import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/background_services.dart';
import 'package:restaurant_app/common/date_time_helper.dart';
import 'package:restaurant_app/common/style.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value, BuildContext context) async {
    _isScheduled = value;
    if (_isScheduled) {
      var snackBar = SnackBar(
        backgroundColor: greenColor,
        duration: Duration(seconds: 1),
        content: Text(
          'Reminder diaktifkan',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      var snackBar = SnackBar(
        backgroundColor: redColor,
        duration: Duration(seconds: 1),
        content: Text(
          'Reminder dinonaktifkan',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
