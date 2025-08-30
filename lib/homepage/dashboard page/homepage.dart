import 'package:common_user/common/colors.dart';
import 'package:common_user/common/razorpay/razorbool.dart';
import 'package:common_user/homepage/New%20Event/1st%20screen/eventplan.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
import 'package:common_user/homepage/dashboard%20page/neweventcard.dart';
import 'package:common_user/homepage/dashboard%20page/promocard.dart';
import 'package:common_user/homepage/dashboard%20page/vendorlist.dart';
import 'package:common_user/homepage/dashboard%20page/venuelist.dart';
import 'package:common_user/homepage/profilepage/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homepage extends StatefulWidget {
  const homepage({super.key,});

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
     appBar: AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor:Colors.white,
  backgroundColor: AppColors.boxlightcolor,
    elevation: 2,
  centerTitle: false,          
  titleSpacing: 0, 
  toolbarHeight: MediaQuery.of(context).size.height *0.06,            
  title: Row(
    children: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu_rounded, size: 20),
        color: Colors.black87,
      ),
      SizedBox(
        height: 28,
        width: 28,
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
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppColors.buttoncolor,
          ),
        ),
      ),
    ],
  ),
  actions: [
    IconButton(
      onPressed: () {},
      tooltip: 'Notifications',
      icon: const Icon(Icons.notifications_none_rounded, size: 22),
      color: Colors.black54,
      splashRadius: 22,
    ),
    Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileDemo()));
        },
        child: Container(
          width: 27.5,
          height: 27.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.boxboxlight,
            border: Border.all(color: AppColors.buttoncolor, width: 2),
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
    ),
  ],
),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.230,
              decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFEDD498),Colors.white,],
                      ),
                      ),
              child:const Column(
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
                    activeColor: Colors.blue,            // expanded active indicator color
                    inactiveColor: Colors.grey,          // small inactive color
                    viewportFraction: 0.92,
                    cardHeightFactor: 0.3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0,),
           choosecont(),
           SizedBox(height: 10,),
              ValueListenableBuilder<bool>(
            valueListenable: EventGate.showEventSummary,
            builder: (context, visible, _) {
              if (!visible) return const SizedBox.shrink();
              return  EventSummaryCard(
         eventName: 'Akshaya & Virat Wedding',
         eventType: 'Reception',
         endsAt: DateTime.now().add(const Duration(days: 2, hours: 5, minutes: 30)),
         invitedCount: 250,
         totalGuests: 500,
                // your props...
              );
            },
          ), SizedBox(height: 10.0,),
          venues(),
           vendorlist(),
           allvendors(),
           
          ],
        ),
              ),
      ),
    );
  }

Widget choosecont(){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          choosecreate(onTapper: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => eventplan()));
          }, pather: 'assets/images/chat1.png', name: 'Create New Event'),
          choosecreate(onTapper: (){}, pather: 'assets/images/chat2.png', name: 'View All Invites'),
          choosecreate(onTapper: (){}, pather: 'assets/images/chat3.png', name: 'Gift Purchases'),
           choosecreate(onTapper: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => demopage() ));
           }, pather: 'assets/images/chat4.png', name: "My Events (Locked)"),
      ],
    ),
  );
}
Widget choosecreate({required void Function() onTapper,required String name, required String pather}){
  return GestureDetector(
    onTap:onTapper,
    child: Container(
     width:  MediaQuery.of(context).size.width *0.20,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              height: MediaQuery.of(context).size.height *0.060,
              width:  MediaQuery.of(context).size.width *0.20,
              pather
              ),
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            name,style: TextStyle(fontSize:11.0,fontWeight: FontWeight.bold,color:Colors.black,height: 1.0),),
        ],
      ),
    ),
  );
}

Widget venues() {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Venues",
              style: GoogleFonts.sahitya(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: AppColors.buttoncolor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),

        // 👇 Direct Container with height
        Container(
          height: MediaQuery.of(context).size.height * 0.19,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mandapam.length,
            itemBuilder: (context, index) {
              final values = mandapam[index];
              return Padding(
                padding: const EdgeInsets.only(right: 14.0,bottom: 10.0),
                child: Container(
                                    width: MediaQuery.of(context).size.width * 0.35,
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
                                        Stack(
                                          children: [
                                            AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Image.asset(
                                              values["imagePath"],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                         Positioned(
                                      right: 10,
                                      top: 5,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                      child: Text(values["rating"],style: TextStyle(fontSize: 10.0,color: Colors.white,fontWeight: FontWeight.bold),),
                                    )),
                                          ], 
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 4.0,),
                                              Text(
                                                values["venueName"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                               ), 
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // location
                                      const Icon(Icons.location_on, size: 12,color: Colors.black54,),
                                      Text(
                                        values["location"],
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),                  
                                  SizedBox(height: 3.0,),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  "₹${values["rentPerDay"]}/day",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF9A2143),
                                                    fontWeight: FontWeight.bold,
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
Widget vendorlist(){
  return Container(
    child: Column(
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vendor Categories",
                 style: GoogleFonts.sahitya(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: AppColors.buttoncolor,
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
    child: Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final sinvendor = vendorslister[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: MediaQuery.of(context).size.height * 0.1,
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
                              horizontal: 14.0, vertical: 12),
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
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: const Color(0xFF2B2730),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                sinvendor["about"] ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black87.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(sinvendor["vendorImage"] ??
                                  "assets/images/catering.jpg"),
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
    ),
  );
}
 Widget allvendors(){
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      height: MediaQuery.of(context).size.height *0.03,
      width:  double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.black38,
          )
        ]
      ),
      child: Center(
        child: Text("All Vendors",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),),
      ),),);}}
