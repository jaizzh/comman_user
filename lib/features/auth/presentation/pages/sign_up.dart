// lib/features/auth/presentation/pages/sign_up.dart
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:common_user/app_colors.dart';
import 'package:common_user/features/auth/presentation/pages/sign_in.dart';
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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVerify = true;
  bool isResendEnabled = false;
  int countdown = 60;
  Timer? timer;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  String generatedOTP = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;
  bool isSignUpLoading = false;
  bool isOtpLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }

  // Check if phone number already exists
  Future<bool> isPhoneNumberExists(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("mobile", isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking phone number: $e");
      return false;
    }
  }

  // Check if email already exists
  Future<bool> isEmailExists(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking email: $e");
      return false;
    }
  }

  // Validate form inputs
  String? validateForm() {
    if (nameController.text.trim().isEmpty) {
      return "Please enter your full name";
    }
    if (nameController.text.trim().length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (phoneController.text.trim().isEmpty) {
      return "Please enter your mobile number";
    }
    if (phoneController.text.trim().length != 10) {
      return "Mobile number must be 10 digits";
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phoneController.text.trim())) {
      return "Please enter a valid Indian mobile number";
    }
    if (emailController.text.trim().isNotEmpty) {
      if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(emailController.text.trim())) {
        return "Please enter a valid email address";
      }
    }
    return null;
  }

  // Google Sign-In Method
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
            MaterialPageRoute(builder: (_) => const MainPage()),
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
          isLoading = false;
        });
      }
    }
  }

  Future<void> sendOtp() async {
    // Validate form
    String? validationError = validateForm();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      isSignUpLoading = true;
    });

    try {
      // Check if phone number already exists
      bool phoneExists = await isPhoneNumberExists(phoneController.text.trim());
      if (phoneExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "This mobile number is already registered. Please sign in instead.",
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isSignUpLoading = false;
        });
        return;
      }

      // Check if email already exists (if provided)
      if (emailController.text.trim().isNotEmpty) {
        bool emailExists = await isEmailExists(emailController.text.trim());
        if (emailExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "This email is already registered. Please sign in instead.",
              ),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            isSignUpLoading = false;
          });
          return;
        }
      }

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
        isSignUpLoading = false;
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
      if (otpController.text.trim() == generatedOTP) {
        // Save user data to Firestore
        await FirebaseFirestore.instance.collection("users").add({
          "name": nameController.text.trim(),
          "mobile": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "signInMethod": "phone",
          "createdAt": FieldValue.serverTimestamp(),
        });

        if (mounted) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainPage()),
          );
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
                    _buildSignUpForm(context)
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

  Widget _buildSignUpForm(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CommonWidgets.titleText(context, "Register", "Create Your New Account"),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.customTextField(
          context,
          "Full Name",
          nameController,
          Icons.person,
        ),
        SizedBox(height: screenHeight * 0.015),
        CommonWidgets.customTextField(
          context,
          "Mobile Number",
          phoneController,
          Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: screenHeight * 0.015),
        CommonWidgets.customTextField(
          context,
          "Email Address",
          emailController,
          Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: screenHeight * 0.02),
        // Keep your original button UI but add loading state
        isSignUpLoading
            ? const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              )
            : CommonWidgets.customButton(context, "Sign Up", () async {
                await sendOtp();
              }),
        SizedBox(height: screenHeight * 0.02),
        CommonWidgets.signInUpText(
          context,
          "Already have an account?",
          "Sign In",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignIn()),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.orDivider(context),
        SizedBox(height: screenHeight * 0.02),
        // Keep your original Google button UI but add loading state
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
        // Keep your original resend code UI
        GestureDetector(
          onTap: isResendEnabled && !isSignUpLoading
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
                      color: isResendEnabled && !isSignUpLoading
                          ? Colors.blue
                          : Colors.grey,
                      decoration: isResendEnabled && !isSignUpLoading
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
        // Keep your original button UI but add loading state
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
