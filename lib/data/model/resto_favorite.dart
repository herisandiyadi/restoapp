class RestoFavorite {
  RestoFavorite(
      {required this.id,
      required this.favorite,
      required this.name,
      required this.imageUrl,
      required this.city});

  late final String id;
  late final int favorite;
  late final String name;
  late final String imageUrl;
  late final String city;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'favorite': favorite,
      'name': name,
      'imageurl': imageUrl,
      'city': city
    };
  }

  RestoFavorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    favorite = map['favorite'];
    name = map['name'];
    imageUrl = map['imageurl'];
    city = map['city'];
  }
}
