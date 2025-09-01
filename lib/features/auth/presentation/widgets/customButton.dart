import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app_colors.dart';

Widget customButton(String text, void Function() fun) {
  return InkWell(
    onTap: () => fun(),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 5,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      letterSpacing: 1.5,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            )),
      ),
    ),
  );
}
