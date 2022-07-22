import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/widgets/card_list_horizon.dart';

class ListRecomendResto extends StatefulWidget {
  const ListRecomendResto({Key? key}) : super(key: key);

  @override
  State<ListRecomendResto> createState() => _ListRecomendRestoState();
}

class _ListRecomendRestoState extends State<ListRecomendResto> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestoProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.result?.restaurants.length,
              itemBuilder: (context, index) {
                final restoResult = state.result?.restaurants[index];
                if (restoResult!.rating >= 4.5) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/detail-page',
                        arguments: RestaurantDetailsArgs(id: restoResult.id)),
                    child: CardListHorizon(restoResult: restoResult),
                  );
                }

                return SizedBox();
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Text(' No Data');
        } else if (state.state == ResultState.error) {
          return Text(state.message);
        } else if (state.state == ResultState.noInternet) {
          return Center(
            child: Text(
              state.message,
              style: greyTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          );
        }
        return Center(
          child: Text(''),
        );
      },
    );
  }
}
