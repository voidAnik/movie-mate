import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';

class MovieListTileWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Movie movie;

  const MovieListTileWidget(
      {super.key, required this.onPressed, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: movie.id,
            child: CustomNetworkImage(
              imageUrl: movie.backdropPath,
              width: context.width * 0.2,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textStyle.titleSmall!.copyWith(
              fontSize: 12
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.releaseDate.split('-')[0],
              style: context.textStyle.bodySmall!.copyWith(
                fontSize: 10
              ),
            ),
            Text(
              getIt<GenreService>().getCommaSeparatedGenres(movie.genreIds),
              style: context.textStyle.bodySmall!.copyWith(
                  fontSize: 10
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }
}
