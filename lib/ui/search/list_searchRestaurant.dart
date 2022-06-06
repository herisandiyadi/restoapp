// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/provider/resto_search_provider.dart';

class ListSearchRestaurant extends StatelessWidget {
  final String queries = '';

  const ListSearchRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _images = 'https://restaurant-api.dicoding.dev/images/medium/';
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.restaurantState == RestaurantState.loading) {
          return CircularProgressIndicator();
        } else if (state.restaurantState == RestaurantState.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.searchResto?.restaurantSearchs.length,
              itemBuilder: (context, index) {
                var restaurant = state.searchResto?.restaurantSearchs[index];

                return ListTile(
                  leading: Hero(
                    tag: Image.network(_images + restaurant!.pictureId),
                    child: Image.network(
                      _images + restaurant.pictureId,
                      width: 100,
                    ),
                  ),
                  title: Text(
                    restaurant.name,
                    style: darkTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: greyColor,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate,
                            color: yellowColor,
                          ),
                          Text(
                            restaurant.rating.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail-page',
                      arguments: RestaurantDetailsArgs(
                        id: restaurant.id,
                      ),
                    );
                  },
                );
              });
        } else if (state.restaurantState == RestaurantState.noData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.restaurantState == RestaurantState.error) {
          return Center(
            child: Text(
              state.message,
              style: greyTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
