import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/provider/resto_detail_provider.dart';
import 'package:restaurant_app/ui/detail/list_detail.dart';

class DetailPage extends StatefulWidget {
  final RestaurantDetailsArgs detailsArgs;

  const DetailPage({Key? key, required this.detailsArgs}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestoDetailProvider>(
        create: (_) => RestoDetailProvider(
          apiService: ApiService(),
          id: widget.detailsArgs.id!,
        ),
        child: Consumer<RestoDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: darkColor,
                ),
              );
            } else if (state.state == ResultState.HasData) {
              var resultDetails = state.result.restaurantDetails;
              return ListDetail(resultDetails: resultDetails);
            } else if (state.state == ResultState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.NoInternet) {
              return Center(
                  child: Text(
                state.message,
                style: greyTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              ));
            } else {
              return Center(
                child: Text(''),
              );
            }
          },
          child: Container(
            child: Text(''),
          ),
        ),
      ),
    );
  }
}
