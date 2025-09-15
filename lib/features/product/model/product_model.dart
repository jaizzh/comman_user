class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

class ProductCategory {
  final int id;
  final String name;
  final String image;
  final List<Product> products;

  ProductCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.products,
  });
}
