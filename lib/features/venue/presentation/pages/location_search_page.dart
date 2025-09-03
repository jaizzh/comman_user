// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/venue/presentation/model/location_data.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/features/venue/presentation/model/popular_location_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  List filteredList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    filteredList = locations;
  }

  void filterSearch(String query) {
    List results = [];
    if (query.isEmpty) {
      results = [];
    } else {
      results = locations
          .where((location) =>
              location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredList = results;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGold,
        surfaceTintColor: AppColors.lightGold,
        elevation: 0,
        title: Row(
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
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightGold, Colors.white],
            stops: [0.2, 0.40],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchTextfield(screenHeight, searchController),
              Expanded(
                child: searchController.text.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_searching,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Auto Detect My Location",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          text("POPULAR CITIES"),
                          const SizedBox(height: 10),
                          SizedBox(height: 300, child: popularVenues()),
                          text("OTHER CITIES"),
                          const SizedBox(height: 10),
                          Expanded(child: allLocation())
                        ],
                      )
                    : filteredList.isEmpty
                        ? SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                LottieBuilder.asset(
                                  "assets/json/No-Data.json",
                                  width: 200,
                                ),
                                text("Sorry! No result found"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "We could no find any results. Please try searching some other terms",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              text("Results"),
                              const SizedBox(height: 10),
                              Expanded(child: filterVenues()),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextfield(
    double screenHeight,
    TextEditingController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white.withOpacity(0.5),
      ),
      child: TextField(
        controller: controller,
        onChanged: filterSearch,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          hintText: "Search for your city",
          hintStyle: GoogleFonts.poppins(
            color: AppColors.black.withOpacity(0.5),
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget filterVenues() {
    return ListView.builder(
      itemCount: min(filteredList.length, 5),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context, filteredList[index]);
          },
          child: ListTile(title: text(filteredList[index])),
        );
      },
    );
  }

  Widget allLocation() {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.pop(context, locations[index]);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: AppColors.black.withOpacity(0.1),
              width: double.infinity,
              child: Text(
                locations[index],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ));
      },
    );
  }

  Widget popularVenues() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1),
        itemCount: popularLocations.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, filteredList[index]);
            },
            child: Card(
              elevation: 5,
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      popularLocations[index],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  Widget text(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: AppColors.navy,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
