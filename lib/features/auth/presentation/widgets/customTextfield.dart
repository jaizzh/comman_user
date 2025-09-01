import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app_colors.dart';

Widget customTextfield(
  String hint,
  TextEditingController controller,
  IconData icon,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: TextField(
          controller: controller, // ✅ FIX ADDED HERE
          keyboardType: hint.toLowerCase().contains('mobile')
              ? TextInputType.phone
              : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            labelText: hint,
            labelStyle: GoogleFonts.aBeeZee(
              textStyle: const TextStyle(
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
