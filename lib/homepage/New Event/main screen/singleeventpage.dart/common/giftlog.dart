// // ignore_for_file: prefer_const_constructors

// import 'package:common_user/app_colors.dart';
// import 'package:flutter/material.dart';

// class GiftLog extends StatefulWidget {
//   const GiftLog({super.key});

//   @override
//   State<GiftLog> createState() => _GiftLogState();
// }

// class _GiftLogState extends State<GiftLog> {
//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions for responsiveness
//     final screenSize = MediaQuery.of(context).size;
//     final screenWidth = screenSize.width;
//     final screenHeight = screenSize.height;
//     final isSmallScreen = screenWidth < 360;

//     return DefaultTabController(
//       length: 2,
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: Container(
//             margin: EdgeInsets.only(
//               left: screenWidth * 0.04, // 4% of screen width
//               top: 8,
//               bottom: 8,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 color: AppColors.primary,
//                 size: isSmallScreen ? 18 : 20, // Responsive icon size
//               ),
//               onPressed: () {
//                 Navigator.maybePop(context);
//               },
//             ),
//           ),
//           title: Text(
//             "Gift/Money Log",
//             style: TextStyle(
//               fontSize: isSmallScreen ? 14.0 : 16.0, // Responsive font size
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.02), // 2% of screen height

//             // Header Section with dynamic height
//             Container(
//               constraints: BoxConstraints(
//                 minHeight: screenHeight * 0.15,
//                 maxHeight: screenHeight * 0.25,
//               ),
//               child: Column(
//                 children: [
//                   nameevent(screenWidth, isSmallScreen),
//                   SizedBox(height: screenHeight * 0.015),
//                   Expanded(
//                       child:
//                           totalbox(screenWidth, screenHeight, isSmallScreen)),
//                 ],
//               ),
//             ),

//             SizedBox(height: screenHeight * 0.02),

//             // TabBar Section
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.05,
//                 vertical: screenHeight * 0.01,
//               ),
//               child: TabBar(
//                 indicator: UnderlineTabIndicator(
//                   borderSide: BorderSide(
//                     width: 2.0,
//                     color: AppColors.primary,
//                   ),
//                   insets: EdgeInsets.symmetric(
//                     horizontal: screenWidth * 0.1, // Dynamic insets
//                   ),
//                 ),
//                 labelColor: AppColors.primary,
//                 unselectedLabelColor: Color(0xFF8E8E93),
//                 labelStyle: TextStyle(
//                   fontSize: isSmallScreen ? 14 : 16, // Responsive font
//                   fontWeight: FontWeight.w600,
//                 ),
//                 unselectedLabelStyle: TextStyle(
//                   fontSize: isSmallScreen ? 13 : 15, // Responsive font
//                   fontWeight: FontWeight.w400,
//                 ),
//                 tabs: const [
//                   Tab(text: "Gift Log"),
//                   Tab(text: "Money Log"),
//                 ],
//               ),
//             ),

//             // TabBarView Section
//             Expanded(
//               child: TabBarView(
//                 children: const [
//                   //  GiftLogger(items: items, onAddPressed: onAddPressed),
//                   //  MoneyLogger(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Responsive name event widget
//   Widget nameevent(double screenWidth, bool isSmallScreen) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Jaiz Wedding",
//             style: TextStyle(
//               fontSize: isSmallScreen ? 14.0 : 16.0, // Responsive font size
//               fontWeight: FontWeight.bold,
//               color: AppColors.primary,
//             ),
//           ),
//           SizedBox(height: 4.0),
//           Text(
//             "Wedding-Party",
//             style: TextStyle(
//               fontSize: isSmallScreen ? 10.0 : 12.0, // Responsive font size
//               fontWeight: FontWeight.bold,
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Responsive total box widget
//   Widget totalbox(double screenWidth, double screenHeight, bool isSmallScreen) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//       child: Card(
//         elevation: 2.0,
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.04,
//             vertical: screenHeight * 0.01,
//           ),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             boxShadow: const [
//               BoxShadow(
//                 spreadRadius: 1,
//                 blurRadius: 1,
//                 color: Colors.black26,
//               ),
//             ],
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // Title
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Total Register",
//                     style: TextStyle(
//                       fontSize: isSmallScreen ? 12.0 : 14.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),

//               // Divider
//               Container(
//                 height: 1.0,
//                 width: double.infinity,
//                 color: Colors.black26,
//               ),

//               // Stats Row - Responsive layout
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   if (constraints.maxWidth < 300) {
//                     // Very small screens - vertical layout
//                     return Column(
//                       children: [
//                         _buildStatItem("0", "Total Events", isSmallScreen),
//                         SizedBox(height: 8),
//                         _buildStatItem("0", "Payments", isSmallScreen),
//                         SizedBox(height: 8),
//                         _buildStatItem("0", "Gifts", isSmallScreen),
//                       ],
//                     );
//                   } else {
//                     // Normal screens - horizontal layout
//                     return IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildStatItem("0", "Total Events", isSmallScreen),
//                           _buildVerticalDivider(),
//                           _buildStatItem("0", "Payments", isSmallScreen),
//                           _buildVerticalDivider(),
//                           _buildStatItem("0", "Gifts", isSmallScreen),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method for stat items
//   Widget _buildStatItem(String value, String label, bool isSmallScreen) {
//     return Flexible(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isSmallScreen ? 16 : 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.primary,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: isSmallScreen ? 10.0 : 12.0,
//               fontWeight: FontWeight.w500,
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper method for vertical divider
//   Widget _buildVerticalDivider() {
//     return Container(
//       width: 1,
//       height: 40,
//       color: Colors.black12,
//     );
//   }
// }
