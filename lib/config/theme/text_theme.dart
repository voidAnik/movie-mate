import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme{

  static TextTheme lightTextTheme = TextTheme(
  headlineLarge: GoogleFonts.openSans(
  fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
  headlineMedium: GoogleFonts.openSans(
  fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
  headlineSmall: GoogleFonts.openSans(
  fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
  titleLarge: GoogleFonts.openSans(
  fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
  titleMedium: GoogleFonts.openSans(
  fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
  titleSmall: GoogleFonts.openSans(
  fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black),
  bodyLarge: GoogleFonts.openSans(fontSize: 16.0, color: Colors.black),
  bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Colors.black),
  bodySmall: GoogleFonts.openSans(fontSize: 12.0, color: Colors.black),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.openSans(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.white),
    headlineMedium: GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    titleLarge: GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: GoogleFonts.openSans(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, color: Colors.white),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Colors.white),
    bodySmall: GoogleFonts.openSans(fontSize: 12.0, color: Colors.white),
  );
}