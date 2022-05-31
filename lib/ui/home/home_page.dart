// ignore_for_file: prefer_const_constructors, unused_field, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';

import 'package:restaurant_app/ui/home/list_resto.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search-page');
              },
              icon: Icon(
                Icons.search_rounded,
                color: darkColor,
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, bottom: 10, top: 10),
              child: Text(
                'Recomendation restaurant for you!',
                textAlign: TextAlign.start,
                style:
                    greyTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 640,
              child: ListResto(),
            ),
          ],
        ),
      ),
    );
  }
}
