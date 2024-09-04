import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key, required this.child, this.enable = true});

  final Widget child;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.theme.brightness == Brightness.light ? Colors.grey[300]! : Colors.grey[800]!,
      highlightColor:context.theme.brightness == Brightness.light ? Colors.grey[100]! : Colors.grey[600]!,
      child: IgnorePointer(child: child),
    );
  }
}
