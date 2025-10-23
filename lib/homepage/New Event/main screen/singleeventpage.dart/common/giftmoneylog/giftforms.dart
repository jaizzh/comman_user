import 'package:common_user/common/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GiftLogForms extends StatefulWidget {
  const GiftLogForms({super.key});

  @override
  State<GiftLogForms> createState() => _GiftLogFormsState();
}

class _GiftLogFormsState extends State<GiftLogForms> {
  final TextEditingController form1 = TextEditingController(); // name
  final TextEditingController form2 = TextEditingController(); // mobile
  final TextEditingController form3 = TextEditingController(); // address
  final TextEditingController form4 = TextEditingController(); // gift name

  final List<Map<String, String>> giftvalueforms = [];

  int? forWhomSelectedIndex; // 0 = Bride, 1 = Groom
  int? giftTypeSelectedIndex; // 0 = Packed, 1 = Unpacked
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() => selectedImage = File(image.path));
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

  void _toast(String msg, {Color? bg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: bg ?? Colors.black87),
    );
  }

  void _addToLocalList() {
    if (!_formKey.currentState!.validate()) return;
    if (forWhomSelectedIndex == null) {
      _toast('Please choose Bride or Groom');
      return;
    }
    if (giftTypeSelectedIndex == null) {
      _toast('Please choose Packed or Unpacked');
      return;
    }

    final entry = <String, String>{
      "name": form1.text.trim(),
      "mobileno": form2.text.trim(),
      "address": form3.text.trim(),
      "giftname": form4.text.trim(),
      "forWhom": forWhomSelectedIndex == 0 ? "Bride" : "Groom",
      "giftType": giftTypeSelectedIndex == 0 ? "Packed" : "Unpacked",
      "imagePath": selectedImage?.path ?? "", // ✅ Include image path
    };

    setState(() => giftvalueforms.add(entry));
    _toast("Added to list", bg: Colors.green);

    // Clear for next entry
    form1.clear();
    form2.clear();
    form3.clear();
    form4.clear();
    setState(() {
      forWhomSelectedIndex = null;
      giftTypeSelectedIndex = null;
      selectedImage = null;
    });
  }

  void _finishAndReturn() {
    // Add current form data if valid
    if (_formKey.currentState!.validate() &&
        forWhomSelectedIndex != null &&
        giftTypeSelectedIndex != null) {
      _addToLocalList();
    }

    print(
      '🟣 _finishAndReturn called with ${giftvalueforms.length} items',
    ); // Debug
    print('🟣 Data to return: $giftvalueforms'); // Debug

    if (giftvalueforms.isEmpty) {
      _toast("Please add at least one entry to continue");
      return;
    }

    // ✅ CORRECT: Return data to previous screen
    Navigator.pop(context, giftvalueforms);
  }

  void _addAnotherEntry() {
    _addToLocalList();
  }

  @override
  void dispose() {
    form1.dispose();
    form2.dispose();
    form3.dispose();
    form4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

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
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        title: Text(
          "Gift Log Forms",
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
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),

                // ✅ Show current entries count
                if (giftvalueforms.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green.shade600),
                        SizedBox(width: 8),
                        Text(
                          "${giftvalueforms.length} gift(s) added",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Form fields
                _buildFormField(
                  "Name",
                  form1,
                  Icons.person_2,
                  size,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "Required" : null,
                ),
                SizedBox(height: size.height * 0.02),
                _buildFormField(
                  "Mobile Number",
                  form2,
                  Icons.mobile_friendly_rounded,
                  size,
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "Required" : null,
                ),
                SizedBox(height: size.height * 0.02),
                _buildFormField(
                  "Address",
                  form3,
                  Icons.local_activity_rounded,
                  size,
                  maxLines: 2,
                ),
                SizedBox(height: size.height * 0.02),
                _buildFormField(
                  "Gift Name",
                  form4,
                  Icons.card_giftcard_rounded,
                  size,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "Required" : null,
                ),

                SizedBox(height: size.height * 0.03),

                // Radio sections
                _buildRadioSection(
                  size,
                  title: "For Whom :",
                  groupValue: forWhomSelectedIndex,
                  onChanged: (v) => setState(() => forWhomSelectedIndex = v),
                  leftLabel: "Bride",
                  rightLabel: "Groom",
                ),
                SizedBox(height: size.height * 0.02),
                _buildRadioSection(
                  size,
                  title: "Gift Type :",
                  groupValue: giftTypeSelectedIndex,
                  onChanged: (v) => setState(() => giftTypeSelectedIndex = v),
                  leftLabel: "Packed",
                  rightLabel: "Unpacked",
                ),

                SizedBox(height: size.height * 0.03),

                // Image upload
                _buildImageSection(size),

                SizedBox(height: size.height * 0.04),

                // ✅ IMPROVED: Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Add Another button
                    _secondaryBtn(
                      size,
                      label: "Add Another",
                      onTap: _addAnotherEntry,
                    ),

                    // Continue button
                    _primaryBtn(
                      size,
                      label: "Continue",
                      onTap: _finishAndReturn,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- UI helpers ---

  Widget _buildFormField(
    String hint,
    TextEditingController controller,
    IconData icon,
    Size size, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black26,
              offset: Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(size.width * 0.025),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: keyboardType,
          maxLines: maxLines,
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
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildRadioSection(
    Size size, {
    required String title,
    required int? groupValue,
    required void Function(int?) onChanged,
    required String leftLabel,
    required String rightLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: 0,
                groupValue: groupValue,
                onChanged: onChanged,
                title: Text(leftLabel),
              ),
            ),
            Expanded(
              child: RadioListTile<int>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: 1,
                groupValue: groupValue,
                onChanged: onChanged,
                title: Text(rightLabel),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSection(Size size) {
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
            ),
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
            dashPattern: const [8, 4],
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
                          borderRadius: BorderRadius.circular(
                            size.width * 0.02,
                          ),
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
                            onTap: () => setState(() => selectedImage = null),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
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
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttoncolor,
                            ),
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

  // ✅ Primary button (Continue)
  Widget _primaryBtn(
    Size size, {
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.42,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.025),
          color: AppColors.buttoncolor,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ✅ Secondary button (Add Another)
  Widget _secondaryBtn(
    Size size, {
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.42,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.025),
          color: Colors.white,
          border: Border.all(color: AppColors.buttoncolor, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.bold,
            color: AppColors.buttoncolor,
          ),
        ),
      ),
    );
  }
}
