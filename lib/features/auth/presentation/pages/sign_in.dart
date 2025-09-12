// lib/features/auth/presentation/pages/sign_in.dart
// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:math';
import 'package:common_user/app_colors.dart';
import 'package:common_user/features/auth/presentation/pages/sign_up.dart';
import 'package:common_user/features/auth/presentation/user_local_storage.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/common_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isVerify = true;
  bool isResendEnabled = false;
  int countdown = 60;
  Timer? timer;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String generatedOTP = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;
  bool isSignInLoading = false;
  bool isOtpLoading = false;

  // User data from Firestore
  Map<String, dynamic>? userData;

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }

  // Check if phone number exists and get user data
  Future<Map<String, dynamic>?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("mobile", isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var data = doc.data() as Map<String, dynamic>;
        data["uid"] = doc.id; // Add document ID as 'uid'
        return data;
      }
      return null;
    } catch (e) {
      print("Error checking phone number: $e");
      return null;
    }
  }

  // Validate phone number
  String? validatePhoneNumber() {
    if (phoneController.text.trim().isEmpty) {
      return "Please enter your mobile number";
    }
    if (phoneController.text.trim().length != 10) {
      return "Mobile number must be 10 digits";
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phoneController.text.trim())) {
      return "Please enter a valid Indian mobile number";
    }
    return null;
  }

  // Google Sign-In Method (same as sign-up)
  Future<void> signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        setState(() {
          isLoading = false;
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
          await UserLocalStorage.saveUserDataToLocal(user.uid);
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
          isLoading = false;
        });
      }
    }
  }

  Future<void> sendOtp() async {
    // Validate phone number
    String? validationError = validatePhoneNumber();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      isSignInLoading = true;
    });

    try {
      // Check if phone number exists
      Map<String, dynamic>? user = await getUserByPhoneNumber(
        phoneController.text.trim(),
      );
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "This mobile number is not registered. Please sign up first.",
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isSignInLoading = false;
        });
        return;
      }

      // Store user data for later use
      userData = user;

      // Generate OTP
      String otp = (Random().nextInt(9000) + 1000).toString();
      generatedOTP = otp;

      const String url = "https://www.fast2sms.com/dev/bulkV2";
      final Map<String, String> headers = {
        "authorization":
            "PR9ahfUWwQCLj0muNK7HeIToytiMgxOVqFvn2rbd13zJSsAX8Y9EzVseUa4QGdNSk3IonMuv8COl2fHq",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      final Map<String, String> fields = {
        "sender_id": "RYDMCO",
        "message": "186192",
        "variables_values": generatedOTP,
        "language": "english",
        "route": "dlt",
        "numbers": phoneController.text.trim(),
      };

      final response = await http
          .post(Uri.parse(url), headers: headers, body: fields)
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
            "Request timeout",
            const Duration(seconds: 10),
          );
        },
      );

      if (response.statusCode == 200) {
        startTimer();
        setState(() {
          isVerify = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OTP sent to +91 ${phoneController.text.trim()}"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception("Failed to send OTP. Please try again.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error sending OTP: ${_getErrorMessage(e.toString())}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isSignInLoading = false;
      });
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.trim().length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 4-digit OTP"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isOtpLoading = true;
    });

    try {
      if (otpController.text.trim() == generatedOTP && userData != null) {
        // Navigate to home screen with user data
        if (mounted) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainPage()),
          );
          await UserLocalStorage.saveUserDataToLocal(userData!["uid"]);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid OTP! Please check and try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error verifying OTP: ${_getErrorMessage(e.toString())}",
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isOtpLoading = false;
        });
      }
    }
  }

  void startTimer() {
    setState(() {
      countdown = 60;
      isResendEnabled = false;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (countdown > 1) {
            countdown--;
          } else {
            isResendEnabled = true;
            timer.cancel();
          }
        });
      } else {
        timer.cancel();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? screenWidth * 0.1 : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  CommonWidgets.logo(context),
                  SizedBox(height: screenHeight * 0.03),
                  if (isVerify)
                    _buildSignInForm(context)
                  else
                    _buildOTPForm(context),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CommonWidgets.titleText(context, "Sign IN", "Welcome Back"),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.customTextField(
          context,
          "Enter Your Mobile Number",
          phoneController,
          Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: screenHeight * 0.015),
        // Add loading state to sign in button
        isSignInLoading
            ? const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
            : CommonWidgets.customButton(context, "Sign In", () async {
                await sendOtp();
              }),
        SizedBox(height: screenHeight * 0.02),
        CommonWidgets.signInUpText(
          context,
          "Don't have an account?",
          "Sign Up",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignUp()),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.orDivider(context),
        SizedBox(height: screenHeight * 0.02),
        // Add loading state to Google button
        isLoading
            ? const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
            : CommonWidgets.googleButton(context, signInWithGoogle),
      ],
    );
  }

  Widget _buildOTPForm(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          "OTP Verification",
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              letterSpacing: 1.5,
              height: 1.3,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Lottie.asset(
          "assets/json/ot.json",
          width: screenWidth * 0.5,
          height: screenWidth * 0.4,
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            "Enter the OTP sent to +91 ${phoneController.text}",
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
        ),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.customTextField(
          context,
          "Enter OTP",
          otpController,
          Icons.security,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: screenHeight * 0.02),
        // Updated resend code with timer
        GestureDetector(
          onTap: isResendEnabled && !isSignInLoading
              ? () async {
                  await sendOtp();
                }
              : () {},
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Didn't get code? ",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                ),
                TextSpan(
                  text: isResendEnabled
                      ? "Resend Code"
                      : "Resend in ${countdown}s",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w600,
                      color: isResendEnabled && !isSignInLoading
                          ? Colors.blue
                          : Colors.grey,
                      decoration: isResendEnabled && !isSignInLoading
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        // Add loading state to verify button
        isOtpLoading
            ? const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
            : CommonWidgets.customButton(context, "Verify OTP", () async {
                await verifyOtp();
              }),
      ],
    );
  }
}
