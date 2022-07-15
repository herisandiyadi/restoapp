import 'dart:core';

class RestaurantDetail {
  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurantDetails,
  });

  bool error;
  String message;
  RestaurantDetails restaurantDetails;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurantDetails: RestaurantDetails.fromJson(json["restaurant"]),
      );
}

class RestaurantDetails {
  RestaurantDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
    required this.isFavorite,
  });

  late String id;
  late String name;
  late String description;
  late String city;
  late String address;
  late String pictureId;
  late List<Category> categories;
  late Menus menus;
  late double rating;
  late List<CustomerReview> customerReviews;
  late int isFavorite = 0;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
        isFavorite: 0,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'pictureId': pictureId,
      'rating': rating,
      'address': address,
      'categories': categories,
      'menus': menus,
      'customerReviews': customerReviews,
      'isFavorite': isFavorite
    };
  }

  RestaurantDetails.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    city = map['city'];
    pictureId = map['pictureId'];
    rating = map['rating'];
    isFavorite = map['name'];
    name = map['name'];
    address = map['address'];
    categories = map['categories'];
    menus = map['menus'];
    customerReviews = map['customerReviews'];
  }
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'] ?? '',
      );
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"] ?? '',
        review: json["review"] ?? '',
        date: json["date"] ?? '',
      );
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );
}
