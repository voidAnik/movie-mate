import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRatingWidget extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final double? size;

  const StarRatingWidget({super.key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.size,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    var ratingStarSizeRelativeToScreen = context.width / starCount;

    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: context.theme.colorScheme.secondaryFixedDim,
        size: size ?? ratingStarSizeRelativeToScreen,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: context.theme.colorScheme.primary,
        size: size ?? ratingStarSizeRelativeToScreen,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: context.theme.colorScheme.primary,
        size: size ?? ratingStarSizeRelativeToScreen,
      );
    }
    return InkResponse(
      highlightColor: Colors.transparent,
      radius: (size ?? ratingStarSizeRelativeToScreen) / 2,
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: SizedBox(
        height: (size ?? ratingStarSizeRelativeToScreen) * 1.5,
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            starCount,
            (index) => buildStar(context, index),
          ),
        ),
      ),
    );
  }
}
