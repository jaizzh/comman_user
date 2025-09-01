import 'package:common_user/homepage/New%20Event/1st%20screen/eventplan.dart';
import 'package:common_user/homepage/dashboard%20page/promocard.dart';
import 'package:common_user/homepage/dashboard%20page/vendorlist.dart';
import 'package:common_user/homepage/dashboard%20page/venuelist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/colors.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Color> _cardGradient(int index) {
    switch (index % 5) {
      case 0:
        return [const Color(0xFFFFF3EE), const Color(0xFFFFD7C2)];
      case 1:
        return [const Color(0xFFF9ECF3), const Color(0xFFE9C9DA)];
      case 2:
        return [const Color(0xFFF7ECFF), const Color(0xFFE0CCFF)];
      case 3:
        return [const Color(0xFFEFF6FF), const Color(0xFFCFE0FF)];
      default:
        return [const Color(0xFFFFF8E7), const Color(0xFFFFE7B8)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.boxboxlight, Colors.white],
            stops: const [0.0, 0.40],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  color: AppColors.boxlightcolor,
                ),
                titleBar(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.290,
                  decoration: const BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEDD498), Colors.white],
                    ),
                  ),
                  child: const Column(
                    children: [
                      SixPromoCarousel(
                        images: [
                          "assets/images/promo1.png",
                          "assets/images/temp2.png",
                          "assets/images/temp.jpg",
                          "assets/images/promo1.png",
                          "assets/images/temp.jpg",
                          "assets/images/temp2.png",
                        ],
                        interval: Duration(seconds: 6), // auto slide every 6s
                        activeColor:
                            Colors.blue, // expanded active indicator color
                        inactiveColor: Colors.grey, // small inactive color
                        viewportFraction: 0.92,
                        cardHeightFactor: 0.375,
                      ),
                    ],
                  ),
                ),
                choosecont(),
                const SizedBox(height: 10),
                venues(),
                const SizedBox(height: 10),
                vendorlist(),
                allvendors(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleBar() {
    return Container(
      color: AppColors.boxlightcolor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    onPressed: () {
                      // TODO: open drawer / menu
                    },
                    tooltip: 'Menu',
                    icon: const Icon(Icons.menu_rounded, size: 26),
                    color: Colors.black87,
                    splashRadius: 24,
                  ),
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: Image.asset(
                    "assets/images/mangallogo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    "angal Mall",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.k2d(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: AppColors.buttoncolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: open notifications
                      },
                      tooltip: 'Notifications',
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        size: 28,
                      ),
                      color: Colors.black54,
                      splashRadius: 22,
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.buttoncolor,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.boxboxlight,
                      border: Border.all(
                        color: AppColors.buttoncolor,
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/jega.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget choosecont() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          choosecreate(
            onTapper: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const eventplan()),
              );
            },
            pather: 'assets/images/chat1.png',
            name: 'Create New Event',
          ),
          choosecreate(
            onTapper: () {},
            pather: 'assets/images/chat2.png',
            name: 'View Invites',
          ),
          choosecreate(
            onTapper: () {},
            pather: 'assets/images/chat3.png',
            name: 'Gift Shop',
          ),
        ],
      ),
    );
  }

  Widget choosecreate({
    required void Function() onTapper,
    required String name,
    required String pather,
  }) {
    return GestureDetector(
      onTap: onTapper,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Image.asset(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.20,
              pather,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget venues() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Venues",
                style: GoogleFonts.sahitya(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttoncolor,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blue.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // 👇 Direct Container with height
          Container(
            height: MediaQuery.of(context).size.height * 0.260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mandapam.length,
              itemBuilder: (context, index) {
                final values = mandapam[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 14.0, bottom: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: AppColors.boxboxlight,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          //  offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.asset(
                            values["imagePath"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                values["venueName"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 14),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      values["location"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "₹${values["rentPerDay"]} / day",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9A2143),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget vendorlist() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vendor Categories",
                  style: GoogleFonts.sahitya(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF9A2143), // premium dark rose
                  ),
                ),
              ],
            ),
          ),
          vendors(context),
        ],
      ),
    );
  }

  Widget vendors(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final sinvendor = vendorslister[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      colors: _cardGradient(index),
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      sinvendor["vendorName"]!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF2B2730),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sinvendor["about"] ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black87.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                sinvendor["vendorImage"] ??
                                    "assets/images/catering.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget allvendors() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            const BoxShadow(
                spreadRadius: 1, blurRadius: 1, color: Colors.black38),
          ],
        ),
        child: const Center(
          child: Text(
            "All Vendors",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
