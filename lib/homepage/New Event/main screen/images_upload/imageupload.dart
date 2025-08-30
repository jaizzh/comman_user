import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/images_upload/second_Screen.dart';
import 'package:flutter/material.dart';
// your upload screen
import 'package:common_user/homepage/New Event/main screen/images_upload/first_screen.dart';
import 'package:google_fonts/google_fonts.dart';
// ^ if the path has spaces, prefer renaming folders without spaces.

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      initialIndex: 1, // default select: "View"
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Material(
                // gives proper ink & indicator rendering
                color: Colors.transparent,
                child: SizedBox(
                  height: 50.0,
                  child: TabBar(
                    tabs: const  [
                      Tab(child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Upload"),SizedBox(width: 4.0,),Icon(Icons.cloud_upload_sharp,)],) ,),
                      Tab(child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("View"),SizedBox(width: 4.0,), Icon(Icons.remove_red_eye_rounded,)],) ,),
                    ],
                    isScrollable: false,
                    indicatorWeight: 2,           
                    unselectedLabelColor: Colors.grey,
                    labelColor: AppColors.buttoncolor,
                    indicatorColor: AppColors.buttoncolor,
                    unselectedLabelStyle: GoogleFonts.sahitya(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.black54),
                    labelStyle: GoogleFonts.sahitya(fontSize: 16.0,fontWeight: FontWeight.bold,color: AppColors.buttoncolor),
                  ),
                ),
              ),

              
             const Expanded(
                child: TabBarView(
                  children: [
                    uploadpagee(), 
                    ViewScreenImage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}