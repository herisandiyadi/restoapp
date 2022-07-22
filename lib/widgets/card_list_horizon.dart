import 'package:flutter/material.dart';
import 'package:restaurant_app/common/constants.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class CardListHorizon extends StatelessWidget {
  final RestaurantElement? restoResult;
  CardListHorizon({Key? key, required this.restoResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Hero(
                    tag: images_url + restoResult!.pictureId,
                    child: Image.network(
                      images_url + restoResult!.pictureId,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  restoResult!.name,
                  style: darkTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.room,
                      color: orangeColor,
                    ),
                    Text(
                      restoResult!.city,
                      style: darkTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 6,
            top: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                color: whiteColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: yellowColor,
                      size: 12,
                    ),
                    Text(
                      (restoResult!.rating).toString(),
                      style: darkTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
