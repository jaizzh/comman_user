import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/data/product_data.dart';
import 'package:common_user/features/product/pages/product_details.dart';
import 'package:common_user/features/product/widgets/gift_registry_provider.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GiftRegistryPage extends StatefulWidget {
  const GiftRegistryPage({super.key});

  @override
  State<GiftRegistryPage> createState() => _GiftRegistryPageState();
}

class _GiftRegistryPageState extends State<GiftRegistryPage> {
  @override
  Widget build(BuildContext context) {
    final registry = context.watch<GiftRegistryProvider>().registry;
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        title: Text(
          "My Gift Registry",
          style: GoogleFonts.poppins(fontSize: 17),
        ),
        backgroundColor: AppColors.paper,
      ),
      body: registry.isEmpty
          ? Center(
              child: Text(
                "No items in your gift registry",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: registry.length,
              itemBuilder: (context, index) {
                final item = registry[index];
                return GestureDetector(
                  onTap: () {
                    navigateWithSlide(
                        context,
                        ProductDetails(
                            product: item.product,
                            categories: productcategories[0]));
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Image.asset(item.product.image, width: 50),
                      title: Text(
                        item.product.name,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      subtitle: Text(
                        "${item.event.name} • ${item.event.type}",
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete, color: AppColors.primary),
                        onPressed: () {
                          context
                              .read<GiftRegistryProvider>()
                              .removeFromRegistry(item);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
