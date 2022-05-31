// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/provider/resto_search_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/ui/home/home_page.dart';
import 'package:restaurant_app/ui/review/review_page.dart';
import 'package:restaurant_app/ui/search/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
          '/detail-page': (context) => DetailPage(
              detailsArgs: ModalRoute.of(context)?.settings.arguments
                  as RestaurantDetailsArgs),
          '/search-page': (context) => SearchPage(),
          '/review-page': (context) => ReviewPage(
                reviewArgs:
                    ModalRoute.of(context)?.settings.arguments as ReviewArgs,
              ),
        },
      ),
    );
  }
}