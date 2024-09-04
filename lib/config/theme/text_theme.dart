import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme{

  static TextTheme darkTextTheme = TextTheme(
  headlineLarge: GoogleFonts.poppins(
  fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
  headlineMedium: GoogleFonts.poppins(
  fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
  headlineSmall: GoogleFonts.poppins(
  fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
  titleLarge: GoogleFonts.poppins(
  fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  titleMedium: GoogleFonts.poppins(
  fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
  titleSmall: GoogleFonts.poppins(
  fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white),
  bodyLarge: GoogleFonts.poppins(fontSize: 16.0, color: Colors.white),
  bodyMedium: GoogleFonts.poppins(fontSize: 14.0, color: Colors.white),
  bodySmall: GoogleFonts.poppins(fontSize: 12.0, color: Colors.white),
  );

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: GoogleFonts.poppins(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyLarge: GoogleFonts.poppins(fontSize: 16.0, color: Colors.black),
    bodyMedium: GoogleFonts.poppins(fontSize: 14.0, color: Colors.black),
    bodySmall: GoogleFonts.poppins(fontSize: 12.0, color: Colors.black),
  );
}