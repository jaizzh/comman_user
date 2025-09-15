import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/pages/product_details.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final ProductCategory categories;
  const ProductList({super.key, required this.categories});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showProductList(),
        ],
      ),
    );
  }

  Widget showProductList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.categories.products.length,
          itemBuilder: (context, index) {
            final product = widget.categories.products[index];
            return GestureDetector(
                onTap: () {
                  navigateWithSlide(context, ProductDetails(product: product));
                },
                child: Text(product.name));
          }),
    );
  }
}
