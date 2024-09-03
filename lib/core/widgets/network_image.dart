import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  const CustomNetworkImage({super.key, required this.width, required this.height, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => ShimmerLoading(child: Container(
        height: height,
        width: width,
        color: Colors.black,
      )),
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
