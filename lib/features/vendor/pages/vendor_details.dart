// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/model/makeup_model.dart';
import 'package:common_user/features/vendor/model/music_model.dart';
import 'package:common_user/features/vendor/model/photo_model.dart';
import 'package:common_user/features/vendor/pages/enquiry_page.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/pages/check_availability.dart';
import 'package:common_user/features/venue/presentation/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorDetails extends StatefulWidget {
  final String vendorType; // 'photo', 'makeup', 'music'
  final dynamic vendorData;
  final List<dynamic> vendorDatas; // one vendor object

  const VendorDetails({
    super.key,
    required this.vendorType,
    required this.vendorData,
    required this.vendorDatas,
  });

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails>
    with TickerProviderStateMixin {
  bool isLiked = false;
  bool showAppBar = false;
  double sheetSize = 0.6;
  late AnimationController _appBarAnimationController;
  late Animation<double> _appBarOpacityAnimation;

  // We keep controller but use NotificationListener for extent changes.
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    _appBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _appBarOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _appBarAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Removed addListener on controller because we're handling extent via NotificationListener.
  }

  @override
  void dispose() {
    _appBarAnimationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  double _getBorderRadius() {
    if (sheetSize >= 0.95) {
      return 0.0;
    } else {
      double progress = ((sheetSize - 0.6) / (0.95 - 0.6)).clamp(0.0, 1.0);
      double easedProgress = 1.0 - (1.0 - progress) * (1.0 - progress);
      return 25.0 * (1.0 - easedProgress);
    }
  }

  @override
  Widget build(BuildContext context) {
    String name, image, location, price;
    double rating;
    List<String> services = [];
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isTablet = screenWidth > 600;

    switch (widget.vendorType) {
      case 'photo':
        final p = widget.vendorData as PhotoModel;
        name = p.name;
        image = p.image;
        location = p.location;
        price = p.price;
        rating = p.rating;
        break;
      case 'makeup':
        final m = widget.vendorData as MakeupArtistModel;
        name = m.name;
        image = m.image;
        location = m.location;
        price = m.price;
        rating = m.rating;
        services = m.services;
        break;
      case 'music':
        final mus = widget.vendorData as MusicDanceModel;
        name = mus.name;
        image = mus.image;
        location = mus.location;
        price = mus.price;
        rating = mus.rating;
        break;
      default:
        name = "";
        image = "";
        location = "";
        price = "";
        rating = 0;
    }

    return Scaffold(
      appBar: showAppBar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AnimatedBuilder(
                animation: _appBarOpacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _appBarOpacityAnimation.value,
                    child: AppBar(
                      backgroundColor: AppColors.white,
                      surfaceTintColor: AppColors.white,
                      elevation: 0,
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      title: Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 20 : 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? AppColors.primary : Colors.black,
                            size: isTablet ? 24 : 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Colors.black,
                            size: isTablet ? 24 : 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : null,
      body: Stack(
        children: [
          // Background Image Container - Responsive height
          Container(
            width: double.infinity,
            height: screenHeight * (isTablet ? 0.4 : 0.5),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Top Navigation Bar - Responsive positioning
          // IMPORTANT: Positioned must be direct child of Stack (can't wrap Positioned in other widgets)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: showAppBar ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: isTablet ? 22 : 18,
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: isTablet ? 22 : 18,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: isTablet ? 22 : 18,
                        backgroundColor: Colors.white.withOpacity(0.6),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? AppColors.primary : Colors.black,
                            size: isTablet ? 22 : 18,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      CircleAvatar(
                        radius: isTablet ? 22 : 18,
                        backgroundColor: Colors.white.withOpacity(0.6),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Colors.black,
                            size: isTablet ? 22 : 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Draggable Bottom Sheet - Responsive sizing
          SafeArea(
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                // Update sheetSize and appBar visibility based on extent
                setState(() {
                  sheetSize = notification.extent;
                });

                bool shouldShowAppBar = notification.extent >= 0.85;
                if (shouldShowAppBar != showAppBar) {
                  setState(() {
                    showAppBar = shouldShowAppBar;
                  });

                  if (showAppBar) {
                    _appBarAnimationController.forward();
                  } else {
                    _appBarAnimationController.reverse();
                  }
                }
                return true;
              },
              child: DraggableScrollableSheet(
                controller: _controller,
                initialChildSize: isTablet ? 0.65 : 0.6,
                minChildSize: isTablet ? 0.65 : 0.6,
                maxChildSize: 1.0,
                snap: true,
                snapSizes: isTablet ? const [0.65, 1.0] : const [0.6, 1.0],
                snapAnimationDuration: const Duration(milliseconds: 200),
                builder: (context, scrollController) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutQuart,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_getBorderRadius()),
                        topRight: Radius.circular(_getBorderRadius()),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, -8),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: CustomScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        // Drag Handle
                        if (sheetSize < 0.99)
                          SliverToBoxAdapter(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                              ),
                              child: Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: sheetSize > 0.95 ? 60 : 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: sheetSize > 0.95
                                        ? Colors.grey[400]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Content
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              // Owner section
                              _buildOwner(screenWidth, isTablet),
                              SizedBox(height: screenHeight * 0.02),

                              // Venue Title
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: screenWidth / 2,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      name,
                                      style: GoogleFonts.poppins(
                                        fontSize: isTablet ? 22 : 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: isTablet ? 18 : 14,
                                      ),
                                      SizedBox(width: screenWidth * 0.01),
                                      Text(
                                        rating.toString(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.orange,
                                          fontSize: isTablet ? 16 : 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        " (410 Reviews)",
                                        style: GoogleFonts.poppins(
                                          fontSize: isTablet ? 16 : 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Location
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColors.primary,
                                    size: isTablet ? 18 : 14,
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Flexible(
                                    child: Text(
                                      location,
                                      style: GoogleFonts.poppins(
                                        fontSize: isTablet ? 14 : 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              // Rating and Price Row
                              SizedBox(height: screenHeight * 0.015),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSectionTitle(
                                      'Per Day Price Estimate', isTablet),
                                  Text(
                                    "Pricing Info",
                                    style: GoogleFonts.poppins(
                                        fontSize: isTablet ? 17 : 12,
                                        color: AppColors.primary),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              // Info Row
                              _buildInfoRow(
                                screenWidth,
                                screenHeight,
                                isTablet,
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              // About Section
                              _buildSectionTitle('About', isTablet),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[700],
                                  fontSize: isTablet ? 16 : 14,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.025),

                              // Amenities Section
                              _buildSectionTitle(
                                  'Services Offerd by $name', isTablet),
                              SizedBox(height: screenHeight * 0.015),
                              _buildAmenities(
                                screenWidth,
                                screenHeight,
                                isTablet,
                                services,
                              ),
                              SizedBox(height: screenHeight * 0.025),

                              // Photos Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSectionTitle('Photos', isTablet),
                                  Text(
                                    "See more",
                                    style: GoogleFonts.poppins(
                                        fontSize: isTablet ? 15 : 10,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              _buildPhotoGallery(screenHeight, isTablet, image),
                              SizedBox(height: screenHeight * 0.025),
                              //video Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSectionTitle('Videos', isTablet),
                                  Text(
                                    "See more",
                                    style: GoogleFonts.poppins(
                                        fontSize: isTablet ? 15 : 10,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              _buildVideoGallery(screenHeight, isTablet, image),
                              SizedBox(height: screenHeight * 0.025),
                              _buildSectionTitle(
                                  'Product Offerd by $name', isTablet),
                              SizedBox(height: screenHeight * 0.025),
                              // Address Location
                              _buildSectionTitle('Address Location', isTablet),
                              SizedBox(height: screenHeight * 0.015),
                              Card(
                                elevation: 5,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: screenHeight * 0.15,
                                  child: const MapWidget(),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),

                              // Google Ad
                              _buildGoogleAd(screenHeight),
                              SizedBox(height: screenHeight * 0.025),

                              // Similar Venues
                              _buildSectionTitle('Similar Venues', isTablet),
                              SizedBox(height: screenHeight * 0.015),
                              _buildSimilarVenues(
                                screenWidth,
                                screenHeight,
                                isTablet,
                              ),

                              SizedBox(
                                height: screenHeight * 0.12,
                              ), // Bottom padding
                            ]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom fixed action bar — use Alignment.bottomCenter
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: screenHeight / 10,
              color: AppColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 18 : 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.paper.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        price,
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 18 : 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EnquiryPage()),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Check Availability",
                          style: GoogleFonts.poppins(
                            fontSize: isTablet ? 18 : 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isTablet) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: isTablet ? 18 : 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildOwner(double screenWidth, bool isTablet) {
    return Row(
      children: [
        CircleAvatar(
          radius: isTablet ? 28 : 22,
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.person,
            color: AppColors.white,
            size: isTablet ? 28 : 22,
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jegathish Vinith",
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 18 : 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "owner",
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 14 : 10,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: isTablet ? 22 : 18,
          backgroundColor: AppColors.paper,
          child: Icon(
            Icons.message,
            color: AppColors.primary,
            size: isTablet ? 22 : 18,
          ),
        ),
        SizedBox(width: screenWidth * 0.025),
        CircleAvatar(
          radius: isTablet ? 22 : 18,
          backgroundColor: AppColors.paper,
          child: Icon(
            Icons.call,
            color: AppColors.primary,
            size: isTablet ? 22 : 18,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(double screenWidth, double screenHeight, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          _buildInfoCard("₹ 30000 per day", "Pre-Wedding Shoot", isTablet),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          _buildInfoCard("₹ 50000 per day", "Photo + Video", isTablet),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subtitle,
          style: GoogleFonts.poppins(fontSize: isTablet ? 14 : 12),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 20 : 15,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenities(
    double screenWidth,
    double screenHeight,
    bool isTablet,
    List<String> services,
  ) {
    if (services.isEmpty) {
      return Text(
        "No services available",
        style: GoogleFonts.poppins(
          fontSize: isTablet ? 14 : 12,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isTablet ? 4 : 3;
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 10) / crossAxisCount;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: services.map((service) {
            return Container(
              width: itemWidth,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Center(
                child: Text(
                  service,
                  style: GoogleFonts.poppins(
                    fontSize: isTablet ? 14 : 12,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPhotoGallery(double screenHeight, bool isTablet, String image) {
    return SizedBox(
      height: isTablet ? 140 : 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: isTablet ? 140 : 100,
            height: isTablet ? 140 : 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoGallery(double screenHeight, bool isTablet, String image) {
    return SizedBox(
      height: isTablet ? 140 : 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: isTablet ? 140 : 100,
            height: isTablet ? 140 : 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              // 👈 important, center la irukka
              child: CircleAvatar(
                radius: isTablet ? 20 : 16, // 👈 fix size
                backgroundColor: Colors.black.withOpacity(0.5), // optional
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: isTablet ? 22 : 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoogleAd(double screenHeight) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: Card(
        elevation: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
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
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontSize: 10,
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

  Widget _buildSimilarVenues(
    double screenWidth,
    double screenHeight,
    bool isTablet,
  ) {
    // filter list -> exclude current vendor
    final filteredVendors = widget.vendorDatas.where((vendor) {
      return vendor != widget.vendorData; // skip current vendor
    }).toList();

    return SizedBox(
      height: isTablet ? 260 : 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredVendors.length > 5 ? 5 : filteredVendors.length,
        itemBuilder: (context, index) {
          String name, image, price;
          double rating;

          switch (widget.vendorType) {
            case 'photo':
              final photo = filteredVendors[index] as PhotoModel;
              name = photo.name;
              image = photo.image;
              price = photo.price;
              rating = photo.rating;
              break;
            case 'makeup':
              final makeup = filteredVendors[index] as MakeupArtistModel;
              name = makeup.name;
              image = makeup.image;
              price = makeup.price;
              rating = makeup.rating;
              break;
            case 'music':
              final music = filteredVendors[index] as MusicDanceModel;
              name = music.name;
              image = music.image;
              price = music.price;
              rating = music.rating;
              break;
            default:
              return const SizedBox();
          }

          return GestureDetector(
            onTap: () {
              navigateWithSlide(
                context,
                VendorDetails(
                  vendorType: widget.vendorType,
                  vendorData: filteredVendors[index], // use filtered list
                  vendorDatas: widget.vendorDatas,
                ),
              );
            },
            child: Container(
              width: isTablet ? 180 : 140,
              margin: const EdgeInsets.only(right: 12),
              child: Card(
                color: AppColors.white,
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      height: isTablet ? 140 : 100,
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
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: isTablet ? 14 : 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                rating.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontSize: isTablet ? 14 : 12,
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
                              name,
                              style: GoogleFonts.poppins(
                                fontSize: isTablet ? 14 : 12,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              price,
                              style: GoogleFonts.poppins(
                                fontSize: isTablet ? 14 : 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: isTablet ? 12 : 10,
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    "hall",
                                    style: GoogleFonts.poppins(
                                      fontSize: isTablet ? 12 : 10,
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
