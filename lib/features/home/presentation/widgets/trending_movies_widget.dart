import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/get_trending_movies_cubit.dart';

class TrendingMoviesWidget extends StatelessWidget {
  final Function(Movie) onPressedMovie;
  const TrendingMoviesWidget({super.key, required this.onPressedMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetTrendingMoviesCubit>()..fetchMovies(),
      child: _createView(context),
    );
  }

  _createView(BuildContext context) {
    return BlocBuilder<GetTrendingMoviesCubit, CommonApiState>(
        builder: (context, state) {
          if (state is ApiInitial || state is ApiLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (state is ApiError) {
            return Text(state.message);
          } else if (state is ApiSuccess<List<Movie>>) {
            final movies = state.response;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Trending Movies',
                    style: context.textStyle.headlineMedium,
                  ),
                ),
                SizedBox(
                  height: context.width * 0.03,
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                      childAspectRatio: 0.7
                    ),
                    padding: const EdgeInsets.all(8.0), // padding around the grid
                    itemCount: movies.length, // total number of items
                    itemBuilder: (context, index) {
                      return _createItem(context, movies[index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Spacer();
          }
        }
    );
  }

  Widget _createItem(BuildContext context, Movie movie) {
    return InkWell(
      onTap: () {
        onPressedMovie(movie);
      },
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