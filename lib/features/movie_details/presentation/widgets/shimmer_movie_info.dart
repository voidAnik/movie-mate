import 'package:flutter/material.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';

class ShimmerMovieInfo extends StatelessWidget {
  const ShimmerMovieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _shimmerItem(context, height: 200, width: double.infinity),
          const SizedBox(height: 16.0),
          _shimmerItem(context, height: 20, width: double.infinity),
          const SizedBox(height: 8.0),
          _shimmerItem(context, height: 20, width: double.infinity),
          const SizedBox(height: 8.0),
          _shimmerItem(context, height: 20, width: double.infinity),

        ],
      ),
    );
  }

  Widget _shimmerItem(context, {required double height, required double width}){
    return ShimmerLoading(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
