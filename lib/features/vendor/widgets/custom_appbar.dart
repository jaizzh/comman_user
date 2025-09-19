// ignore_for_file: use_build_context_synchronously

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/chat/pages/user_list_page.dart';
import 'package:common_user/features/product/pages/cart_page.dart';
import 'package:common_user/features/product/widgets/cart_provider.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/features/venue/presentation/pages/location_search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

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
          GestureDetector(
            onTap: () {
              navigateWithSlide(context, UsersPage());
            },
            child: const Card(
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
          ),
        if (showNotification) const SizedBox(width: 5),
        if (showCart)
          GestureDetector(
            onTap: () {
              navigateWithSlide(context, const CartPage());
            },
            child: Consumer<CartProvider>(
              builder: (context, cart, child) {
                final totalQuantity = cart.items.fold<int>(
                  0,
                  (sum, item) => sum + item.quantity,
                );

                return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -8, end: -4),
                  showBadge: cart.items.isNotEmpty,
                  badgeContent: Text(
                    totalQuantity.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.orange,
                    padding: EdgeInsets.all(5),
                  ),
                  child: const Card(
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
                );
              },
            ),
          ),
        if (showCart) const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
