import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/widgets/card_restaurants.dart';

class ListResto extends StatefulWidget {
  const ListResto({Key? key}) : super(key: key);

  @override
  State<ListResto> createState() => _ListRestoState();
}

class _ListRestoState extends State<ListResto> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestoProvider?>(builder: (context, state, _) {
      if (state!.state == ResultState.Loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            itemCount: state.result!.restaurants.length,
            itemBuilder: (context, index) {
              final restoResult = state.result!.restaurants[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/detail-page',
                    arguments: RestaurantDetailsArgs(id: restoResult.id)),
                child: CardRestaurant(
                  restaurantElement: restoResult,
                ),
              );
            });
      } else if (state.state == ResultState.NoData) {
        return Text(' No Data');
      } else if (state.state == ResultState.Error) {
        return Text(state.message);
      } else if (state.state == ResultState.NoInternet) {
        return Center(
            child: Text(
          state.message,
          style: darkTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ));
      }
      return Center(
        child: Text(''),
      );
    });
  }
}
