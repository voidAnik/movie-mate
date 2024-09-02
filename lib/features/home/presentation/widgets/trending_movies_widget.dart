import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_trending_movies.dart';
import 'package:movie_mate/features/home/presentation/blocs/get_trending_movies_cubit.dart';

class TrendingMoviesWidget extends StatelessWidget {
  const TrendingMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetTrendingMoviesCubit>()..fetch(),
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
                  height: context.width * 0.01,
                ),
                SizedBox(
                  height: 400,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    padding: const EdgeInsets.all(8.0), // padding around the grid
                    itemCount: movies.length, // total number of items
                    itemBuilder: (context, index) {
                      return _createItem(context, movies[index]);
                    },
                  ),
                )
              ],
            );;
          } else {
            return const Spacer();
          }
        }
    );
  }

  Widget _createItem(BuildContext context, Movie movie) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return InkWell(
      onTap: () {

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
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: movie.posterPath,
                width: width,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
