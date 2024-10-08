import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';

class MovieGridItemWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onPressed;
  const MovieGridItemWidget({super.key, required this.onPressed, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
            fit: StackFit.passthrough,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: movie.id,
                  child: CustomNetworkImage(
                    imageUrl: movie.posterPath,
                    width: context.width * 0.05,
                    height: double.infinity,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0x66000000),
                      Color(0x66000000),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title.toUpperCase() ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyle.titleSmall!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(movie.releaseDate.split('-')[0],
                      style: context.textStyle.titleSmall!.copyWith(
                          fontSize: 10,
                          color: Colors.white
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(getIt<GenreService>().getCommaSeparatedGenres(movie.genreIds),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyle.titleSmall!.copyWith(
                          fontSize: 10,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}

