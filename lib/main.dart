// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/background_services.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/notification_helper.dart';
import 'package:restaurant_app/common/scheduling_provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/provider/resto_search_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/ui/dashboard_page.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/ui/favorite/favorite_page.dart';
import 'package:restaurant_app/ui/home/home_page.dart';
import 'package:restaurant_app/ui/review/review_page.dart';
import 'package:restaurant_app/ui/search/search_page.dart';
import 'package:restaurant_app/ui/settings/setting_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final BackgroundService service = BackgroundService();
  final NotificationHelper _notificationHelper = NotificationHelper();
  service.initializeIsolate();

  if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  Widget build(BuildContext context) {
    Widget splashScreen() {
      // ignore: unnecessary_new
      return Hero(
        tag: 'assets/images/logos.png',
        child: SplashScreenView(
          navigateRoute: DashboardPage(
            selectedPage: 0,
          ),
          duration: 5000,
          imageSize: 150,
          imageSrc: 'assets/images/logos.png',
          backgroundColor: Colors.red,
          text: 'Resto App',
          textType: TextType.NormalText,
          textStyle: whiteTextStyle.copyWith(fontSize: 28, fontWeight: bold),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoProvider>(
          create: (_) => RestoProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (_) => ReviewProvider(),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DbProvider>(
          create: (_) => DbProvider(),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => splashScreen(),
          '/dashboard': (context) => DashboardPage(selectedPage: 0),
          '/homepage': (context) => HomePage(),
          '/detail-page': (context) => DetailPage(
              detailsArgs: ModalRoute.of(context)?.settings.arguments
                  as RestaurantDetailsArgs),
          '/search-page': (context) => SearchPage(),
          '/review-page': (context) => ReviewPage(
                reviewArgs:
                    ModalRoute.of(context)?.settings.arguments as ReviewArgs,
              ),
          '/favorite': (context) => FavoritePage(),
          '/setting-page': (context) => SettingPage(),
        },
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _notificationHelper.configureSelectNotificationSubject(
  //     RestaurantDetail.,
  //   );
  // }

  // @override
  // void dispose() {
  //   selectNotificationSubject.close();
  //   super.dispose();
  // }
}
