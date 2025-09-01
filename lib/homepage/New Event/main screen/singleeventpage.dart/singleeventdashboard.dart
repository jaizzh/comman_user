// ignore_for_file: prefer_const_constructors
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/planningtoolspage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/majorcont.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/colors.dart';

class singleventdashboard extends StatefulWidget {
  const singleventdashboard({super.key});

  @override
  State<singleventdashboard> createState() => _singleventdashboardState();
}

class _singleventdashboardState extends State<singleventdashboard> {
  bool planexpand = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.boxlightcolor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MainPage()),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Event Schedule",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                mainconter(),
                additional(context),
                SizedBox(height: 14.0),
                planning(),
                SizedBox(height: 14.0),
                majorcont(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget labell(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: AppColors.buttoncolor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
  Widget mainconter() {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.boxlightcolor,
                  AppColors.boxboxlight,
                  Colors.white,
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 16.0),
              labell("Venue / Vendors"),
              SizedBox(height: 20.0),
              Row(
                children: [
                  venuevendor(
                    pathds: "assets/images/venueor.png",
                    namevenue: "Venue",
                    uptohow: "upto 100+ Venues",
                    stars: '⭐⭐⭐⭐⭐',
                  ),
                  venuevendor(
                    pathds: "assets/images/vendoror.png",
                    namevenue: "Vendors",
                    uptohow: "upto 500+ Vendors",
                    stars: '⭐⭐⭐⭐',
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              labell("Additional Features"),
            ],
          ),
        ),
      ],
    );
  }

  Widget planning() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => planningtools()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Planning Tools",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttoncolor,
                  ),
                ),
                SizedBox(width: 4.0),
                Icon(Icons.construction, color: AppColors.buttoncolor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget venuevendor({
    required String pathds,
    required String stars,
    required String namevenue,
    required String uptohow,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.250,
        width: MediaQuery.of(context).size.width * 0.350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 14.0),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(pathds)),
              ),
            ),
            Text(stars, style: TextStyle(fontSize: 10.0)),
            SizedBox(height: 6.0),
            Text(
              uptohow,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.phone, size: 22.0, color: AppColors.buttoncolor),
                Icon(Icons.email, size: 22.0, color: AppColors.buttoncolor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget additional(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            addFeature(
              path: "assets/pngimages/gift.png",
              words: "Gift Registry",
              bgColor: AppColors.boxlightcolor.withOpacity(0.3),
            ),
            addFeature(
              path: "assets/pngimages/cohost.png",
              words: "Co-Hosts",
              bgColor: AppColors.boxlightcolor.withOpacity(0.3),
            ),
            addFeature(
              path: "assets/pngimages/invite.png",
              words: "Invitations",
              bgColor: AppColors.boxlightcolor.withOpacity(0.3),
            ),
            addFeature(
              path: "assets/pngimages/budget.png",
              words: "Expense Report",
              bgColor: AppColors.boxlightcolor.withOpacity(0.3),
            ),
            addFeature(
              path: "assets/pngimages/videoinvite.png",
              words: "Video Invite",
              bgColor: AppColors.boxlightcolor.withOpacity(0.3),
            ),
            addFeature(
              path: "assets/images/ewr.png",
              words: "Money Gift",
              bgColor: AppColors.boxlightcolor.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget addFeature({
    required String path,
    required String words,
    required Color bgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: 95,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    path,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    words,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
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
  // Widget planningtools(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(6.0),
  //         boxShadow: [
  //           BoxShadow(
  //             spreadRadius: 1,
  //             blurRadius: 1,
  //             color: Colors.black38,
  //           )
  //         ]
  //       ),
  //       child: Column(
  //         children: [
  //           expandtools(planningtoolname: "Timeline"),
  //           expandtools(planningtoolname: "Task List"),
  //           expandtools(planningtoolname: "itinerary"),
  //           expandtools(planningtoolname: "Grouping"),
  //           expandtools(planningtoolname: "Money Gift"),

  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget expandtools({required String planningtoolname}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              planningtoolname,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColors.buttoncolor,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 24.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
