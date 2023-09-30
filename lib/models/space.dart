class Space {
  int id;
  String name;
  String city;
  String country;
  int price;
  String imageUrl;
  int rating;
  String address;
  String phone;
  String mapUrl;
  List photos;
  int number_of_kitchens;
  int number_of_bedrooms;
  int number_of_cupboards;

  Space(
      {required this.country,
      required this.city,
      required this.id,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.rating,
      required this.photos,
      required this.address,
      required this.mapUrl,
      required this.number_of_kitchens,
      required this.number_of_bedrooms,
      required this.number_of_cupboards,
      required this.phone});

  factory Space.fromJson(Map<String, dynamic> json) => Space(
        country: json['country'],
        city: json['city'],
        id: json['id'],
        imageUrl: json['image_url'],
        name: json['name'],
        price: json['price'],
        rating: json['rating'],
        photos: json['photos'],
        address: json['address'],
        mapUrl: json['map_url'],
        number_of_kitchens: json['number_of_kitchens'],
        number_of_bedrooms: json['number_of_bedrooms'],
        number_of_cupboards: json['number_of_cupboards'],
        phone: json['phone'],
      );
}
