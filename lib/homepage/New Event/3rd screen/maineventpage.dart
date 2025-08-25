import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/eventbox.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/singleeventdashboard.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class demopage extends StatefulWidget {
  const demopage({super.key});

  @override
  State<demopage> createState() => _demopageState();
}

class _demopageState extends State<demopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: AppColors.boxlightcolor,
        elevation: 0,
        centerTitle: true,
          leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
             onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MainPage()),
            ),
          ),
        ),
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
      backgroundColor: Colors.white,
      body: SafeArea(child: Stack(
        children: [
          Positioned(child: Container(
        height: MediaQuery.of(context).size.height *0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.boxlightcolor,
              AppColors.boxboxlight,
              Colors.white,
          ])
        ),
        )),
           Container(
          child: Column(
            children: [
                SizedBox(height: 12.0,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => singleventdashboard() ));
                  },
                  child: eventcard()),
                SizedBox(height: 12.0,),
               // labell("Additional Features"),
            ],
          ),
        ),
        ],
        
      )),
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
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
       ],
     ),
   );

}



