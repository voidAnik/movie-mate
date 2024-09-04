import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

class FavoriteIconWidget extends StatelessWidget {
  final void Function(bool isFavorite) onFavoriteChanged;
  final bool isFavorite;

  const FavoriteIconWidget({
    super.key,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : context.theme.colorScheme.onSecondary,
      ),
      onPressed: () => onFavoriteChanged(isFavorite),
    );
  }
}
