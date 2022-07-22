import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/resto_search_provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        return Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  border: Border.all(
                    color: greyColor,
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  title: TextField(
                    controller: _controller,
                    onChanged: (String query) {
                      if (query.isNotEmpty) {
                        setState(() {
                          queries = query;
                        });
                        state.fetchSearchRestaurant(query);
                      }
                    },
                    cursorColor: greyColor,
                    decoration: InputDecoration(
                      hintText: 'Cari Restaurant',
                      border: InputBorder.none,
                    ),
                  ),
                  trailing: queries.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            if (queries.isNotEmpty) {
                              _controller.clear();
                              setState(() {
                                queries = '';
                                dispose();
                              });
                            }
                          },
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.red,
                          ),
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
