import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/home/list_recomend_resto.dart';
import 'package:restaurant_app/ui/home/list_resto.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/logos.png',
                  height: 24,
                  width: 24,
                ),
              ),
              Text(
                'Resto App',
                style: darkTextStyle.copyWith(fontSize: 18, fontWeight: bold),
              ),
            ],
          ),
          centerTitle: true,
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
              margin: EdgeInsets.only(left: 16, top: 10),
              child: Text(
                'Recomendation restaurant for you!',
                textAlign: TextAlign.start,
                style:
                    greyTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListRecomendResto(),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 15),
              child: Text(
                'All Restaurant',
                style:
                    greyTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 600,
              child: ListResto(),
            ),
          ],
        ),
      ),
    );
  }
}
