// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:common_user/app_colors.dart';
import 'package:common_user/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../homepage/dashboard page/mainpage.dart';
import 'sign_in.dart';

class ChooseAuth extends StatefulWidget {
  const ChooseAuth({super.key});

  @override
  State<ChooseAuth> createState() => _ChooseAuthState();
}

class _ChooseAuthState extends State<ChooseAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isGoogleLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final safePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight - safePadding.top - safePadding.bottom,
          child: Column(
            children: [
              // Top section with centered logo - Flexible instead of Expanded
              _buildLogoSection(screenHeight, screenWidth),

              // Bottom section with content - Fixed height
              _buildContentSection(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(double screenHeight, double screenWidth) {
    return Flexible(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo with constrained size
            _buildLogo(screenWidth),

            SizedBox(height: screenHeight * 0.015),

            // Main Title
            _buildTitle(screenWidth),

            SizedBox(height: screenHeight * 0.008),

            // Subtitle
            _buildSubtitle(screenWidth),

            SizedBox(height: screenHeight * 0.015),

            // Lottie Animation with proper constraints
            _buildLottieAnimation(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(double screenWidth) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: _getResponsiveLogoSize(screenWidth),
        maxHeight: _getResponsiveLogoSize(screenWidth),
      ),
      child: Image.asset(
        "assets/png/logo.png",
        width: _getResponsiveLogoSize(screenWidth),
        height: _getResponsiveLogoSize(screenWidth),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: _getResponsiveLogoSize(screenWidth),
            height: _getResponsiveLogoSize(screenWidth),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.image_not_supported,
              size: screenWidth * 0.08,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Text(
      "Mangal Mall",
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.zeyada(
        textStyle: TextStyle(
          fontSize: _getResponsiveTitleSize(screenWidth),
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          letterSpacing: screenWidth * 0.005,
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
    );
  }

  Widget _buildSubtitle(double screenWidth) {
    return Text(
      "Your Complete Wedding & Event Companion",
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          fontSize: _getResponsiveSubtitleSize(screenWidth),
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          letterSpacing: screenWidth * 0.002,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildLottieAnimation(double screenWidth, double screenHeight) {
    final lottieSize = _getResponsiveLottieSize(screenWidth, screenHeight);

    return Flexible(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: lottieSize,
          maxHeight: lottieSize,
          minWidth: 80,
          minHeight: 80,
        ),
        child: AspectRatio(
          aspectRatio: 1.0, // Keep it square
          child: Lottie.asset(
            "assets/json/Wedding.json",
            fit: BoxFit.contain,
            repeat: true,
            reverse: false,
            animate: true,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.celebration,
                  size: lottieSize * 0.4,
                  color: Colors.purple,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildWelcomeText(screenWidth),
          SizedBox(height: screenWidth * 0.05),
          _buildDescriptionText(screenWidth),
          SizedBox(height: screenWidth * 0.08),
          _buildAuthButtons(screenWidth),
          SizedBox(height: screenWidth * 0.05),
          _buildGoogleSignInButton(screenWidth),
          SizedBox(height: screenWidth * 0.02),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(double screenWidth) {
    return Text(
      "Welcome",
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          fontSize: _getResponsiveWelcomeTextSize(screenWidth),
          letterSpacing: screenWidth * 0.003,
        ),
      ),
    );
  }

  Widget _buildDescriptionText(double screenWidth) {
    return Text(
      "Plan, manage, and celebrate every occasion in one place. From invitations to shopping, Mangal Mall makes your journey effortless.",
      textAlign: TextAlign.left,
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: AppColors.white,
          fontSize: _getResponsiveDescriptionSize(screenWidth),
          letterSpacing: screenWidth * 0.002,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildAuthButtons(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: _buildAuthButton(
            text: "Sign In",
            backgroundColor: AppColors.white,
            textColor: AppColors.black,
            screenWidth: screenWidth,
            onTap: _handleSignIn,
          ),
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: _buildAuthButton(
            text: "Sign Up",
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            screenWidth: screenWidth,
            onTap: _handleSignUp,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required double screenWidth,
    required VoidCallback onTap,
  }) {
    return Material(
      color: backgroundColor,
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.035,
            horizontal: screenWidth * 0.04,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: _getResponsiveButtonTextSize(screenWidth),
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(double screenWidth) {
    return Material(
      color: Colors.white,
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: isGoogleLoading ? null : _handleGoogleSignIn,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.035,
            horizontal: screenWidth * 0.04,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isGoogleLoading)
                // Show loading indicator
                SizedBox(
                  width: _getResponsiveGoogleIconSize(screenWidth),
                  height: _getResponsiveGoogleIconSize(screenWidth),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
                  ),
                )
              else
                // Google Logo with proper constraints
                Container(
                  constraints: BoxConstraints(
                    maxWidth: _getResponsiveGoogleIconSize(screenWidth),
                    maxHeight: _getResponsiveGoogleIconSize(screenWidth),
                  ),
                  child: Image.asset(
                    "assets/png/google.png",
                    width: _getResponsiveGoogleIconSize(screenWidth),
                    height: _getResponsiveGoogleIconSize(screenWidth),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback icon if image fails to load
                      return Container(
                        width: _getResponsiveGoogleIconSize(screenWidth),
                        height: _getResponsiveGoogleIconSize(screenWidth),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.login,
                          size: _getResponsiveGoogleIconSize(screenWidth) * 0.6,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),

              SizedBox(width: screenWidth * 0.025),

              // Google Sign In Text
              Flexible(
                child: Text(
                  isGoogleLoading ? "Signing in..." : "Sign Up with Google",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: _getResponsiveButtonTextSize(screenWidth),
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      letterSpacing: screenWidth * 0.001,
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

  // Google Sign-In Method - Same as your sign-up/sign-in pages
  Future<void> _handleGoogleSignIn() async {
    setState(() {
      isGoogleLoading = true;
    });

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        setState(() {
          isGoogleLoading = false;
        });
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Check if user already exists in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        Map<String, dynamic> userData = {
          "name": user.displayName ?? "Unknown User",
          "email": user.email ?? "",
          "mobile": null,
          "profileImageUrl": user.photoURL ?? "",
          "signInMethod": "google",
          "updatedAt": FieldValue.serverTimestamp(),
        };

        if (!userDoc.exists) {
          userData["createdAt"] = FieldValue.serverTimestamp();
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(userData);
        } else {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update(userData);
        }

        // Navigate to home screen
        if (mounted) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainPage()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Google Sign-In failed: ${_getErrorMessage(e.toString())}",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isGoogleLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains("network")) {
      return "Network error. Please check your internet connection.";
    } else if (error.contains("timeout")) {
      return "Request timeout. Please try again.";
    } else if (error.contains("permission")) {
      return "Permission denied. Please try again.";
    } else {
      return "Something went wrong. Please try again.";
    }
  }

  // Responsive size methods
  double _getResponsiveLogoSize(double screenWidth) {
    if (screenWidth >= 768) return 110;
    if (screenWidth >= 600) return 95;
    if (screenWidth >= 414) return 85;
    if (screenWidth >= 375) return 75;
    return 65;
  }

  double _getResponsiveTitleSize(double screenWidth) {
    if (screenWidth >= 768) return 30;
    if (screenWidth >= 600) return 26;
    if (screenWidth >= 414) return 24;
    if (screenWidth >= 375) return 22;
    return 20;
  }

  double _getResponsiveSubtitleSize(double screenWidth) {
    if (screenWidth >= 768) return 15;
    if (screenWidth >= 600) return 14;
    if (screenWidth >= 414) return 13;
    if (screenWidth >= 375) return 12;
    return 11;
  }

  double _getResponsiveWelcomeTextSize(double screenWidth) {
    if (screenWidth >= 768) return 24;
    if (screenWidth >= 600) return 22;
    if (screenWidth >= 414) return 21;
    if (screenWidth >= 375) return 20;
    return 18;
  }

  double _getResponsiveDescriptionSize(double screenWidth) {
    if (screenWidth >= 768) return 15;
    if (screenWidth >= 600) return 14;
    if (screenWidth >= 414) return 13;
    if (screenWidth >= 375) return 12;
    return 11;
  }

  double _getResponsiveButtonTextSize(double screenWidth) {
    if (screenWidth >= 768) return 16;
    if (screenWidth >= 600) return 15;
    if (screenWidth >= 414) return 14;
    return 13;
  }

  double _getResponsiveLottieSize(double screenWidth, double screenHeight) {
    // Calculate based on available space rather than fixed percentages
    double availableHeight = screenHeight * 0.25; // Max 25% of screen height
    double availableWidth = screenWidth * 0.6; // Max 60% of screen width

    // Choose the smaller dimension to maintain aspect ratio
    double size =
        availableHeight < availableWidth ? availableHeight : availableWidth;

    // Set boundaries
    if (size > 200) size = 200;
    if (size < 100) size = 100;

    return size;
  }

  // Add this method to your responsive size methods section
  double _getResponsiveGoogleIconSize(double screenWidth) {
    if (screenWidth >= 768) return 28;
    if (screenWidth >= 600) return 26;
    if (screenWidth >= 414) return 24;
    if (screenWidth >= 375) return 22;
    return 20;
  }

  void _handleSignIn() {
    debugPrint("Navigate to Sign In");
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignIn()));
  }

  void _handleSignUp() {
    debugPrint("Navigate to Sign Up");
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUp()));
  }
}
