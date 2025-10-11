// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/product/data/product_data.dart';
import 'package:common_user/features/product/model/product_model.dart';
import 'package:common_user/features/product/pages/product_details.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/venue/presentation/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewInvitePage extends StatefulWidget {
  const ViewInvitePage({super.key});

  @override
  State<ViewInvitePage> createState() => _ViewInvitePageState();
}

class _ViewInvitePageState extends State<ViewInvitePage> {
  int selectedDayIndex = 0;

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
                    height: screenHeight * 0.10,
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
                giftRegistry(screenWidth, screenHeight, productcategories[1])
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
    height: screenHeight / 4.5,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: furnitures.length,
      itemBuilder: (context, index) {
        final product = furnitures[index];
        return GestureDetector(
          onTap: () {
            navigateWithSlide(
                context,
                ProductDetails(
                  product: product,
                  categories: categories,
                ));
          },
          child: Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              color: AppColors.white,
              elevation: 2,
              child: Column(
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
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              product.id.toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.orange,
                                fontSize: 12,
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
                            product.name,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            product.price.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_city,
                                size: 10,
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  product.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
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
