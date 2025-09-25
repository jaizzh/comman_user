import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/giftforms.dart';
import 'package:flutter/material.dart';

class GiftLogger extends StatefulWidget {
  const GiftLogger({super.key});

  @override
  State<GiftLogger> createState() => _GiftLoggerState();
}

class _GiftLoggerState extends State<GiftLogger> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        children: [
          // Gift Money Transaction Card
          buildTransactionCard(
            context: context,
            icon: Icons.card_giftcard,
            iconColor: AppColors.primary,
            title: "Gifted Money",
            subtitle: "transactions",
            currentAmount: 250.0,
            totalAmount: 500.0,
            //  progress: 0.5, // 250/500
            progressColor: Colors.green,
            currency: "₹", // Changed to Indian Rupee
            isSmallScreen: isSmallScreen,
            screenWidth: screenWidth,
          ),
          SizedBox(
            height: 12.0,
          ),
          addoption()
        ],
      ),
    );
  }

  Widget buildTransactionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required double currentAmount,
    required double totalAmount,
    //  required double progress,
    required Color progressColor,
    required String currency,
    required bool isSmallScreen,
    required double screenWidth,
  }) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 3,
              color: Colors.black12,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            // Main Content Row
            Row(
              children: [
                // Icon Container
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 8.0 : 12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor.withOpacity(0.1),
                    border: Border.all(color: iconColor.withOpacity(0.3)),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: isSmallScreen ? 20.0 : 24.0,
                  ),
                ),

                SizedBox(width: screenWidth * 0.04),

                // Content Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Amount Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title Column
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14.0 : 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 11.0 : 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Amount Display
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '$currency${currentAmount.toInt()}',
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 14.0 : 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: progressColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' / ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '$currency${totalAmount.toInt()}',
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 12.0 : 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      // Progress Indicator
                      _buildCustomProgressIndicator(
                        progressColor: progressColor,
                        height: isSmallScreen ? 8.0 : 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomProgressIndicator({
    required Color progressColor,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8.0),
      child: LinearProgressIndicator(
        value: 0.4,
        valueColor: AlwaysStoppedAnimation(progressColor),
        minHeight: height,
        stopIndicatorColor: Colors.black,
      ),
    );
  }

  Widget addoption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          elevation: 4.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.390,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1, blurRadius: 1, color: Colors.black12)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Download",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 4.0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => giftlogforms()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.390,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: AppColors.primary.withOpacity(0.5)),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text("Gift Log",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
