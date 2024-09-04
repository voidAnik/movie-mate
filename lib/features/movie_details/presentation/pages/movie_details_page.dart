import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/add_favorite_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_details_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/widgets/header_widget.dart';
import 'package:movie_mate/features/movie_details/presentation/widgets/widgets.dart';


class MovieDetailsPage extends StatelessWidget {
  static const String path = '/movie_details_page';
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          getIt<MovieDetailsCubit>()
            ..fetchInfo(movieId: movie.id),
        ),
        BlocProvider(
          create: (context) =>
          getIt<AddFavoriteCubit>()
            ..getIsFavorite(movieId: movie.id),
        ),
      ],
      child: WillPopScope(
        child: Scaffold(
          body: _createDetailBody(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget _createDetailBody(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<AddFavoriteCubit, bool>(
          builder: (context, state) {
            log('test bloc build: $state');
            return Container();
          },
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight),
                child: Column(
                  children: [
                    HeaderWidget(movie: movie),
                    MovieInfoWidget(movie: movie),
                    const Divider(height: 8.0, color: Colors.transparent),
                    ScreenshotViewWidget(
                      movieId: movie.id,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        _createAppbar(context),
      ],
    );
  }


  Widget _createAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        elevation: 0.0,
        titleSpacing: 4.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: BlocBuilder<AddFavoriteCubit, bool>(
              builder: (context, isFavorite) {
                log('changed bloc favorite: $isFavorite');
                return FavoriteIconWidget(
                    isFavorite: isFavorite, onFavoriteChanged: (checked) {
                  log('changed favorite: $checked');
                  _toggleFavorite(context, checked);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(BuildContext context, bool checked) {
    context.read<AddFavoriteCubit>().toggleFavorite(
        isFavorite: checked, movie: movie);
  }


}
