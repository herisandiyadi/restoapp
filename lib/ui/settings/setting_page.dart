import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/background_services.dart';
import 'package:restaurant_app/common/scheduling_provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/dashboard_page.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _on = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          'Setting',
          style: darkTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => DashboardPage(
                    selectedPage: 0,
                  ),
                ),
                (route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: darkColor,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Reminder',
                          style: darkTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold),
                        ),
                        Text(
                          'Set reminder 11.00 AM',
                          style: darkTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                    value: _on,
                    onChanged: (bool value) {
                      setState(() {
                        if (_on == false) {
                          _on = value;
                          var snackBar = SnackBar(
                            backgroundColor: greenColor,
                            duration: Duration(seconds: 1),
                            content: Text(
                              'Reminder diaktifkan',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          AndroidAlarmManager.periodic(Duration(seconds: 15), 1,
                              BackgroundService.callback,
                              exact: true, wakeup: true);
                        } else {
                          _on = value;
                          var snackBar = SnackBar(
                            backgroundColor: redColor,
                            duration: Duration(seconds: 1),
                            content: Text(
                              'Reminder dinonaktifkan',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          AndroidAlarmManager.cancel(1);
                        }
                      });
                    }),
              ),
            ),
            Material(
              child: ListTile(
                title: Text('Scheduling Alarm'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, schedule, _) {
                    return Switch.adaptive(
                      value: schedule.isScheduled,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          schedule.scheduledNews(value);
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
