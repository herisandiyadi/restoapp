import 'package:flutter/material.dart';
import 'package:restaurant_app/common/background_services.dart';
import 'package:restaurant_app/common/notification_helper.dart';
import 'package:restaurant_app/ui/favorite/favorite_page.dart';
import 'package:restaurant_app/ui/home/home_page.dart';
import 'package:restaurant_app/ui/settings/setting_page.dart';

class DashboardPage extends StatefulWidget {
  final int selectedPage;

  DashboardPage({Key? key, required this.selectedPage}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List listPage = [HomePage(), FavoritePage(), SettingPage()];
  int tabIndex = 0;
  final BackgroundService _service = BackgroundService();
  final NotificationHelper _notificationHelper = NotificationHelper();
  void _changeSelectedNavBar(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject('/detail-page');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        currentIndex: tabIndex,
        selectedItemColor: Colors.red,
        onTap: _changeSelectedNavBar,
      ),
      body: listPage[tabIndex],
    );
  }
}
