// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/data/makeupArtists_list.dart';
import 'package:common_user/features/vendor/data/music_list.dart';
import 'package:common_user/features/vendor/data/photo_list.dart';
import 'package:common_user/features/vendor/model/makeup_model.dart';
import 'package:common_user/features/vendor/model/music_model.dart';
import 'package:common_user/features/vendor/model/photo_model.dart';
import 'package:common_user/features/vendor/pages/category_list.dart';
import 'package:common_user/features/vendor/pages/vendor_details.dart';
import 'package:common_user/features/vendor/pages/vendor_list.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/features/venue/presentation/pages/filter_page.dart';
import 'package:common_user/features/venue/presentation/pages/location_search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({super.key});

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        return Scaffold(
          backgroundColor: AppColors.paper,
          appBar: AppBar(
            backgroundColor: AppColors.paper,
            surfaceTintColor: AppColors.paper,
            title: GestureDetector(
              onTap: () async {
                final result = await navigateWithSlide(
                  context,
                  const LocationSearchPage(),
                );
                if (result != null && result is String) {
                  context.read<LocationProvider>().updateLocation(result);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: AppColors.primary),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    context.watch<LocationProvider>().selectedLocation,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Card(
                color: AppColors.primary,
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: const Icon(
                    Icons.notifications,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              Card(
                color: AppColors.primary,
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchFilter(screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  adsRow(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  threeDots(screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      navigateWithSlide(context, const CategoryList());
                    },
                    child: categoryText("Category"),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateWithSlide(
                              context,
                              VendorList(
                                categoryTitle: "Wedding Photographers",
                                vendorData: photoList,
                                vendorType: 'photo',
                              ),
                            );
                          },
                          child: circleCategory(
                              screenWidth,
                              "assets/vendor/photo.png",
                              "photography",
                              screenHeight),
                        ),
                        circleCategory(screenWidth, "assets/vendor/dance.png",
                            "Dance", screenHeight),
                        circleCategory(
                            screenWidth,
                            "assets/vendor/decoration.png",
                            "Decoration",
                            screenHeight),
                        circleCategory(screenWidth, "assets/vendor/dj.png",
                            "Dj", screenHeight),
                        circleCategory(screenWidth, "assets/vendor/cat.png",
                            "Catering", screenHeight),
                        circleCategory(screenWidth, "assets/vendor/makeup.png",
                            "Makeup", screenHeight)
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  GestureDetector(
                    onTap: () {
                      navigateWithSlide(
                        context,
                        VendorList(
                          categoryTitle: "Wedding Photographers",
                          vendorData: photoList,
                          vendorType: 'photo',
                        ),
                      );
                    },
                    child: categoryText("Top Pre Wedding Photographers"),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildVerticalCards(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  googleAds(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      navigateWithSlide(
                        context,
                        VendorList(
                          categoryTitle: "Wedding Makeup Artists",
                          vendorData: makeupArtists,
                          vendorType: 'makeup',
                        ),
                      );
                    },
                    child: categoryText("Wedding Makeup Artists"),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildHorizontalCards(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  categoryText("Vendor Products"),
                  SizedBox(height: screenHeight * 0.01),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        products("assets/products/shop.png", "Furnitures"),
                        products("assets/products/dress.png", "Dress"),
                        products(
                            "assets/products/decoration.png", "Decorations"),
                        products("assets/products/flower.png", "Flower Shop"),
                        products("assets/products/gifts.png", "Gifts"),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  googleAds(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      navigateWithSlide(
                        context,
                        VendorList(
                          categoryTitle: "Trending Choreographers",
                          vendorData: musicDanceList,
                          vendorType: 'music',
                        ),
                      );
                    },
                    child: categoryText("Trending Choreographers"),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildMusic(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchFilter(double width) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: () {
              navigateWithSlide(context, const CategoryList());
            },
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
                      "Search your vendors",
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const FilterPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
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
          adsCards(screenWidth, screenHeight, "assets/vendor/banner2.webp"),
          SizedBox(width: screenWidth * 0.02),
          adsCards(screenWidth, screenHeight, "assets/vendor/banner.png"),
          SizedBox(width: screenWidth * 0.02),
          adsCards(screenWidth, screenHeight, "assets/vendor/banner2.webp"),
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

  Widget categoryText(String text) {
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
        Text(
          "see All",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget circleCategory(
      double screenWidth, String image, String title, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.02),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.lightGold,
            radius: screenWidth * 0.07,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.015),
              child: Image.asset(
                width: screenWidth * 0.07,
                image,
                color: AppColors.black.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget products(String images, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                images,
                width: 50,
              ),
            ),
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCards(
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: screenHeight / 4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: photoList.length > 5 ? 5 : photoList.length,
        itemBuilder: (context, index) {
          PhotoModel photo = photoList[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(
                  context,
                  VendorDetails(
                    vendorType: "photo",
                    vendorData: photo,
                    vendorDatas: photoList,
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
                          image: AssetImage(photo.image),
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
                                photo.rating.toString(),
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
                              photo.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              photo.price,
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
                                    photo.location,
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
      height: screenHeight * 0.05,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/venue_images/ads.png"),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildHorizontalCards(
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: screenHeight / 4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: makeupArtists.length > 5 ? 5 : makeupArtists.length,
        itemBuilder: (context, index) {
          MakeupArtistModel makeup = makeupArtists[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(
                  context,
                  VendorDetails(
                    vendorType: "makeup",
                    vendorData: makeup,
                    vendorDatas: makeupArtists,
                  ));
            },
            child: Container(
              width: screenWidth / 1.5,
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
                          image: AssetImage(makeup.image),
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
                                makeup.rating.toString(),
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
                              makeup.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              makeup.price,
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
                                    makeup.location,
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

  Widget _buildMusic(
    double screenWidth,
    double screenHeight,
  ) {
    return SizedBox(
      height: screenHeight / 4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: musicDanceList.length > 5 ? 5 : musicDanceList.length,
        itemBuilder: (context, index) {
          MusicDanceModel music = musicDanceList[index];
          return GestureDetector(
            onTap: () {
              navigateWithSlide(
                  context,
                  VendorDetails(
                    vendorType: "music",
                    vendorData: music,
                    vendorDatas: musicDanceList,
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
                      height: screenHeight / 10,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage(music.image),
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
                                music.rating.toString(),
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
                              music.name,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              music.price,
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
                                    music.location,
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
}
