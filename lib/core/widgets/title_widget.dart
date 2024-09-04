import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mate/core/constants/strings.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: GoogleFonts.aldrich(
          fontSize: context.width * 0.05,
          color: Colors.red
      ),
    );
  }
}
