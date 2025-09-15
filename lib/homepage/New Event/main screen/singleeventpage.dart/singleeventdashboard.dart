// import 'package:common_user/common/colors.dart';
// import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
// import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/planningtoolspage.dart';
// import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/fisrthalfpage.dart';
// import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/invitationhome.dart';
// import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/majorcont.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class singleventdashboard extends StatefulWidget {
//   const singleventdashboard({super.key});

//   @override
//   State<singleventdashboard> createState() => _singleventdashboardState();
// }

// class _singleventdashboardState extends State<singleventdashboard> {
//   bool planexpand = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   surfaceTintColor: AppColors.boxlightcolor,
//       //   toolbarHeight: MediaQuery.of(context).size.height * 0.06,
//       //   backgroundColor: AppColors.boxlightcolor,
//       //   elevation: 0,
//       //   leading: Padding(
//       //     padding: const EdgeInsets.all(8.0),
//       //     child: IconButton(
//       //       icon: const Icon(
//       //         Icons.arrow_back_ios_new_rounded,
//       //         color: Colors.black,
//       //         size: 18.0,
//       //       ),
//       //       onPressed: () => Navigator.push(
//       //           context, MaterialPageRoute(builder: (_) => MinimalDemoPage())),
//       //     ),
//       //   ),
//       //   actions: [
//       //     IconButton(
//       //         onPressed: () {},
//       //         icon: Icon(
//       //           Icons.card_giftcard_rounded,
//       //           color: Colors.black,
//       //           size: 18.0,
//       //         )),
//       //     IconButton(
//       //         onPressed: () {},
//       //         icon: Icon(
//       //           Icons.edit,
//       //           color: Colors.black,
//       //           size: 18.0,
//       //         ))
//       //   ],
//       // ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               singledashhalf(),
//               SizedBox(
//                 height: 12.0,
//               ),
//               majorcont(),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 width: double.infinity,
//                 child: Image.asset(fit: BoxFit.cover, "assets/images/temp.jpg"),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
