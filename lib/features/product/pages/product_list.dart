import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/pages/product_details.dart';
import 'package:common_user/features/product/widgets/searchFilter.dart';
import 'package:common_user/features/vendor/widgets/custom_appbar.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatefulWidget {
  final ProductCategory categories;
  const ProductList({super.key, required this.categories});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: const CustomAppBar(title: "Product List"),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Searchfilter(),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Expanded(child: SingleChildScrollView(child: showProductList())),
          ],
        ),
      ),
    );
  }

  Widget showProductList() {
    return GridView.builder(
        shrinkWrap: true, // important!
        physics: const NeverScrollableScrollPhysics(), // scroll conflict avoid
        itemCount: widget.categories.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8, // card height/width ratio
        ),
        itemBuilder: (context, index) {
          final product = widget.categories.products[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(
                  context,
                  ProductDetails(
                    product: product,
                    categories: widget.categories,
                  ));
            },
            child: Card(
              color: const Color.fromARGB(255, 247, 242, 232),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text("₹${product.price}",
                            style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
