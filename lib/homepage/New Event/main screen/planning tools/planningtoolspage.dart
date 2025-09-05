import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/images_upload/imageupload.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/ltinerary/ltinerary.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/grouping/grouping.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/tasklist/tasklist.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/timeline/timelinepage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/singleeventdashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class planningtools extends StatefulWidget {
  const planningtools({super.key});

  @override
  State<planningtools> createState() => _planningtoolsState();
}

class _planningtoolsState extends State<planningtools> {
  int index = 1;
  final pages = [
    timeline(),
    tasklist(),
    ltinerarypage(),
    ContactPickerApp(),
    ImagePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: AppColors.boxlightcolor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
             onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => singleventdashboard()),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Planning Tools",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
         onTap: (i) => setState(() => index = i),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          useLegacyColorScheme: true,
          backgroundColor: AppColors.boxlightcolor,
          //  backgroundColor: Colors.white38,
            selectedItemColor:AppColors.buttoncolor, // premium red
            unselectedItemColor: Colors.black54,
            selectedLabelStyle:GoogleFonts.sahitya( fontWeight: FontWeight.bold,
              fontSize: 16,),
            unselectedLabelStyle: GoogleFonts.sahitya(fontSize: 14.0,fontWeight: FontWeight.bold),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.timeline_rounded), label: 'Timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.view_list_rounded), label: 'Tasklist'),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_add_circle_rounded), label: 'Itinerary'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_2), label: 'Grouping'),
          BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: "Images Upload",
              ),
        ],
 ),
    );
  }
}