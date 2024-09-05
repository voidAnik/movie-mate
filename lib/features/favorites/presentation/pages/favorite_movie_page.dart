import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/favorites/presentation/blocs/favorite_movies_cubit.dart';
import 'package:movie_mate/features/favorites/presentation/widgets/movie_list_tile_widget.dart';
import 'package:movie_mate/features/favorites/presentation/widgets/shimmer_list_item.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/movie_details/presentation/pages/movie_details_page.dart';

class FavoriteMoviePage extends StatelessWidget {
  static const String path = '/favorite_movie_page';
  const FavoriteMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => getIt<FavoriteMoviesCubit>()..fetchMovies(),
  child: Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.favoriteMovies.tr(),
            style: context.textStyle.titleMedium!.copyWith(
          fontSize: context.width * 0.05,
        )),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteMoviesCubit, DataState>(
        builder: (context, state) {
          log('favorite state ${state.runtimeType}');
          if (state is DataLoading) {
            return _createShimmerList(6);
          } else if(state is DataError){
            return ErrorMessage(message: state.error);
          }
          else if (state is DataSuccess) {
            final List<Movie> favoriteMovies = state.data;
          if (favoriteMovies.isEmpty) {
            return const Center(child: Text('No favorites added yet.'));
          }
            return _createFavoriteList(favoriteMovies);
          }  else {
            return const Center(child: Text('Failed to load favorites.'));
          }
        },
      ),
    ),
);
  }

  ListView _createFavoriteList(List<Movie> favoriteMovies) {
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
                    SnackBar(content: Text('${movie.originalTitle} removed from favorites')),
                  );
                },
                background: Container(
                  color: Colors.red, // Background color
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Icon(Icons.delete, color: Colors.white), // Icon color
                ),
                child: MovieListTileWidget(onPressed: (){
                  _navigateToMovieDetailPage(context, movie: movie);
                }, movie: movie),
              );
            },
          );
  }

  ListView _createShimmerList(int length) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: length,
      itemBuilder: (context, index) {
        return const ShimmerListItem();
      },
    );
  }

  _navigateToMovieDetailPage(BuildContext context, {required Movie movie}) {
    context.push(MovieDetailsPage.path, extra: movie);
  }
}
