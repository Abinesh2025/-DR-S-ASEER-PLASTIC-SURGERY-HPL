import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleConst {
  static TextStyle mediumTextStyle(Color color, double fontSize) => GoogleFonts.nunitoSans(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w600,
    decoration: TextDecoration.none
      );
  static TextStyle boldTextStyle(Color color, double fontSize) => GoogleFonts.nunitoSans(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w700,
      decoration: TextDecoration.none
      );
  static TextStyle hintTextStyle(Color color) => GoogleFonts.nunitoSans(
        fontSize: 17,
        color: color,
        fontWeight: FontWeight.w600,
      decoration: TextDecoration.none
      );
  static TextStyle forgotTextStyle(Color color, double fontSize) => GoogleFonts.nunitoSans(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      decoration: TextDecoration.none
      );
  static TextStyle regularTextStyle(Color color, double fontSize) => GoogleFonts.nunitoSans(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      decoration: TextDecoration.none
      );
}
