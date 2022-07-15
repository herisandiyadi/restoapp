// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/constants.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/data/model/resto_favorite.dart';
import 'package:restaurant_app/provider/db_provider.dart';

class ListDetail extends StatefulWidget {
  final RestaurantDetails resultDetails;

  const ListDetail({Key? key, required this.resultDetails}) : super(key: key);

  @override
  State<ListDetail> createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail> {
  @override
  Widget build(BuildContext context) {
    final providerDb = Provider.of<DbProvider>(context, listen: false);
    // final restoFav = providerDb.restoFavorite;
    // restoFav.map((e) => e.id);

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
          children: widget.resultDetails.categories
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
          children: widget.resultDetails.menus.foods
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
          children: widget.resultDetails.menus.drinks
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
              widget.resultDetails.name + ' - ' + widget.resultDetails.city,
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
                  widget.resultDetails.address,
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
                  initialRating: widget.resultDetails.rating,
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
                  (widget.resultDetails.rating).toString(),
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
              widget.resultDetails.description,
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
          children: widget.resultDetails.customerReviews
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

    return Consumer<DbProvider>(
      builder: (context, provider, state) {
        return FutureBuilder<RestoFavorite>(
            future: provider.getFavById(widget.resultDetails.id),
            builder: (context, snapshot) {
              var isFav = snapshot.data?.favorite;
              print(isFav);
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
                                tag:
                                    images_url + widget.resultDetails.pictureId,
                                child: Image(
                                  image: NetworkImage(images_url +
                                      widget.resultDetails.pictureId),
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
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                // margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: whiteColor),
                                child: IconButton(
                                  onPressed: () async {
                                    final favorite = RestoFavorite(
                                        id: widget.resultDetails.id,
                                        favorite: 1,
                                        name: widget.resultDetails.name,
                                        imageUrl: images_url +
                                            widget.resultDetails.pictureId,
                                        city: widget.resultDetails.city);

                                    if (isFav == 0 || isFav == null) {
                                      setState(() {
                                        providerDb.addData(favorite);
                                        widget.resultDetails.isFavorite = 1;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            'Telah ditambahkan ke favorite',
                                            textAlign: TextAlign.center,
                                          ),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        provider.deleteFavorite(
                                            widget.resultDetails.id);
                                        widget.resultDetails.isFavorite = 0;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Telah dihapus dari favorite',
                                            textAlign: TextAlign.center,
                                          ),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  },
                                  icon: isFav == 1
                                      ? Icon(Icons.favorite,
                                          color: Colors.red[800])
                                      : Icon(
                                          Icons.favorite,
                                          color: greyColor,
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
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
                                    id: widget.resultDetails.id,
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
            });
      },
    );
  }
}
