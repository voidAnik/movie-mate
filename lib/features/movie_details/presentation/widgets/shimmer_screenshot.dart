import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';

class ShimmerMovieScreenshot extends StatelessWidget {
  const ShimmerMovieScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width / 2.4;
    return Container(
      width: width,
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: ShimmerLoading(
              child: Container(
                width: width,
                height: double.infinity,
                color: Colors.black, // or use a light color if your theme is dark
              ),
            ),
          ),
        ),
      ),
    );
  }
}