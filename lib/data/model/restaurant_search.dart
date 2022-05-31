// To parse this JSON data, do
//
//     final restaurantSearch = restaurantSearchFromJson(jsonString);

class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurantSearchs,
  });

  bool error;
  int founded;
  List<RestaurantSearchs> restaurantSearchs;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurantSearchs: List<RestaurantSearchs>.from(
            json["restaurants"].map((x) => RestaurantSearchs.fromJson(x))),
      );
}

class RestaurantSearchs {
  RestaurantSearchs({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantSearchs.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchs(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
