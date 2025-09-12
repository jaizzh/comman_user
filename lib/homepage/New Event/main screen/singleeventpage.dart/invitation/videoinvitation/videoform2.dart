import 'package:common_user/app_colors.dart';
import 'package:common_user/common/razorpay/razorvideo.dart';
import 'package:flutter/material.dart';

class videoform2 extends StatefulWidget {
  const videoform2({super.key});

  @override
  State<videoform2> createState() => _videoform2State();
}

class _videoform2State extends State<videoform2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController name4 = TextEditingController();
  final TextEditingController name5 = TextEditingController();
  final TextEditingController name6 = TextEditingController();
  final TextEditingController name7 = TextEditingController();
  final TextEditingController name8 = TextEditingController();
  final TextEditingController name9 = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGold,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/videoinvite2.png"),
                  ),
                ),
              ),
              Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 20.0,
                          color: Colors.black,
                        )),
                  )),
            ]),
            Container(
              height: 6.0,
              width: double.infinity,
              color: AppColors.primary,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF9A2143).withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Page 2",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 30.0,
                                height: 4.0,
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 30.0,
                                height: 4.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "Complete your premium video invitation",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name Field
                    _buildPremiumTextField(
                      controller: _nameController,
                      //  label: "Name",
                      hint: "Rajat",
                      icon: Icons.person_2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: _emailController,
                      //  label: "Name",
                      hint: "Mr Sunil Sharma",
                      icon: Icons.person_2,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Message Field
                    _buildPremiumTextField(
                      controller: _messageController,
                      // label: "Date",
                      hint: "Mrs komal Sharma",
                      icon: Icons.person_2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Proper date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: name4,
                      //  label: "Name",
                      hint: "Katyayni",
                      icon: Icons.person_2,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: name5,
                      //  label: "Name",
                      hint: "Mr sumit Sharma",
                      icon: Icons.person_2,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: name6,
                      //  label: "Name",
                      hint: "Mrs Kamla Sharma",
                      icon: Icons.person_2,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: name7,
                      //  label: "Name",
                      hint: "Wednesday",
                      icon: Icons.date_range_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter one Weekday';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: name8,
                      //  label: "Name",
                      hint: "15-09-2023",
                      icon: Icons.calendar_month_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Proper Date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),

                    // Email Field
                    _buildPremiumTextField(
                      controller: name9,
                      //  label: "Name",
                      hint: "Full Address",
                      icon: Icons.map_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 26),

                    // Premium Submit Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              //    if (_formKey.currentState!.validate()) {
                              // Only show success dialog when validation passes
                              // ✅ CALL init()
                              RazorpayServicevideo.instance.init();

                              RazorpayServicevideo.instance.openCheckout(
                                amountPaise: 39900, // ₹399
                                context: context,
                                keyId:
                                    "rzp_test_1DP5mmOlF5G5ag", // replace with your key
                              );
                              //   }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9A2143),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              shadowColor:
                                  const Color(0xFF9A2143).withOpacity(0.3),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.video_library_rounded, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Start Creating Video",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPremiumTextField({
  required TextEditingController controller,
//  required String label,
  required String hint,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 1),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1F2937),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF9A2143).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Color(0xFF9A2143),
            ),
          ),
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF9A2143),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFEF4444),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFEF4444),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    ],
  );
}
