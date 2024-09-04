
import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';

class ShimmerSliderItem extends StatelessWidget {
  const ShimmerSliderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: double.infinity,
        width:context.width,
      ),
    );
  }
}