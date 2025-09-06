import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/model/makeup_model.dart';
import 'package:common_user/features/vendor/model/music_model.dart';
import 'package:common_user/features/vendor/model/photo_model.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/features/venue/presentation/pages/location_search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VendorDetails extends StatelessWidget {
  final String categoryTitle;
  final List<dynamic> vendorData;
  final String vendorType; // 'photo', 'makeup', 'music'

  const VendorDetails({
    super.key,
    required this.categoryTitle,
    required this.vendorData,
    required this.vendorType,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: AppColors.paper,
        title: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LocationSearchPage(),
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
            if (result != null && result is String) {
              context.read<LocationProvider>().updateLocation(result);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: AppColors.primary),
              const SizedBox(width: 10),
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
        actions: const [
          Card(
            color: AppColors.primary,
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                size: 20,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(width: 5),
          Card(
            color: AppColors.primary,
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_bag,
                size: 20,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryTitle,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: vendorData.length,
                itemBuilder: (context, index) {
                  return _buildVendorCard(screenWidth, screenHeight, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorCard(double screenWidth, double screenHeight, int index) {
    // Get common properties based on vendor type
    String name, image, location, price;
    double rating;

    switch (vendorType) {
      case 'photo':
        PhotoModel photo = vendorData[index];
        name = photo.name;
        image = photo.image;
        location = photo.location;
        price = photo.price;
        rating = photo.rating;
        break;
      case 'makeup':
        MakeupArtistModel makeup = vendorData[index];
        name = makeup.name;
        image = makeup.image;
        location = makeup.location;
        price = makeup.price;
        rating = makeup.rating;
        break;
      case 'music':
        MusicDanceModel music = vendorData[index];
        name = music.name;
        image = music.image;
        location = music.location;
        price = music.price;
        rating = music.rating;
        break;
      default:
        return const SizedBox();
    }

    return Card(
      color: AppColors.white,
      elevation: 2,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(4),
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
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rating.toString(),
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
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
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
    );
  }
}
