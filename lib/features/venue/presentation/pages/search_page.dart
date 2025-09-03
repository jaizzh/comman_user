// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/features/venue/presentation/model/venue.dart';
import 'package:common_user/features/venue/presentation/model/venue_data.dart';
import 'package:common_user/features/venue/presentation/pages/venue_detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  List<Venue> filteredList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    filteredList = venueList;
  }

  void filterSearch(String query) {
    List<Venue> results = [];
    if (query.isEmpty) {
      results = [];
    } else {
      results = venueList
          .where(
            (venue) =>
                venue.name.toLowerCase().contains(query.toLowerCase()) ||
                venue.location.toLowerCase().contains(query.toLowerCase()),
          )
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
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: searchController.text.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text("Popular Venues in your location"),
                          const SizedBox(height: 10),
                          Expanded(child: popularVenues()),
                        ],
                      )
                    : filteredList.isEmpty
                        ? text("No Result Found")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
          hintText: "Find your venues ...",
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
        var venue = filteredList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VenueDetailScreen(venue: venue),
              ),
            );
          },
          child: ListTile(
            leading: Image.asset(venue.image, width: 50),
            title: Text(venue.name),
            subtitle: Text(venue.location),
            trailing: Text(venue.price),
          ),
        );
      },
    );
  }

  Widget popularVenues() {
    // Filter Madurai venues (case-insensitive)
    List<Venue> maduraiVenues = venueList
        .where((venue) => venue.location.toLowerCase().contains("madurai"))
        .toList();

    return ListView.builder(
      itemCount: min(maduraiVenues.length, 5),
      itemBuilder: (context, index) {
        var venue = maduraiVenues[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VenueDetailScreen(venue: venue),
              ),
            );
          },
          child: ListTile(
            leading: Image.asset(venue.image, width: 50),
            title: Text(venue.name),
            subtitle: Text(venue.location),
            trailing: Text(venue.price),
          ),
        );
      },
    );
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
