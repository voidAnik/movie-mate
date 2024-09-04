import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/features/favorites/presentation/widgets/movie_list_tile_widget.dart';
import 'package:movie_mate/features/favorites/presentation/widgets/shimmer_list_item.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/movie_search_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/pages/movie_details_page.dart';

class MovieSearchDelegate extends SearchDelegate<Movie> {
  final MovieSearchCubit searchCubit;
  bool _hasSearched = false;

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
          return _createShimmerList(5);
        } else if (state is ApiSuccess) {
          final List<Movie> movies = state.response;

          if (movies.isEmpty) {
            //return const Center(child: Text('No movies found.'));
            return ErrorMessage(message: LocaleKeys.noMovies.tr(),);
          }
          _hasSearched = true;
          return _createSearchList(movies);
        } else if (state is ApiError) {
          return ErrorMessage(message: state.message);
        } else {
          return  _searchMessage(context, LocaleKeys.searchHint.tr());
        }
      },
    );
  }

  ListView _createSearchList(List<Movie> movies) {
    return ListView.builder(
          padding: const EdgeInsets.only(top: 8.0),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieListTileWidget(onPressed: (){
              _navigateToMovieDetailPage(context, movie: movie);
            }, movie: movie);
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

  @override
  Widget buildSuggestions(BuildContext context) {
    // this is a network call so I don't want to search on every key change
   /* if (query.isEmpty) {
      return _searchMessage(context, 'Enter movie name to search.');
    } else {
      searchCubit.search(query: query); // Trigger search on query change
      return buildResults(context);
    }*/
    if(_hasSearched){
      return BlocBuilder<MovieSearchCubit, CommonApiState>(
        bloc: searchCubit,
        builder: (context, state) {
          if (state is ApiLoading) {
            return _createShimmerList(5);
          } else if (state is ApiSuccess) {
            final List<Movie> movies = state.response;

            if (movies.isEmpty) {
              //return const Center(child: Text('No movies found.'));
              return ErrorMessage(message: LocaleKeys.noMovies.tr(),);
            }
            _hasSearched = true;
            return _createSearchList(movies);
          } else if (state is ApiError) {
            return ErrorMessage(message: state.message);
          } else {
            return  _searchMessage(context, LocaleKeys.searchHint.tr());
          }
        },
      );
    } else {
      return _searchMessage(context, LocaleKeys.searchHint.tr());
    }
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
