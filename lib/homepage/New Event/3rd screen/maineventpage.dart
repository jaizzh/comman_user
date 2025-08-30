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
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,size: 18.0,),
             onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  MainPage()),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Event Schedule",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
         body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none, // positioned boundary out-ஆனாலும் காட்ட
          children: [
            // Main scroll content
            SingleChildScrollView(
              child: Column(
                children: [
                  // HEADER + FLOATING CARD
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Header background
                      Container(
                        height: MediaQuery.of(context).size.height * 0.350,
                        width: double.infinity,
                        decoration:  BoxDecoration(
                          color: AppColors.boxlightcolor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(80, 40),
                            bottomRight: Radius.elliptical(80, 40),
                          ),
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.width * 0.425,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/images/host.png"))
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  



 Container(
      width: MediaQuery.of(context).size.width * 0.475,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.start,
            "We don’t just host events we celebrate life ",style: GoogleFonts.lobster(
             fontSize: 16,
            //fontWeight: FontWeight.bold,
            color: AppColors.buttoncolor,
            letterSpacing: 1,
          ),),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0),
          //   child: Text(" we celebrate life",style: GoogleFonts.greatVibes(
          //      fontSize: 18,
          //     fontWeight: FontWeight.w600,
          //     color: AppColors.buttoncolor,
          //     letterSpacing: 1,
          //   ),),
          // )
          // Heading
          // Text(
          //   "About Us",
          //   style: GoogleFonts.dmSans(
          //     fontSize: 20,
          //     fontWeight: FontWeight.w700,
          //     color: Colors.black,
          //     letterSpacing: 0.8,
          //   ),
          // ),
          // const SizedBox(height: 10),

          // // Description
          // Text(
          //   "We help you host unforgettable events by connecting you "
          //   "with the best venues, vendors, and planners. From weddings "
          //   "to corporate celebrations, our platform ensures a seamless, "
          //   "memorable experience tailored just for you.",
          //   style: GoogleFonts.inter(
          //     fontSize: 12,
          //     //height: 1.5,
          //     color: AppColors.buttoncolor,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    ),


                                ],
                              )
                            ],
                          ),
                        ),
                        // child:  Column(
                        //   children: [
                        //     // (optional) inner header section
                        //     Container(
                        //       height: MediaQuery.of(context).size.width * 0.150,
                        //       width: double.infinity,
                        //       decoration: BoxDecoration(
                        //         color: AppColors.boxlightcolor,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),

                      // Floating card — **முன்னாடி** வரணும்னா இது background-க்குப் பிறகு
                      Positioned(
                        bottom: -MediaQuery.of(context).size.height * 0.06,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Material(
                            elevation: 8, // shadow & foreground feel
                            borderRadius: BorderRadius.circular(12),
                            child: centercontainer(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.0750), // floating card க்கு space

                  labell("Your Events"),
                  const SizedBox(height: 12.0),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  singleventdashboard(),
                        ),
                      );
                    },
                    child: eventcard(),
                  ),
                   const SizedBox(height: 12.0),
                     GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  singleventdashboard(),
                        ),
                      );
                    },
                    child: eventcard(),
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
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
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
       ],
     ),
   );


   Widget centercontainer() {
  return Container(
    height: MediaQuery.of(context).size.height * 0.17,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 0,
          offset: const Offset(0, 6),
          color: Colors.black.withOpacity(0.06),
        ),
      ],
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT COLUMN
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _StatLine(
                value: '7',
                label: 'Total Events',
                iconColor: Colors.blueAccent,
                iconsd: Icons.event,
              ),
              SizedBox(height: 14),
              _StatLine(
                value: '13',
                label: 'Current Budget',
                iconColor: Colors.teal,
                iconsd: Icons.currency_rupee_rounded,
              ),
            ],
          ),
        ),
      //  SizedBox(width: 12),
        // RIGHT COLUMN
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _StatLine(
                value: '1',
                label: 'Current Events',
                iconColor: Colors.green,
                iconsd: Icons.trending_up_sharp,
              ),
              SizedBox(height: 14),
              _StatLine(
                value: '340 Days',
                label: 'Plan Validity',
                iconColor: Colors.red,
                iconsd: Icons.playlist_add_check_circle_rounded,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}


class _StatLine extends StatelessWidget {
  final Color iconColor;
  final String value;
  final IconData iconsd;
  final String label;

  const _StatLine({
    super.key,
    required this.value,
    required this.label,
    required this.iconColor,
    required this.iconsd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconsd,
              size: 20.0,
              color: iconColor,
            ),
            const SizedBox(width: 6.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9A2143),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4), // 👈 small controlled spacing
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

