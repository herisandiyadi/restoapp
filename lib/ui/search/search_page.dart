import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/search/list_searchRestaurant.dart';
import 'package:restaurant_app/widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: greyColor,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SearchBarWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: ListSearchRestaurant(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
