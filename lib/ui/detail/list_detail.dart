// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';

class ListDetail extends StatelessWidget {
  final RestaurantDetails resultDetails;

  const ListDetail({Key? key, required this.resultDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _images = 'https://restaurant-api.dicoding.dev/images/medium/';
    Widget header() {
      return Container(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    darkColor.withOpacity(0),
                    darkColor.withOpacity(0.5)
                  ],
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget kategoriResto() {
      return Row(
          children: resultDetails.categories
              .map((kategori) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(label: Text(kategori.name)),
                  ))
              .toList());
    }

    Widget makanan() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: resultDetails.menus.foods
              .map((foods) => Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Column(
                            children: [
                              Icon(Icons.lunch_dining, size: 100),
                              Container(
                                width: 100,
                                child: Text(
                                  foods.name,
                                  style: greyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      elevation: 15,
                    ),
                  ))
              .toList(),
        ),
      );
    }

    Widget minuman() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: resultDetails.menus.drinks
              .map((drinks) => Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Column(
                            children: [
                              Icon(Icons.local_bar, size: 100),
                              Container(
                                width: 100,
                                child: Text(
                                  drinks.name,
                                  style: greyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 15,
                    ),
                  ))
              .toList(),
        ),
      );
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30, right: 15, left: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resultDetails.name + ' - ' + resultDetails.city,
              style: darkTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.room,
                  color: darkColor,
                  size: 22,
                ),
                SizedBox(width: 6),
                Text(
                  resultDetails.address,
                  style: darkTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: resultDetails.rating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  (resultDetails.rating).toString(),
                ),
              ],
            ),
            kategoriResto(),
            SizedBox(
              height: 16,
            ),
            Text(
              'Deskripsi Restoran',
              style: darkTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              resultDetails.description,
              style: darkTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    Widget review() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: resultDetails.customerReviews
              .map((reviews) => Container(
                    width: 360,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(reviews.name),
                          subtitle: Text(reviews.review),
                          trailing: Text(reviews.date),
                          visualDensity:
                              VisualDensity(horizontal: 2, vertical: 2),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    child: Hero(
                      tag: _images + resultDetails.pictureId,
                      child: Image(
                        image: NetworkImage(_images + resultDetails.pictureId),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
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
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                darkColor.withOpacity(0),
                                darkColor.withOpacity(0.5)
                              ],
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  header(),
                ],
              ),
            ),
            title(),
            Divider(
              height: 15,
              thickness: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Makanan',
                style: darkTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            makanan(),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Minuman',
                style: darkTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            minuman(),
            SizedBox(
              height: 16,
            ),
            Divider(
              height: 15,
              thickness: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ulasan Pembeli',
                      style: darkTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/review-page',
                        arguments: ReviewArgs(
                          id: resultDetails.id,
                        ),
                      );
                    },
                    child: Text(
                      'Tambah Ulasan',
                      style: darkTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            review(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
