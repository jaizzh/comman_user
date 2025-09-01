import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app_colors.dart';

Widget signin(String text1, String text2, void Function() fun) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text1,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            letterSpacing: 1.5,
            height: 1.3,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        onTap: () => fun(),
        child: Text(
          text2,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 1.5,
              height: 1.3,
            ),
          ),
        ),
      ),
    ],
  );
}
