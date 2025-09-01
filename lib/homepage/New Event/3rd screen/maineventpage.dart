import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New Event/3rd screen/eventbox.dart';
import 'package:common_user/homepage/New Event/main screen/singleeventpage.dart/singleeventdashboard.dart';
import 'package:common_user/homepage/dashboard page/mainpage.dart';
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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.boxlightcolor,
        surfaceTintColor: AppColors.boxlightcolor,
        toolbarHeight: h * 0.1,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 18),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MainPage()),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Jega Vini",
                      style: GoogleFonts.sahitya(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Premium Plan",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.buttoncolor, width: 2.5),
                    image: const DecorationImage(image: AssetImage("assets/images/jega.png"), fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // HEADER
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: h *  0.340,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.boxlightcolor, Colors.white, Colors.white],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(80, 40),
                        bottomRight: Radius.elliptical(80, 40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          // expense row
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "14,386.00\$",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.buttoncolor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Your current expenses",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            children: [
                              _chipButton(
                                label: "Add New Event",
                                onTap: () {},
                              ),
                              _chipButton(
                                label: "Event History",
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -h * 0.02,
                    left: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.boxlightcolor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(50, 20),
                            topRight: Radius.elliptical(50, 20),
                          //  bottomLeft: Radius.circular(20),
                          //  bottomRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: _StatsWrap(), // responsive, no overflow
                      ),
                    ),
                  ),
                ],
              ),
            Container(
              decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                            topLeft: Radius.elliptical(50, 20),
                            topRight: Radius.elliptical(50, 20),
                          ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.0,),
                   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _label("Your Events"),
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => singleventdashboard()));
                  },
                  child: eventcard(),
                ),
              ),
                ],
              ),
            ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => singleventdashboard()));
                  },
                  child: eventcard(),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      );
}

/// Premium chip-like CTA buttons used in header
Widget _chipButton({required String label, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white60, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 6,
            color: Color(0x15000000),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black),
      ),
    ),
  );
}

/// Responsive stats container: wraps on small screens, 3-in-row on bigger screens.
/// Avoids fixed widths that cause overflow.
class _StatsWrap extends StatelessWidget {
  const _StatsWrap({super.key});

  @override
  Widget build(BuildContext context) {

return Container(
  height: MediaQuery.of(context).size.height * 0.135,
  width: double.infinity,
  child: Row(
    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
    children: [
        _StatCard(value: '7', label: 'Total Events', iconColor: Colors.blueAccent, iconData: Icons.event),
            _StatCard(value: '1', label: 'Current Events', iconColor: Colors.green, iconData: Icons.trending_up_sharp),
            _StatCard(value: '340 Days', label: 'Plan Validity', iconColor: Colors.red, iconData: Icons.playlist_add_check_circle_rounded),
    ],
  ),
);
}
}

class _StatCard extends StatelessWidget {
  final Color iconColor;
  final String value;
  final IconData iconData;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
    required this.iconColor,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size .width * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.5,
            blurRadius: 8,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.09),
          ),
        ],
        border: Border.all(color: const Color(0x11FFFFFF), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // value with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 20, color: iconColor),
              const SizedBox(width: 6),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: AppColors.buttoncolor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:common_user/common/colors.dart';
// import 'package:common_user/homepage/New%20Event/3rd%20screen/eventbox.dart';
// import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/singleeventdashboard.dart';
// import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class demopage extends StatefulWidget {
//   const demopage({super.key});

//   @override
//   State<demopage> createState() => _demopageState();
// }

// class _demopageState extends State<demopage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         toolbarHeight: MediaQuery.of(context).size.height * 0.1,
//         actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                                     children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 6.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         SizedBox(height: 16.0,),
//                                         Text("Jega Vini",style: GoogleFonts.sahitya(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black),),
//                                          Text("Premium Plan",style: GoogleFonts.inter(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black54),)
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(width: 6.0,),
//                                    Container(
//                                         height: 35,
//                                         width: 35,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(6.0),
//                                           border: Border.all(
//                                             color: AppColors.buttoncolor,
//                                             width: 3.0,
//                                           ),
//                                           image: DecorationImage(image: AssetImage("assets/images/jega.png"))
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//             ),
//         ],
//         backgroundColor: AppColors.boxlightcolor,
//         surfaceTintColor: AppColors.boxlightcolor,
//         elevation: 0,
//           leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,size: 18.0,),
//              onPressed: () =>
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) =>  MainPage()),
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//          body: SafeArea(
//         child: Stack(
//           clipBehavior: Clip.none, // positioned boundary out-ஆனாலும் காட்ட
//           children: [
//             // Main scroll content
//             Column(
//              // crossAxisAlignment: CrossAxisAlignment.start,
//               //mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // HEADER + FLOATING CARD
//                 Stack(
//                //   clipBehavior: Clip.none,
//                   children: [
//                     // Header background
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.320,
//                       width: double.infinity,
//                       decoration:  BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [AppColors.boxlightcolor,Colors.white,Colors.white]),
//                        // color: AppColors.boxlightcolor,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.elliptical(80, 40),
//                           bottomRight: Radius.elliptical(80, 40),
//                         ),
//                       ),
//                       child: Container(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Column(
            
//                             children: [
//                               SizedBox(height: 10.0,),
                            
//                               Padding(
//                                 padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.130),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                          Text("14,386.00\$",style: TextStyle(fontSize: 18.0,color: AppColors.buttoncolor,fontWeight: FontWeight.bold),),
//                                          Text("your Current expenses",style: TextStyle(fontSize: 12.0,color: Colors.black,fontWeight: FontWeight.bold),)
//                                       ],
//                                     )
                                     
//                                   ],
                                
//                                 ),
//                               ),
//                               SizedBox(height: 10.0,),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           spreadRadius: 1,
//                                           blurRadius: 1,
//                                           color: Colors.black12,
//                                         ),
//                                       ],
//                                       border: Border.all(
//                                         color: Colors.white60,
//                                         width: 2.0
//                                       ),
//                                       borderRadius: BorderRadius.circular(8.0)
//                                     ),
//                                     child: Text("Add New Event",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),),
//                                   ),
//                                   SizedBox(width: 12.0,),
//                                                                       Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                        boxShadow: [
//                                         BoxShadow(
//                                           spreadRadius: 1,
//                                           blurRadius: 1,
//                                           color: Colors.black12,
//                                         ),
//                                       ],
//                                       border: Border.all(
//                                         color: Colors.white60,
//                                         width: 2.0
//                                       ),
//                                       borderRadius: BorderRadius.circular(8.0)
//                                     ),
//                                     child: Text("Event History",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.black),),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ),
//                     ),
            
//                     // Floating card — **முன்னாடி** வரணும்னா இது background-க்குப் பிறகு
//                     Positioned(
//                       bottom: -MediaQuery.of(context).size.height * 0.01,
//                       right: 0,
//                       left: 0,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                         child: Material(
//                           elevation: 8, // shadow & foreground feel
//                           borderRadius: BorderRadius.circular(20),
//                           child: centercontainer(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SingleChildScrollView(
//                   child: Container(
//                     child: Column(
//                       children: [
//                           SizedBox(height: 12.0,),
//                   labell("Your Events"),
//                   const SizedBox(height: 12.0),
                              
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>  singleventdashboard(),
//                         ),
//                       );
//                     },
//                     child: eventcard(),
//                   ),
//                    const SizedBox(height: 12.0),
//                      GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>  singleventdashboard(),
//                         ),
//                       );
//                     },
//                     child: eventcard(),
//                   ),
//                   const SizedBox(height: 12.0),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//    Widget labell(String text) => Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 16.0),
//      child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//        children: [
//          Text(
//               text,
//               style: GoogleFonts.inter(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//        ],
//      ),
//    );


//    Widget centercontainer() {
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.17,
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
//     decoration: BoxDecoration(
//     color: AppColors.boxlightcolor,
//     //  color: Colors.white,
//       borderRadius: BorderRadius.only(topLeft: Radius.elliptical(50, 20),topRight: Radius.elliptical(50, 20)),
//       boxShadow: [
//         BoxShadow(
//           blurRadius: 10,
//           spreadRadius: 0,
//           offset: const Offset(0, 6),
//           color: Colors.black.withOpacity(0.06),
//         ),
//       ],
//     ),
//     child: const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//           _StatLine(
//                 value: '7',
//                 label: 'Total Events',
//                 iconColor: Colors.blueAccent,
//                 iconsd: Icons.event,
//               ),
//                _StatLine(
//                 value: '1',
//                 label: 'Current Events',
//                 iconColor: Colors.green,
//                 iconsd: Icons.trending_up_sharp,
//               ),
//               _StatLine(
//                 value: '340 Days',
//                 label: 'Plan Validity',
//                 iconColor: Colors.red,
//                 iconsd: Icons.playlist_add_check_circle_rounded,
//               ),
//       ],
//     ),
//   );
// }
// }


// class _StatLine extends StatelessWidget {
//   final Color iconColor;
//   final String value;
//   final IconData iconsd;
//   final String label;

//   const _StatLine({
//     super.key,
//     required this.value,
//     required this.label,
//     required this.iconColor,
//     required this.iconsd,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             spreadRadius: 1,
//             blurRadius: 1,
//             color: AppColors.boxlightcolor,
//           )
//         ]
//       ),
//       height: MediaQuery.of(context).size.height *0.125,
//       width: MediaQuery.of(context).size.width * 0.3,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 iconsd,
//                 size: 20.0,
//                 color: iconColor,
//               ),
//               const SizedBox(width: 6.0),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF9A2143),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4), // 👈 small controlled spacing
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.black.withOpacity(0.6),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

