import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/data/all_products.dart';
import 'package:common_user/features/product/data/product_data.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/pages/product_details.dart';
import 'package:common_user/features/product/pages/product_list.dart';
// import 'package:common_user/features/vendor/pages/category_list.dart';
import 'package:common_user/features/vendor/widgets/custom_appbar.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/pages/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: const CustomAppBar(title: ""),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchFilter(screenWidth),
              gap(screenHeight, values: 0.02),
              adsRow(screenWidth, screenHeight),
              gap(screenHeight),
              threeDots(screenWidth),
              gap(screenHeight, values: 0.02),
              categoryText("Categories", () {}),
              gap(screenHeight),
              categoryList(screenWidth),
              gap(screenHeight, values: 0.02),
              categoryText("Special For You", () {
                navigateWithSlide(
                    context, ProductList(categories: productcategories[0]));
              }),
              gap(screenHeight),
              specialForYou(),
              gap(screenHeight, values: 0.02),
              googleAds(screenWidth, screenHeight),
              gap(screenHeight, values: 0.02),
              categoryText("Popular Dress", () {
                navigateWithSlide(
                    context, ProductList(categories: productcategories[1]));
              }),
              gap(screenHeight),
              popularProducts(screenWidth, screenHeight, productcategories[1]),
              gap(screenHeight, values: 0.02),
              categoryText("Treanding Gifts", () {
                navigateWithSlide(
                    context, ProductList(categories: productcategories[2]));
              }),
              gap(screenHeight),
              popularProducts(screenWidth, screenHeight, productcategories[2]),
            ],
          ),
        ),
      ),
    );
  }

  Widget gap(double screenHeight, {double values = 0.01}) {
    return SizedBox(
      height: screenHeight * values,
    );
  }

  Widget searchFilter(double width) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: () {},
            child: Card(
              shadowColor: AppColors.primary,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: width * 0.025),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 241, 245)),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Search your Products",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.02),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              navigateWithSlide(context, const FilterPage());
            },
            child: Container(
              padding: EdgeInsets.all(width * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: const Center(
                child: Icon(Icons.tune, color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget adsRow(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          adsCards(screenWidth, screenHeight, "assets/vendor/ban1.jpg"),
          SizedBox(width: screenWidth * 0.02),
          adsCards(screenWidth, screenHeight, "assets/vendor/ban.jpg"),
          SizedBox(width: screenWidth * 0.02),
          adsCards(screenWidth, screenHeight, "assets/vendor/ban4.webp"),
        ],
      ),
    );
  }

  Widget adsCards(double screenWidth, double screenHeight, String img) {
    return Card(
      shadowColor: AppColors.primary,
      elevation: 3,
      child: Container(
        width: screenWidth / 1.3,
        height: screenHeight / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget threeDots(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: screenWidth * 0.01,
          backgroundColor: AppColors.primary,
        ),
        SizedBox(width: screenWidth * 0.01),
        CircleAvatar(
          radius: screenWidth * 0.01,
          backgroundColor: AppColors.primary,
        ),
        SizedBox(width: screenWidth * 0.01),
        CircleAvatar(
          radius: screenWidth * 0.01,
          backgroundColor: AppColors.primary,
        )
      ],
    );
  }

  Widget categoryList(double screenWidth) {
    return SizedBox(
      height: 80, // fixed height kudukanum horizontal scroll ku
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // important!
        itemCount: productcategories.length,
        itemBuilder: (context, index) {
          final categories = productcategories[index];
          return GestureDetector(
              onTap: () {
                navigateWithSlide(context, ProductList(categories: categories));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.07,
                      backgroundColor: const Color.fromARGB(255, 245, 232, 203),
                      child: Image.asset(
                        categories.image,
                        width: screenWidth * 0.09,
                      ),
                    ),
                    Text(
                      categories.name,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget categoryText(String text, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            "See All",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget specialForYou() {
    final randomProducts = getRandomProducts(4);
    return GridView.builder(
        shrinkWrap: true, // important!
        physics: const NeverScrollableScrollPhysics(), // scroll conflict avoid
        itemCount: randomProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8, // card height/width ratio
        ),
        itemBuilder: (context, index) {
          final product = randomProducts[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(context, ProductDetails(product: product));
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

  Widget popularProducts(
    double screenWidth,
    double screenHeight,
    final ProductCategory categories,
  ) {
    final furnitures = categories.products;
    return SizedBox(
      height: screenHeight / 4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: furnitures.length,
        itemBuilder: (context, index) {
          final product = furnitures[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(context, ProductDetails(product: product));
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

  Widget googleAds(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.04,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/venue_images/ads.png"),
              fit: BoxFit.cover)),
    );
  }
}
