import 'package:flutter/material.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';

class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 80.0, // Approximate height of the ListTile
          decoration: BoxDecoration(
            color: Colors.grey[700], // Placeholder color for the entire tile
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}