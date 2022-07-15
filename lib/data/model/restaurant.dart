class Restaurant {
  Restaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool? error;
  String? message;
  int? count;
  List<RestaurantElement?> restaurants;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantElement>.from(
            json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x?.toJson())),
      };
}

class RestaurantElement {
  RestaurantElement(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.isFavorite});

  late String? id;
  late String? name;
  late String? description;
  late String? pictureId;
  late String? city;
  late double? rating;
  late bool isFavorite = false;

  Map<String?, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'pictureId': pictureId,
      'rating': rating,
      'isFavorite': isFavorite
    };
  }

  RestaurantElement.fromMap(Map<String?, dynamic> map) {
    id = map['id'];
    description = map['description'];
    city = map['city'];
    pictureId = map['pictureId'];
    rating = map['rating'];
    isFavorite = map['name'];
    name = map['name'];
  }

  factory RestaurantElement.fromJson(Map<String, dynamic> json) =>
      RestaurantElement(
          id: json["id"],
          name: json["name"],
          description: json["description"],
          pictureId: json["pictureId"],
          city: json["city"],
          rating: json["rating"].toDouble(),
          isFavorite: false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
