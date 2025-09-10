class MakeupArtistModel {
  final int id;
  final String name;
  final String image;
  final String location;
  final String price;
  final double rating;
  final List<String> services;

  MakeupArtistModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.price,
    required this.rating,
    required this.services,
  });
}
