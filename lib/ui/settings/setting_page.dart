import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              child: ListTile(
                title: Text(
                  'Daily Reminder',
                  style: darkTextStyle.copyWith(
                      fontSize: 18, fontWeight: semiBold),
                ),
                subtitle: Text(
                  'Set reminder 11.00 AM',
                  style: darkTextStyle.copyWith(fontSize: 12),
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, schedule, _) {
                    return Switch.adaptive(
                      value: schedule.isScheduled,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          schedule.scheduledNews(value, context);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
