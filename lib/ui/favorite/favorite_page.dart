import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant_detail_args.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/ui/dashboard_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          'Favorite',
          style: darkTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(
        //           builder: (context) => DashboardPage(
        //             selectedPage: 0,
        //           ),
        //         ),
        //         (route) => false);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: darkColor,
        //   ),
        // ),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final restoFav = provider.restoFavorite;
          return ListView.builder(
            itemCount: restoFav.length,
            itemBuilder: (context, index) {
              final listFav = restoFav[index];

              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detail-page',
                  arguments: RestaurantDetailsArgs(
                    id: listFav.id,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.network(listFav.imageUrl)),
                        title: Text(listFav.name),
                        subtitle: Row(
                          children: [
                            Icon(
                              Icons.room,
                              color: orangeColor,
                            ),
                            Text(listFav.city),
                          ],
                        ),
                        trailing: listFav.favorite == 1
                            ? IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red[800],
                                ),
                                onPressed: () {
                                  provider.deleteFavorite(listFav.id);
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red[800],
                                ),
                                onPressed: () {
                                  provider.deleteFavorite(listFav.id);
                                },
                              )),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
