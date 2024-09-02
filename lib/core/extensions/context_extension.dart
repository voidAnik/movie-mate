import 'package:flutter/material.dart';

extension SizeExtension on BuildContext{
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
}

extension ThemeExtension on BuildContext{
  ThemeData get theme => Theme.of(this);
  TextTheme get textStyle => theme.textTheme;
}