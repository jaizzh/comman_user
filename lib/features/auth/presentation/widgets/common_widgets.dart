// lib/widgets/common_widgets.dart
// ignore_for_file: deprecated_member_use

import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonWidgets {
  // Responsive Custom Button
  static Widget customButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // 5% of screen width
      ),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.025, // 2.5% of screen width
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            color: AppColors.primary,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              onTap: onPressed,
              child: Padding(
                padding: EdgeInsets.all(
                  screenHeight * 0.022,
                ), // 2.2% of screen height
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.035, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 1.5,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Responsive Custom Text Field
  static Widget customTextField(
    BuildContext context,
    String hint,
    TextEditingController controller,
    IconData icon, {
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            color: AppColors.white,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType ??
                (hint.toLowerCase().contains('mobile') ||
                        hint.toLowerCase().contains('phone')
                    ? TextInputType.phone
                    : hint.toLowerCase().contains('email')
                        ? TextInputType.emailAddress
                        : TextInputType.text),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: screenWidth * 0.06, // Responsive icon size
                color: AppColors.primary,
              ),
              border: InputBorder.none,
              labelText: hint,
              labelStyle: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Responsive Sign In/Up Navigation Text
  static Widget signInUpText(
    BuildContext context,
    String text1,
    String text2,
    VoidCallback onPressed,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            text1,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                letterSpacing: 1.5,
                height: 1.3,
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.025),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            text2,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.5,
                height: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Responsive Google Button
  static Widget googleButton(BuildContext context, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            color: AppColors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              onTap: onPressed,
              child: Padding(
                padding: EdgeInsets.all(screenHeight * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/png/google.png",
                      width: screenWidth * 0.075, // Responsive image size
                      height: screenWidth * 0.075,
                    ),
                    SizedBox(width: screenWidth * 0.025),
                    Flexible(
                      child: Text(
                        "Sign in With Google",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            letterSpacing: 1.5,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Responsive OR Divider
  static Widget orDivider(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: screenWidth * 0.1),
            height: 1,
            color: Colors.black54,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          child: Image.asset(
            "assets/png/pookie.png",
            width: screenWidth * 0.06,
            height: screenWidth * 0.06,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: screenWidth * 0.1),
            height: 1,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // Responsive Title Text
  static Widget titleText(BuildContext context, String title, String subtitle) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.zeyada(
            textStyle: TextStyle(
              fontSize: screenWidth * 0.065, // Responsive title size
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              letterSpacing: 2,
              height: 1.2,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              letterSpacing: 1.5,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  // Responsive Logo
  static Widget logo(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Image.asset(
      "assets/png/logo.png",
      width: screenWidth * 0.15, // 15% of screen width
      height: screenWidth * 0.15,
    );
  }
}
