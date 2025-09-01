// ignore_for_file: deprecated_member_use
import 'package:common_user/app_colors.dart';
import 'package:common_user/features/venue/presentation/model/category.dart';
import 'package:common_user/features/venue/presentation/model/category_data.dart';
import 'package:common_user/features/venue/presentation/model/venue.dart';
import 'package:common_user/features/venue/presentation/model/venue_data.dart';
import 'package:common_user/features/venue/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'venue_detailed_screen.dart';

class VenueHome extends StatefulWidget {
  const VenueHome({super.key});

  @override
  State<VenueHome> createState() => _VenueHomeState();
}

class _VenueHomeState extends State<VenueHome> {
  // View toggle state
  bool _isGridView = false;

  // Fixed positions for ads and filters within first 20 venues
  final List<int> _adPositions = [6, 11, 16]; // After venue 3, 8, 13
  final List<int> _filterPositions = [3, 8, 13]; // After venue 6, 11, 16

  // Function to calculate total items including ads and filters
  int getTotalItemCount() {
    int venueCount = venueList.length;

    // Only add ads and filters if venue count > 5
    if (venueCount <= 5) {
      return venueCount;
    }

    // Count how many ads and filters will actually be inserted
    int adsToAdd = 0;
    int filtersToAdd = 0;

    for (int pos in _adPositions) {
      if (pos < venueCount && pos < 20) {
        adsToAdd++;
      }
    }

    for (int pos in _filterPositions) {
      if (pos < venueCount && pos < 20) {
        filtersToAdd++;
      }
    }

    return venueCount + adsToAdd + filtersToAdd;
  }

  // Function to determine item type and get the actual venue index
  Map<String, dynamic> getItemInfo(int index) {
    // If venue count <= 5, only show venues
    if (venueList.length <= 5) {
      return {'type': 'venue', 'venueIndex': index};
    }

    int venueIndex = 0;
    int currentIndex = 0;
    int adsInserted = 0;
    int filtersInserted = 0;

    while (venueIndex < venueList.length) {
      // Check if current position matches our target index
      if (currentIndex == index) {
        return {'type': 'venue', 'venueIndex': venueIndex};
      }
      currentIndex++;
      venueIndex++;

      // Check if we need to insert an ad after this venue
      if (_adPositions.contains(venueIndex - 1) &&
          adsInserted < 3 &&
          venueIndex - 1 < 20) {
        if (currentIndex == index) {
          return {'type': 'ad', 'venueIndex': venueIndex - 1};
        }
        currentIndex++;
        adsInserted++;
      }

      // Check if we need to insert a filter after this venue
      if (_filterPositions.contains(venueIndex - 1) &&
          filtersInserted < 3 &&
          venueIndex - 1 < 20) {
        if (currentIndex == index) {
          return {'type': 'filter', 'venueIndex': venueIndex - 1};
        }
        currentIndex++;
        filtersInserted++;
      }
    }

    // Fallback
    return {'type': 'venue', 'venueIndex': 0};
  }

  // Google Ad Widget - Responsive for both ListView and GridView
  Widget buildGoogleAd() {
    return SizedBox(
      width: double.infinity,
      height: _isGridView ? 50 : 50,
      child: Card(
        elevation: 3,
        child: ClipRRect(
          child: Stack(
            children: [
              Image.asset(
                "assets/venue_images/ads.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 4,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Ads",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: _isGridView ? 10 : 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Filter Details Widget - Responsive for both ListView and GridView
  Widget buildFilterDetails() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _isGridView ? 8 : 8,
        horizontal: _isGridView ? 4 : 0,
      ),
      padding: EdgeInsets.all(_isGridView ? 8 : 15),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Added to prevent overflow
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: AppColors.white,
                size: _isGridView ? 14 : 15,
              ),
              const SizedBox(width: 6),
              Flexible(
                // Changed from Text to handle overflow
                child: Text(
                  'Top Localities',
                  style: GoogleFonts.poppins(
                    fontSize: _isGridView ? 11 : 12,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: _isGridView ? 6 : 10),
          if (_isGridView)
            // Grid view - more compact layout
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: _buildFilterChip('Koodal Nagar')),
                    const SizedBox(width: 4),
                    Expanded(child: _buildFilterChip('Anna Nagar')),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: _buildFilterChip('Ellis Nagar')),
                    const SizedBox(width: 4),
                    Expanded(child: _buildFilterChip('KK Nagar')),
                  ],
                ),
              ],
            )
          else
            // List view - original layout
            Column(
              children: [
                Row(
                  children: [
                    _buildFilterChip('Koodal Nagar'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Anna Nagar'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Ellis Nagar'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildFilterChip('KK Nagar'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Kalavasal'),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(_isGridView ? 4.0 : 8.0),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: _isGridView ? 8 : 10,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // Venue Card Widget - Responsive for both ListView and GridView
  Widget buildVenueCard(int venueIndex) {
    if (venueIndex >= venueList.length) return Container();

    Venue venue = venueList[venueIndex];
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VenueDetailScreen(venue: venue)),
      ),
      child: Card(
        shadowColor: AppColors.lightGold,
        elevation: 5,
        color: AppColors.paper,
        margin: EdgeInsets.symmetric(
          vertical: _isGridView ? 6 : 8,
          horizontal: _isGridView ? 4 : 0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Added to prevent overflow
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.asset(
                venue.image,
                height: _isGridView ? 100 : 160, // Reduced height for grid
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              // Changed from Padding to Flexible to prevent overflow
              child: Padding(
                padding: EdgeInsets.all(_isGridView ? 8 : 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            venue.name,
                            style: GoogleFonts.poppins(
                              fontSize: _isGridView ? 11 : 15,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: _isGridView ? 10 : 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              venue.rating.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: _isGridView ? 9 : 12,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      venue.location,
                      style: GoogleFonts.poppins(
                        fontSize: _isGridView ? 8 : 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: _isGridView ? 3 : 5),
                    Text(
                      venue.price,
                      style: GoogleFonts.poppins(
                        fontSize: _isGridView ? 10 : 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: _isGridView ? 3 : 5),
                    if (_isGridView)
                      // Compact view for grid - reduced spacing
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.group,
                                size: 9,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  venue.capacity,
                                  style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_city,
                                size: 9,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  venue.category,
                                  style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      // Original layout for list view
                      Row(
                        children: [
                          const Icon(
                            Icons.group,
                            size: 12,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            venue.capacity,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.location_city,
                            size: 12,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              venue.category,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black54,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
              "Madurai",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isGridView ? Icons.view_list : Icons.grid_view,
                key: ValueKey(_isGridView),
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightGold, Colors.white],
            stops: [0.0, 0.40],
          ),
        ),
        child: Column(
          children: [
            // Fixed Search Bar Section
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const SearchPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Right side
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
                      padding: const EdgeInsets.all(10),
                      width: screenWidth * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 10),
                          Text(
                            "Find your venues .....",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: screenWidth * 0.11,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary,
                    ),
                    child: const Center(
                      child: Icon(Icons.tune, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top Categories",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Horizontal Categories List
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) {
                            Category cate = categoryList[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(cate.icon),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    cate.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // Initial Ad (always shown)
                      buildGoogleAd(),

                      // Mixed Content List/Grid (Venues + Ads + Filter Details)
                      venueList.isEmpty
                          ? Center(
                              child: Text(
                                'No venues available',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : _isGridView
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                                    // Adjusted childAspectRatio to prevent overflow
                                    childAspectRatio:
                                        screenWidth > 600 ? 0.85 : 0.85,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                  ),
                                  itemCount: getTotalItemCount(),
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> itemInfo = getItemInfo(
                                      index,
                                    );
                                    String itemType = itemInfo['type'];

                                    switch (itemType) {
                                      case 'ad':
                                        return buildGoogleAd();
                                      case 'filter':
                                        return buildFilterDetails();
                                      case 'venue':
                                      default:
                                        return buildVenueCard(
                                          itemInfo['venueIndex'],
                                        );
                                    }
                                  },
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: getTotalItemCount(),
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> itemInfo = getItemInfo(
                                      index,
                                    );
                                    String itemType = itemInfo['type'];

                                    switch (itemType) {
                                      case 'ad':
                                        return buildGoogleAd();
                                      case 'filter':
                                        return buildFilterDetails();
                                      case 'venue':
                                      default:
                                        return buildVenueCard(
                                          itemInfo['venueIndex'],
                                        );
                                    }
                                  },
                                ),

                      // Added bottom padding to prevent overflow
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
