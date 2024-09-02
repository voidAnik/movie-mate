import 'package:flutter/material.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/config/theme/text_theme.dart';


class AppTheme{
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(
      color: backgroundColor,
      iconTheme: IconThemeData(color: actionBarIconColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: accentLightColor,
      disabledColor: primaryColorDark,
    ),

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme,
  );
}
