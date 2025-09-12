// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/data/category_data.dart';
import 'package:common_user/features/vendor/model/category_model.dart';
import 'package:common_user/features/vendor/pages/vendor_list.dart';
import 'package:common_user/features/vendor/widgets/custom_appbar.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/pages/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  TextEditingController searchController = TextEditingController();
  late List<CategoryModel> filteredList;

  @override
  void initState() {
    super.initState();
    filteredList = category;
  }

  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = category;
      } else {
        filteredList = category
            .where((venue) =>
                venue.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder for adaptive sizing for all screen types
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        return Scaffold(
          backgroundColor: AppColors.paper,
          appBar: const CustomAppBar(title: "Vendor Category"),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
                child: searchFilter(screenWidth),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: vendorList(screenWidth, screenHeight),
                ),
              ),
            ],
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
          child: Card(
            shadowColor: AppColors.primary,
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 255, 241, 245)),
              child: TextField(
                controller: searchController,
                onChanged: filterSearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search Your Vendors",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500),
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
              padding: const EdgeInsets.all(10),
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

  Widget vendorList(double screenWidth, double screenHeight) {
    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          'No vendor found',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        CategoryModel cat = filteredList[index];
        return GestureDetector(
          onTap: () {
            navigateWithSlide(
              context,
              VendorList(
                  categoryTitle: cat.name,
                  vendorData: cat.vendorData,
                  vendorType: cat.vendorType),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
            child: Card(
              elevation: 5,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: cat.color.withOpacity(0.4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.01,
                      height: screenHeight * 0.09,
                      color: cat.color.withOpacity(0.9),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Text(
                        cat.name,
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              cat.color.withOpacity(0.9),
                              Colors.transparent
                            ],
                            stops: const [0.6, 0.9],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            cat.image,
                            fit: BoxFit.cover,
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.09,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
