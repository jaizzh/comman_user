import 'package:common_user/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
    return Column(
      children: [
        Text(
          widget.product.name,
        ),
        Text(widget.product.description),
        Text(widget.product.price.toString()),
      ],
    );
  }
}
