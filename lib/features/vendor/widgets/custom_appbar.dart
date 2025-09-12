import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/features/venue/presentation/pages/location_search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotification;
  final bool showCart;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showNotification = true,
    this.showCart = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      actions: [
        if (showNotification)
          const Card(
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
        if (showNotification) const SizedBox(width: 5),
        if (showCart)
          const Card(
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
        if (showCart) const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
