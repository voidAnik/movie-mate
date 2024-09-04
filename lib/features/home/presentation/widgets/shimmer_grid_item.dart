
import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';

class ShimmerGridItem extends StatelessWidget {
  const ShimmerGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: double.infinity,  // Set height as needed
        width:context.width * 0.05,  // Adjust width if necessary
      ),
    );
  }
}