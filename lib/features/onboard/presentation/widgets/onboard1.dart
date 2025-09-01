import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../app_colors.dart';
import 'clipShadow_path.dart';
import 'custom_clippers.dart';

// ignore: must_be_immutable
class Onboard1 extends StatelessWidget {
  String title;
  String subtitle;
  String icon;
  Onboard1({
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
        CustomPaint(
          painter: ClipShadowPainter(
            clipper: SmallClipper(),
            shadow: const BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ),
          child: Container(),
        ),
        // Main clipped container
        ClipPath(
          clipper: SmallClipper(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE29F), // Cream yellow
                  Color(0xFFFFC3A0), // Peach orange
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: double.infinity,
            width: double.infinity,
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

    // Responsive bottom position
    double bottomPosition = screenHeight * 0.1;
    if (screenHeight < 600) {
      bottomPosition = screenHeight * 0.08; // Less space on small screens
    } else if (screenHeight > 800) {
      bottomPosition = screenHeight * 0.12; // More space on tall screens
    }

    return Positioned(
      bottom: bottomPosition, // Responsive bottom position
      left: 0,
      right: 0,
      child: Container(
        height: animationHeight, // Responsive height
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 350 ? 16 : 20, // Responsive padding
        ),
        child: Lottie.asset(
          icon,
          height: animationHeight,
          fit: BoxFit.contain,
          repeat: true,
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

    // Responsive vertical padding
    double verticalPadding = 70;
    if (screenHeight < 600) {
      verticalPadding = 50;
    } else if (screenHeight > 800) {
      verticalPadding = 90;
    }

    // Responsive horizontal padding for subtitle
    double subtitleHorizontalPadding = 20;
    if (screenWidth < 350) {
      subtitleHorizontalPadding = 16;
    } else if (screenWidth > 600) {
      subtitleHorizontalPadding = 40;
    }

    return SafeArea(
      child: Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth *
                0.01, // 10% padding from sides (keeping your exact logic)
            vertical: verticalPadding, // Responsive vertical padding
          ),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.zeyada(
                  // 👈 font name
                  textStyle: TextStyle(
                    fontSize: titleFontSize, // Responsive font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        subtitleHorizontalPadding), // Responsive padding
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alata(
                    // 👈 font name
                    textStyle: TextStyle(
                      fontSize: subtitleFontSize, // Responsive font size
                      color: Colors.black45,
                      height: 1.5, // Line height for better readability
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
