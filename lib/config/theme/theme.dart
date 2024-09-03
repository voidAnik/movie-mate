import 'package:flutter/material.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/config/theme/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: accentLightColor,
      surface: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(
      color: backgroundColor,
      iconTheme: IconThemeData(color: actionBarIconColor),
      elevation: 0,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: accentLightColor,
      disabledColor: primaryColorDark,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: accentLightColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentLightColor,
      foregroundColor: Colors.black,
    ),
    iconTheme: const IconThemeData(color: actionBarIconColor),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white70,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      border: OutlineInputBorder(),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: primaryDarkColor,
      primary: primaryDarkColor,
      secondary: accentDarkColor,
      surface: backgroundDarkColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    scaffoldBackgroundColor: backgroundDarkColor,
    textTheme: AppTextTheme.darkTextTheme,
    appBarTheme: const AppBarTheme(
      color: backgroundDarkColor,
      iconTheme: IconThemeData(color: actionBarIconDarkColor),
      elevation: 0,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: accentDarkColor,
      disabledColor: primaryDarkColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: accentDarkColor,

      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentDarkColor,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: actionBarIconDarkColor),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.black54,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryDarkColor),
      ),
      border: OutlineInputBorder(),
    ),
  );
}
