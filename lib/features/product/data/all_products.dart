import 'dart:math';

import 'package:common_user/features/product/data/product_data.dart';
import 'package:common_user/features/product/model/product_model.dart';

// flatten pannura logic
List<Product> allProducts =
    productcategories.expand((category) => category.products).toList();
List<Product> getRandomProducts(int count) {
  final random = Random();
  final shuffled = List<Product>.from(allProducts)..shuffle(random);
  return shuffled.take(count).toList();
}
