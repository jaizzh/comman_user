import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/model/event_model.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/pages/gift_registry_page.dart';
import 'package:common_user/features/product/widgets/gift_registry_provider.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void showConfirmAlretBox(
  BuildContext context,
  final Product product,
  final EventModel event,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.paper,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          children: [
            const Icon(Icons.card_giftcard, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              "Add to Gift Registry",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Do you want to add '${product.name}' to the gift registry for '${event.name}'?",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Text(
              "Your friends & family can see this item in your registry and purchase it for you.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.black.withOpacity(0.5)),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // cancel
            },
            child: Text(
              "Cancel",
              style:
                  GoogleFonts.poppins(color: AppColors.black.withOpacity(0.7)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              context.read<GiftRegistryProvider>().addToRegistry(
                    product,
                    event,
                  );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${product.name} added to Gift Registry',
                    style: GoogleFonts.poppins(color: AppColors.white),
                  ),
                  backgroundColor: AppColors.primary,
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
              navigateWithSlide(context, const GiftRegistryPage());
            },
            icon: const Icon(
              Icons.add,
              size: 18,
              color: AppColors.paper,
            ),
            label: Text(
              "Add",
              style: GoogleFonts.poppins(color: AppColors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      );
    },
  );
}
