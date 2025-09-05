class MusicDanceModel {
  final int id;
  final String name;
  final String image;
  final String category; // Music / Dance
  final String location;
  final String price;
  final double rating;

  MusicDanceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.location,
    required this.price,
    required this.rating,
  });
}
