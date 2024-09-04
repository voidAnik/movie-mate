
import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      //surfaceTintColor: Colors.grey,
      shadowColor: context.theme.colorScheme.primary,
      color: context.theme.colorScheme.primary,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 6, right: 6, bottom: 2, top: 2),
        child: Text(genre,
            style: context.textStyle.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 10
            ),
            textAlign: TextAlign.center),
      ),
    );
  }
}