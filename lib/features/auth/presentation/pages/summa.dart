import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
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

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    otpController.dispose();
    timer?.cancel();
    super.dispose();
  }

  Future<void> sendOtp() async {
    String otp = (Random().nextInt(9000) + 1000).toString();
    generatedOTP = otp;

    const String url = "https://www.fast2sms.com/dev/bulkV2";
    final Map<String, String> headers = {
      "authorization":
          "PR9ahfUWwQCLj0muNK7HeIToytiMgxOVqFvn2rbd13zJSsAX8Y9EzVseUa4QGdNSk3IonMuv8COl2fHq",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final Map<String, String> fields = {
      "sender_id": "RYDMCO",
      "message": "186192",
      "variables_values": generatedOTP,
      "language": "english",
      "route": "dlt",
      "numbers": phoneController.text,
    };

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: fields);
      print("OTP Response: ${response.body}");
      startTimer();
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text == generatedOTP) {
      await FirebaseFirestore.instance.collection("users").add({
        "name": nameController.text,
        "mobile": phoneController.text,
        "email": emailController.text,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => HomeScreen(
                  name: nameController.text,
                  email: emailController.text,
                  mobile: phoneController.text,
                )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP!")),
      );
    }
  }

  void startTimer() {
    setState(() {
      countdown = 60;
      isResendEnabled = false;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 1) {
          countdown--;
        } else {
          isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              if (isVerify)
                _buildSignUpForm(context)
              else
                _buildOTPForm(context),
            ],
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
            context, "Full Name", nameController, Icons.person),
        SizedBox(height: screenHeight * 0.02),
        CommonWidgets.customTextField(
            context, "Mobile Number", phoneController, Icons.phone,
            keyboardType: TextInputType.phone),
        SizedBox(height: screenHeight * 0.02),
        CommonWidgets.customTextField(
            context, "Email Address", emailController, Icons.email,
            keyboardType: TextInputType.emailAddress),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.customButton(context, "Sign Up", () async {
          if (phoneController.text.isNotEmpty &&
              nameController.text.isNotEmpty) {
            await sendOtp();
            setState(() {
              isVerify = false;
            });
          }
        }),
      ],
    );
  }

  Widget _buildOTPForm(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text("OTP Verification",
            style:
                GoogleFonts.aBeeZee(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: screenHeight * 0.02),
        CommonWidgets.customTextField(
            context, "Enter OTP", otpController, Icons.security,
            keyboardType: TextInputType.number),
        SizedBox(height: screenHeight * 0.03),
        CommonWidgets.customButton(context, "Verify OTP", () async {
          await verifyOtp();
        }),
        const SizedBox(height: 20),
        if (!isResendEnabled)
          Text("Resend in $countdown sec",
              style: const TextStyle(color: Colors.grey))
        else
          TextButton(
            onPressed: () async {
              await sendOtp();
            },
            child:
                const Text("Resend OTP", style: TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }
}
