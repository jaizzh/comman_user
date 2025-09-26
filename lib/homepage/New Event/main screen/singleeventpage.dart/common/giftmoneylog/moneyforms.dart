import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/providersvalues.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class moneyLogForms extends StatefulWidget {
  const moneyLogForms({super.key});

  @override
  State<moneyLogForms> createState() => moneyLogFormsState();
}

class moneyLogFormsState extends State<moneyLogForms> {
  TextEditingController form1 = TextEditingController();
  TextEditingController form2 = TextEditingController();
  TextEditingController form3 = TextEditingController();
  TextEditingController form4 = TextEditingController();
  TextEditingController form5 = TextEditingController();

  int? forWhomSelectedIndex;
  int? giftTypeSelectedIndex;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    form1.dispose();
    form2.dispose();
    form3.dispose();
    form4.dispose();
    form5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    // ❌ REMOVE THIS - Provider already exists globally in main.dart
    // return ChangeNotifierProvider(
    //   create: (context) => formvalues(),
    //   child: Scaffold(...),
    // );

    // ✅ CORRECT - Direct Scaffold return, provider already available
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(
            left: size.width * 0.04,
            top: size.height * 0.01,
            bottom: size.height * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.025),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.buttoncolor,
              size: size.width * 0.05,
            ),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(
          "Gift/Money Log",
          style: TextStyle(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),

                // Form Fields
                buildFormField("Name", form1, Icons.person_2, size),
                SizedBox(height: size.height * 0.02),
                buildFormField("Enter Amount", form2, Icons.money, size),
                SizedBox(height: size.height * 0.02),
                buildFormField("Mobile Number", form3,
                    Icons.mobile_friendly_rounded, size),
                SizedBox(height: size.height * 0.02),
                buildFormField(
                    "Address", form4, Icons.local_activity_rounded, size),

                SizedBox(height: size.height * 0.03),

                // Checkbox Section
                buildCheckboxSection(size),

                SizedBox(height: size.height * 0.03),

                // Image upload section
                buildImageSection(size),

                SizedBox(height: size.height * 0.04),

                // Continue button
                buildContinueButton(size),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormField(
      String hint, TextEditingController controller, IconData icon, Size size) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black26,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(size.width * 0.025),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: hint.contains('Amount') || hint.contains('Mobile')
              ? TextInputType.number
              : TextInputType.text,
          style: TextStyle(fontSize: size.width * 0.045),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.black54,
              size: size.width * 0.05,
            ),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckboxSection(Size size) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          // For Whom section
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "For Whom :",
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          shape: CircleBorder(),
                          value: forWhomSelectedIndex == 0,
                          onChanged: (bool? value) {
                            setState(() {
                              forWhomSelectedIndex = value == true ? 0 : null;
                            });
                          },
                        ),
                        Text(
                          "Bride",
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          shape: CircleBorder(),
                          value: forWhomSelectedIndex == 1,
                          onChanged: (bool? value) {
                            setState(() {
                              forWhomSelectedIndex = value == true ? 1 : null;
                            });
                          },
                        ),
                        Text(
                          "Groom",
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Gift Type section
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Amount Type :",
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          shape: CircleBorder(),
                          value: giftTypeSelectedIndex == 0,
                          onChanged: (bool? value) {
                            setState(() {
                              giftTypeSelectedIndex = value == true ? 0 : null;
                            });
                          },
                        ),
                        Text(
                          "Cash",
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          shape: CircleBorder(),
                          value: giftTypeSelectedIndex == 1,
                          onChanged: (bool? value) {
                            setState(() {
                              giftTypeSelectedIndex = value == true ? 1 : null;
                            });
                          },
                        ),
                        Text(
                          "Online Payment",
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageSection(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Upload Gift Image",
              style: TextStyle(
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              "(optional)",
              style: TextStyle(
                fontSize: size.width * 0.03,
                fontWeight: FontWeight.bold,
                color: AppColors.buttoncolor,
              ),
            )
          ],
        ),
        SizedBox(height: size.height * 0.01),
        GestureDetector(
          onTap: pickImageFromGallery,
          child: DottedBorder(
            color: selectedImage != null
                ? Colors.green.withOpacity(0.6)
                : AppColors.buttoncolor.withOpacity(0.6),
            strokeWidth: 2,
            dashPattern: [8, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(size.width * 0.025),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                color: selectedImage != null
                    ? Colors.green.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(size.width * 0.025),
              ),
              child: selectedImage != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            color: AppColors.buttoncolor,
                            size: size.width * 0.08,
                          ),
                          SizedBox(height: size.height * 0.008),
                          Text(
                            "Tap to Select Image",
                            style: TextStyle(
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.bold,
                                color: AppColors.buttoncolor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContinueButton(Size size) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          try {
            // 1) Build payload
            final data = {
              'name': form1.text.trim(),
              'amount': form2.text.trim(),
              'mobile': form3.text.trim(),
              'address': form4.text.trim(),
              'forWhom': forWhomSelectedIndex == 0
                  ? 'Bride'
                  : forWhomSelectedIndex == 1
                      ? 'Groom'
                      : '',
              'amountType': giftTypeSelectedIndex == 0
                  ? 'Cash'
                  : giftTypeSelectedIndex == 1
                      ? 'Online Payment'
                      : '',
              'image': selectedImage?.path ?? '',
            };

            // 2) Quick validation
            if (data['name']!.isEmpty || data['amount']!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Name & Amount are required'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (double.tryParse(data['amount']!) == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a valid amount'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Validate mobile number (optional but if provided should be valid)
            if (data['mobile']!.isNotEmpty &&
                (data['mobile']!.length < 10 || data['mobile']!.length > 15)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a valid mobile number'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // 3) Access GLOBAL provider and add data ✅
            final prov = context.read<formvalues>();
            prov.addValue(data);

            // 4) Clear form
            setState(() {
              form1.clear();
              form2.clear();
              form3.clear();
              form4.clear();
              forWhomSelectedIndex = null;
              giftTypeSelectedIndex = null;
              selectedImage = null;
            });

            // 5) Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Data saved successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            // 6) Navigate back with success flag
            Navigator.pop(context, true);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error occurred: ${e.toString()}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
            print('Button tap error: $e');
          }
        },
        child: Container(
          width: size.width * 0.6,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.015,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.025),
            color: AppColors.buttoncolor,
            boxShadow: [
              BoxShadow(
                color: AppColors.buttoncolor.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            "Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
