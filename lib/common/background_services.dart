import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_app/common/notification_helper.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm menyala');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getData();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);
    // di 12
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('update data from the background isolate');
  }
}
