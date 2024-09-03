import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/config/theme/colors.dart';

class FavoriteIconWidget extends StatefulWidget {
  final void Function(bool isFavorite) onFavoriteChanged;
  final bool isFavorite;

  const FavoriteIconWidget({
    super.key,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  State<StatefulWidget> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIconWidget> {
  bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite! ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        toggleFavorite();
      },
    );
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite!;
      widget.onFavoriteChanged(isFavorite!);
    });
  }

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }
}
