// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/constants.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class CardRestaurant extends StatelessWidget {
  final RestaurantElement? restaurantElement;

  const CardRestaurant({Key? key, required this.restaurantElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      margin: EdgeInsets.only(
        top: 10,
        right: 20,
        left: 20,
        bottom: 20,
      ),
      child: Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(images_url + restaurantElement!.pictureId),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  whiteColor.withOpacity(0),
                  darkColor.withOpacity(0.85)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(
                left: 15,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        restaurantElement!.name,
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.room, color: orangeColor),
                      Text(
                        restaurantElement!.city,
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.star, color: yellowColor),
                  Text(
                    (restaurantElement!.rating).toString(),
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
