import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/movie_search_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/pages/movie_details_page.dart';

class MovieSearchDelegate extends SearchDelegate<Movie> {
  final MovieSearchCubit searchCubit;

  MovieSearchDelegate(this.searchCubit);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchCubit.reset();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Trigger the search when results are built
    if (query.isNotEmpty) {
      log('searching...');
      searchCubit.search(query: query); // Trigger search on submit
    }
    return BlocBuilder<MovieSearchCubit, CommonApiState>(
      bloc: searchCubit,
      builder: (context, state) {
        if (state is ApiLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ApiSuccess) {
          final List<Movie> movies = state.response;

          if (movies.isEmpty) {
            //return const Center(child: Text('No movies found.'));
            return const ErrorMessage(message: 'No movies found.',);
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: movie.id,
                    child: CustomNetworkImage(
                      imageUrl: movie.backdropPath,
                      width: context.width * 0.2,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(movie.title, style: context.textStyle.titleSmall,),
                subtitle: Text(movie.releaseDate.split('-')[0], style: context.textStyle.bodySmall,),
                trailing: const Icon(
                  Icons.arrow_forward_ios
                ),
                onTap: ()=> _navigateToMovieDetailPage(context, movie: movie),
              );
            },
          );
        } else if (state is ApiError) {
          return ErrorMessage(message: state.message);
        } else {
          return  _searchMessage(context, 'Start typing to search for movies.');
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // this is a network call so I don't want to search on every key change
   /* if (query.isEmpty) {
      return _searchMessage(context, 'Enter movie name to search.');
    } else {
      searchCubit.search(query: query); // Trigger search on query change
      return buildResults(context);
    }*/
    return _searchMessage(context, 'Enter a movie name and press enter to search.');
  }

  Widget _searchMessage(BuildContext context, String text){
    return  Center(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(text,
      textAlign: TextAlign.center,
      style: context.textStyle.titleMedium,),
    ),);
  }

  _navigateToMovieDetailPage(BuildContext context, {required Movie movie}) {
    context.push(MovieDetailsPage.path, extra: movie);
  }
}
