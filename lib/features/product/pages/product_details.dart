// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/model/cart_model.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/widgets/cart_provider.dart';
import 'package:common_user/features/product/widgets/giftRegidtry_alertBox.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  // ignore: prefer_typing_uninitialized_variables
  final ProductCategory categories;
  const ProductDetails(
      {super.key, required this.product, required this.categories});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int cartValue = 1;
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showProduct(screenHeight, screenWidth),
          gap(screenHeight),
          Expanded(
              child: SingleChildScrollView(
                  child: productDetails(screenHeight, screenWidth))),
          bottom(screenWidth, screenHeight, () {
            cart.addToCart(
              CartItem(
                name: widget.product.name,
                image: widget.product.image,
                price: widget.product.price,
              ),
              quantity: cartValue,
            );
            // Show a SnackBar when the item is added
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${widget.product.name} added to cart',
                  style: GoogleFonts.poppins(color: AppColors.black),
                ),
                backgroundColor: AppColors.paper,
                duration: const Duration(seconds: 2),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget gap(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.02,
    );
  }

  Widget showProduct(double screenHeight, double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: screenHeight / 2.5,
      width: screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.product.image), fit: BoxFit.cover)),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                  backgroundColor: AppColors.paper.withOpacity(0.9),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  )),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      fav = !fav; // Toggle the favorite state
                    });
                  },
                  child: CircleAvatar(
                      backgroundColor: AppColors.paper.withOpacity(0.5),
                      child: Icon(
                        fav ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.primary,
                      )),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                CircleAvatar(
                    backgroundColor: AppColors.paper.withOpacity(0.5),
                    child: const Icon(
                      Icons.share,
                      color: AppColors.black,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget productDetails(double screenHeight, double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.product.name,
                style: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                "₹ ${widget.product.price.toString()}",
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text(
            widget.product.description,
            style: GoogleFonts.poppins(
                fontSize: 14, color: AppColors.black.withOpacity(0.6)),
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 15,
                color: Colors.orange,
              ),
              Text(
                " 4.8",
                style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "   (420 Reviews)",
                style: GoogleFonts.poppins(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                backgroundColor: AppColors.lightGold.withOpacity(0.6),
                child: Icon(
                  Icons.message,
                  color: AppColors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              CircleAvatar(
                backgroundColor: AppColors.lightGold.withOpacity(0.6),
                child: Icon(
                  Icons.phone,
                  color: AppColors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Text(
            "Product Information",
            style:
                GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          gap(screenHeight * 0.50),
          Text(
            textAlign: TextAlign.justify,
            "This product is crafted with high-quality materials to ensure durability and long-lasting performance. The modern and elegant design makes it a perfect fit for both everyday use and special occasions. Its lightweight and comfortable build allows you to handle and use it with ease. Overall, it offers great value for money and also works as a thoughtful gift choice.",
            style: GoogleFonts.poppins(
                fontSize: 12, color: AppColors.black.withOpacity(0.6)),
          ),
          gap(screenHeight * 0.50),
          Text(
            "Photos",
            style:
                GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          gap(screenHeight * 0.50),
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.product.image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }),
          ),
          gap(screenHeight),
          Text(
            "Smilar Products",
            style:
                GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          gap(screenHeight * 0.50),
          popularProducts(screenWidth, screenHeight),
          gap(screenHeight),
        ],
      ),
    );
  }

  Widget popularProducts(
    double screenWidth,
    double screenHeight,
  ) {
    final furnitures = widget.categories.products;
    return SizedBox(
      height: screenHeight / 4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: furnitures.length,
        itemBuilder: (context, index) {
          final product = furnitures[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(
                  context,
                  ProductDetails(
                    product: product,
                    categories: widget.categories,
                  ));
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              child: Card(
                color: AppColors.white,
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      height: screenHeight / 8,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: AppColors.paper,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                product.id.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.006,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              product.price.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  size: 10,
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    product.description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: AppColors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottom(double screenWidth, double screenHeight, Function() fun) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: screenWidth,
      height: screenHeight * 0.1,
      color: AppColors.primary,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                cartValue = cartValue + 1;
              });
            },
            child: const Card(
              color: AppColors.paper,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ),
          ),
          Text(
            " $cartValue ",
            style: GoogleFonts.poppins(fontSize: 17, color: AppColors.white),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (cartValue > 1) {
                  cartValue = cartValue - 1;
                }
              });
            },
            child: const Card(
              color: AppColors.paper,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.remove),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: fun,
            child: Card(
              color: AppColors.paper,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Add to cart",
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showGiftRegistryDialog(
                  widget.product.name, context, widget.product);
            },
            child: const Card(
              color: AppColors.paper,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Icon(Icons.card_giftcard)),
            ),
          )
        ],
      ),
    );
  }
}
