// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/data/product_data.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/pages/product_details.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/widgets/map_widget.dart';
import 'package:common_user/features/view_invites/widgets/fullscreenimagegallery.dart';
import 'package:common_user/features/view_invites/widgets/invitation_flipbook_page.dart';
import 'package:common_user/features/view_invites/widgets/videoPlayerdialog.dart';
import 'package:common_user/features/view_invites/widgets/videothumbnail.dart';
import 'package:common_user/features/view_invites/widgets/youtube.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewInvitePage extends StatefulWidget {
  const ViewInvitePage({super.key});

  @override
  State<ViewInvitePage> createState() => _ViewInvitePageState();
}

class _ViewInvitePageState extends State<ViewInvitePage> {
  int selectedDayIndex = 0;

  Future<void> downloadFile(String url, String filename) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir:
          '/storage/emulated/0/Download', // or use a directory from path_provider
      fileName: filename,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  final List<DayEvent> timelineEvents = [
    DayEvent(
      dayNumber: "1",
      dayName: "Day 1",
      date: "12/12/2025",
      events: [
        EventDetail(
          name: "Mehandi",
          time: "10:00 AM - 12:00 PM",
          location: "Home",
          icon: Icons.brush,
        ),
        EventDetail(
          name: "Haldi",
          time: "01:00 PM - 03:00 PM",
          location: "Hall",
          icon: Icons.water_drop,
        ),
        EventDetail(
          name: "Sangeet",
          time: "06:00 PM - 09:00 PM",
          location: "Resort",
          icon: Icons.music_note,
        ),
      ],
    ),
    DayEvent(
      dayNumber: "2",
      dayName: "Day 2",
      date: "13/12/2025",
      events: [
        EventDetail(
          name: "Wedding",
          time: "10:00 AM - 01:00 PM",
          location: "Temple",
          icon: Icons.favorite,
        ),
        EventDetail(
          name: "Reception",
          time: "07:00 PM - 10:00 PM",
          location: "Mahal",
          icon: Icons.celebration,
        ),
      ],
    ),
    DayEvent(
      dayNumber: "3",
      dayName: "Day 3",
      date: "14/12/2025",
      events: [
        EventDetail(
          name: "Lunch",
          time: "12:00 PM - 02:00 PM",
          location: "Home",
          icon: Icons.restaurant,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.paper,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: screenHeight * 0.3,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.paper,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/inviter5.jpg",
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eventholderDetails(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                viewInvite(context),
                SizedBox(height: screenHeight * 0.02),
                eventDetails(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Event Timeline",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${timelineEvents.length} Days",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                buildModernHorizontalTimeline(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Location",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Card(
                  elevation: 5,
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.15,
                    child: const MapWidget(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Gift Registry",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                giftRegistry(screenWidth, screenHeight, productcategories[1]),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Cash log",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                casLog(),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Photo Gallery",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                photoGallery(context),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Video Gallery",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                videoGallery(),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Youtube Videos",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                youtubeVideosSection(),
                SizedBox(height: screenHeight * 0.02),
                liveStreamingSection(),
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildModernHorizontalTimeline(double width, double height) {
    return Column(
      children: [
        // Day navigation container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timelineEvents[selectedDayIndex].dayName,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Navigate to next day, loop back to first if at the end
                    selectedDayIndex =
                        (selectedDayIndex + 1) % timelineEvents.length;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        // Selected day details card
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: buildDayDetailsCard(
            width,
            height,
            timelineEvents[selectedDayIndex],
            key: ValueKey(selectedDayIndex),
          ),
        ),
      ],
    );
  }

  Widget buildDayDetailsCard(
    double width,
    double height,
    DayEvent dayEvent, {
    Key? key,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayEvent.dayName,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        dayEvent.date,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.event_available,
                        color: Colors.white,
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${dayEvent.events.length}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Events list
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: dayEvent.events.asMap().entries.map((entry) {
                final index = entry.key;
                final event = entry.value;
                return buildModernEventCard(
                  event,
                  index,
                  dayEvent.events.length,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildModernEventCard(
    EventDetail event,
    int index,
    int totalEvents,
  ) {
    final isLast = index == totalEvents - 1;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              event.icon,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          // Event details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 11,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            event.time,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 3),
                    Text(
                      event.location,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget viewInvite(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InvitationFlipBookPage()),
        );
      },
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              const Icon(Icons.card_giftcard, color: AppColors.primary),
              const SizedBox(width: 10),
              Text(
                "View Invitation",
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventholderDetails(double width) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.person,
            color: AppColors.paper,
          ),
        ),
        SizedBox(width: width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vinith",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Event Holder",
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.phone,
            color: AppColors.paper,
          ),
        ),
        SizedBox(width: width * 0.03),
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.message,
            color: AppColors.paper,
          ),
        )
      ],
    );
  }

  Widget eventDetails(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vinith Wedding",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Wedding",
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: height * 0.01),
        details(
          Icons.calendar_today_rounded,
          "  Date",
          "12/12/2025",
          Colors.blue,
        ),
        details(
          Icons.dining,
          "  Food Type",
          "Non-Veg",
          Colors.orange,
        ),
        details(
          Icons.location_on,
          "  Location",
          "Sarasvathi Mahal",
          Colors.red,
        ),
        details(
          Icons.date_range,
          "  Invited By",
          "Vinith",
          Colors.purple,
        ),
      ],
    );
  }

  Widget details(IconData icon, String detail, String subdetail, Color color) {
    return Card(
      elevation: 2,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            Text(detail),
            const Spacer(),
            Text(subdetail),
          ],
        ),
      ),
    );
  }
}

Widget giftRegistry(
  double screenWidth,
  double screenHeight,
  final ProductCategory categories,
) {
  final furnitures = categories.products;
  return SizedBox(
    height: screenHeight / 3.7,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: furnitures.length,
      itemBuilder: (context, index) {
        final product = furnitures[index];
        return GestureDetector(
          onTap: () {
            navigateWithSlide(context,
                ProductDetails(product: product, categories: categories));
          },
          child: Card(
            color: AppColors.white,
            margin: const EdgeInsets.only(right: 12),
            elevation: 2,
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight / 8,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        fit: BoxFit.cover,
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
                          Text(product.name,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: screenHeight * 0.005),
                          Text('₹${product.price}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary)),
                          SizedBox(height: screenHeight * 0.005),
                          Text(product.description,
                              style: GoogleFonts.poppins(
                                  fontSize: 10, color: AppColors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  // Full-width bottom Participate button with merged curved styling
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Icon(Icons.card_giftcard,
                                          color: AppColors.primary, size: 38),
                                    ),
                                    const SizedBox(height: 12),
                                    Center(
                                      child: Text(
                                        "Participate in Gift Registry",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: AppColors.primary),
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    const Divider(),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.shopping_bag,
                                            color: Colors.orange, size: 18),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(product.name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.currency_rupee,
                                            color: Colors.red, size: 18),
                                        const SizedBox(width: 5),
                                        Text('₹${product.price}',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: Colors.red)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Are you sure you want to participate and add this product?",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13, color: Colors.black54),
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Cancel',
                                              style: GoogleFonts.poppins()),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 10),
                                          ),
                                          child: Text('Yes',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Successfully participated!',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Participate',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
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

Widget casLog() {
  return Card(
    elevation: 2,
    child: Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        children: [
          Text(
            "Enter the amount here before sending payment to the event holder.",
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.paper),
            child: const TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.money),
                  hintText: "Enter the amount"),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary),
              child: Center(
                child: Text(
                  "Pay",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget photoGallery(BuildContext context) {
  final List<String> images = [
    "assets/images/inviter5.jpg",
    "assets/images/inviter2.jpg",
    "assets/images/inviter3.jpg",
    "assets/images/inviter4.jpg",
    "assets/images/inviter6.jpg",
    // Add your image assets
  ];
  return SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenImageGallery(
                  imageUrls: images,
                  initialIndex: index,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(images[index]), fit: BoxFit.cover)),
            ),
          ),
        );
      },
    ),
  );
}

Widget videoGallery() {
  // Replace with your actual video asset list
  final List<String> videoAssets = [
    "assets/images/video.mp4",
    "assets/images/video.mp4",
    "assets/images/video.mp4",
  ];

  return SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videoAssets.length,
      itemBuilder: (context, index) {
        String videoPath = videoAssets[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenVideoPlayer(videoPath: videoPath),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                width: 150,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: VideoThumbnail(videoPath: videoPath),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.download, color: Colors.white),
                  onPressed: () async {
                    // Implement download logic here
                    // Example: Call a custom download function
                    // await (videoPath);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Download started!",
                            style: GoogleFonts.poppins()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget youtubeVideosSection() {
  final List<String> youtubeUrls = [
    "https://www.youtube.com/watch?v=5qap5aO4i9A",
    "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
    "https://www.youtube.com/watch?v=2Vv-BfVoq4g",
    "https://www.youtube.com/watch?v=VbfpW0pbvaU",
  ];

  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: youtubeUrls.length,
      itemBuilder: (context, index) {
        final videoId = YoutubePlayer.convertUrlToId(youtubeUrls[index]);
        final controller = YoutubePlayerController(
          initialVideoId: videoId!,
          flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
        );

        return Container(
          width: 180,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      YoutubeVideoPlayerPage(controller: controller),
                ),
              );
            },
            child: Stack(
              children: [
                YoutubePlayer(
                    controller: controller, showVideoProgressIndicator: true),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget liveStreamingSection() {
  const liveUrl =
      "https://www.youtube.com/watch?v=aqz-KE-bpKQ"; // example NASA live
  final liveVideoId = YoutubePlayer.convertUrlToId(liveUrl);
  final liveController = YoutubePlayerController(
    initialVideoId: liveVideoId!,
    flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Live Streaming",
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 10),
      Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: YoutubePlayer(
            controller: liveController,
            showVideoProgressIndicator: true,
          ),
        ),
      ),
    ],
  );
}

// Data models
class DayEvent {
  final String dayNumber;
  final String dayName;
  final String date;
  final List<EventDetail> events;

  DayEvent({
    required this.dayNumber,
    required this.dayName,
    required this.date,
    required this.events,
  });
}

class EventDetail {
  final String name;
  final String time;
  final String location;
  final IconData icon;

  EventDetail({
    required this.name,
    required this.time,
    required this.location,
    required this.icon,
  });
}
