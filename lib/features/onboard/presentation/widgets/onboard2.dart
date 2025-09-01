import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'clipShadow_path.dart';
import 'dart:math' as math;
import 'custom_clippers.dart';

// ignore: must_be_immutable
class Onboard2 extends StatelessWidget {
  String title;
  String subtitle;
  String icon;
  Onboard2({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Background with gradient and clipping
              _buildGradientBackground(),

              // Lottie animation
              _buildLottieAnimation(screenHeight, screenWidth),

              // Welcome text content
              _buildWelcomeContent(screenWidth, screenHeight),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Stack(
      children: [
        Transform.rotate(
          angle: 360 * math.pi / 360,
          child: CustomPaint(
            painter: ClipShadowPainter(
              clipper: BigClipper(),
              shadow: const BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ),
            child: Container(),
          ),
        ),
        // Main clipped container
        Transform.rotate(
          angle: 360 * math.pi / 360,
          child: ClipPath(
            clipper: BigClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA1C4FD), // Sky blue
                    Color(0xFFC2E9FB), // Baby blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLottieAnimation(double screenHeight, double screenWidth) {
    // Responsive animation height
    double animationHeight = screenHeight * 0.4;
    if (screenWidth < 350) {
      animationHeight = screenHeight * 0.35; // Smaller on very small screens
    } else if (screenWidth > 600) {
      animationHeight = screenHeight * 0.45; // Larger on tablets
    }

    return Positioned(
      top: screenHeight * 0.1, // 10% from top (keeping your exact positioning)
      left: 0,
      right: 0,
      child: Container(
        height: animationHeight,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 350 ? 16 : 20, // Responsive padding
        ),
        child: Lottie.asset(
          icon,
          height: animationHeight,
          fit: BoxFit.contain,
          repeat: false,
          reverse: false,
          animate: true,
          errorBuilder: (context, error, stackTrace) {
            // Fallback widget if Lottie fails to load
            return Icon(
              Icons.celebration,
              size: screenWidth < 350 ? 80 : 100, // Responsive icon size
              color: Colors.purple,
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeContent(double screenWidth, double screenHeight) {
    // Responsive font sizes
    double titleFontSize = 22;
    double subtitleFontSize = 16;

    if (screenWidth < 320) {
      titleFontSize = 18;
      subtitleFontSize = 13;
    } else if (screenWidth < 350) {
      titleFontSize = 20;
      subtitleFontSize = 14;
    } else if (screenWidth > 600) {
      titleFontSize = 26;
      subtitleFontSize = 18;
    }

    // Responsive bottom padding
    double bottomPadding = 130;
    if (screenHeight < 600) {
      bottomPadding = 110;
    } else if (screenHeight > 800) {
      bottomPadding = 170;
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
          bottom: bottomPadding, // Responsive bottom padding
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.zeyada(
                // 👈 font name
                textStyle: TextStyle(
                  fontSize: titleFontSize, // Responsive title font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.alata(
                  // 👈 font name
                  textStyle: TextStyle(
                    fontSize: subtitleFontSize, // Responsive subtitle font size
                    color: Colors.black45,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
