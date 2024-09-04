import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/favorites/presentation/blocs/favorite_movies_cubit.dart';
import 'package:movie_mate/features/favorites/presentation/widgets/movie_list_tile.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';

class FavoriteMoviePage extends StatelessWidget {
  static const String path = '/favorite_movie_page';
  const FavoriteMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => getIt<FavoriteMoviesCubit>()..fetchMovies(),
  child: Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies', style: context.textStyle.titleMedium),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteMoviesCubit, DataState>(
        builder: (context, state) {
          log('favorite state ${state.runtimeType}');
          if (state is DataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if(state is DataError){
            return ErrorMessage(message: state.error);
          }
          else if (state is DataSuccess) {
            final List<Movie> favoriteMovies = state.data;
          if (favoriteMovies.isEmpty) {
            return const Center(child: Text('No favorites added yet.'));
          }

            return ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return Dismissible(
                  key: Key(movie.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<FavoriteMoviesCubit>().deleteMovie(movieId: movie.id, index: index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${movie.title} removed from favorites')),
                    );
                  },
                  background: const Icon(Icons.delete, color: Colors.white),
                  child: MovieListTileWidget(onPressed: (){
                    _navigateToMovieDetailPage(context, movie);
                  }, movie: movie),
                );
              },
            );
          }  else {
            return const Center(child: Text('Failed to load favorites.'));
          }
        },
      ),
    ),
);
  }

  void _navigateToMovieDetailPage(BuildContext context, Movie movie) {
    // Navigate to the movie detail page
  }
}
