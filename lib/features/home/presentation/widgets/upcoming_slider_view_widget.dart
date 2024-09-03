import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/get_upcoming_movies_cubit.dart';


class UpcomingSliderView extends StatelessWidget {
  final Function(Movie) onPressedMovie;

  const UpcomingSliderView({super.key, required this.onPressedMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<GetUpcomingMoviesCubit>()..fetchMovies();
      },
      child: _createSlider(context),
    );
  }

  Widget _createSlider(BuildContext context) {
    return BlocBuilder<GetUpcomingMoviesCubit, CommonApiState>(
      builder: (context, state) {
        if (state is ApiInitial || state is ApiLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        } else if (state is ApiError) {
          return Text(state.message);
        } else if (state is ApiSuccess<List<Movie>>) {
          final movies = state.response;
          return CarouselSlider.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              return _createSliderItem(context, movies[itemIndex]);
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          );
        } else {
          return const Spacer();
        }
      },
    );
  }

  Widget _createSliderItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        onPressedMovie(movie);
      },
      child: Container(
        width: width,
        height: double.infinity,
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 10.0,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: width,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Hero(
                    tag: movie.id,
                    child: CustomNetworkImage(
                      imageUrl: movie.backdropPath,
                      width: width,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    width: width,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({Key? key, required this.genre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      //surfaceTintColor: Colors.grey,
      shadowColor: context.theme.primaryColor,
      color: context.theme.primaryColor,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 6, right: 6, bottom: 2),
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
