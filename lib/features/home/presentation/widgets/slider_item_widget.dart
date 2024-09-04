import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/widgets/genre_card.dart';

class SliderItemWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onPressed;
  const SliderItemWidget({super.key, required this.movie, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: context.width,
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 10.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: context.width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Hero(
                    tag: movie.id,
                    child: CustomNetworkImage(
                      imageUrl: movie.backdropPath,
                      width: context.width,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    width:context.width,
                    height: double.infinity,
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0x00000000),
                          Color(0x00000000),
                          Color(0x22000000),
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
                          style: context.textStyle.headlineSmall!.copyWith(
                              color: Colors.white
                          ),
                        ),
                        Text(movie.releaseDate.split('-')[0],
                          style: context.textStyle.bodySmall!.copyWith(
                              color: Colors.white
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          //spacing: 2.0,
                          // gap between adjacent chips
                          //runSpacing: 2.0,
                          children: movie.genreIds.map((genreId) {
                            return GenreCard(
                              genre: getIt<GenreService>().getGenreName(genreId),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Upcoming',
                      style: context.textStyle.headlineSmall!.copyWith(
                        color: context.theme.primaryColor,
                        fontSize: 12
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
