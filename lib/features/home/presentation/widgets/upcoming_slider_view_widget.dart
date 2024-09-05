import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/upcoming_movies_cubit.dart';
import 'package:movie_mate/features/home/presentation/widgets/shimmer_slider_item.dart';
import 'package:movie_mate/features/home/presentation/widgets/slider_item_widget.dart';

class UpcomingSliderView extends StatelessWidget {
  final Function(Movie) onPressedMovie;

  const UpcomingSliderView({super.key, required this.onPressedMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<UpcomingMoviesCubit>()..fetchMovies();
      },
      child: _createView(context),
    );
  }

  Widget _createView(BuildContext context) {
    return BlocBuilder<UpcomingMoviesCubit, CommonApiState>(
      builder: (context, state) {
        if (state is ApiInitial || state is ApiLoading) {
          return _createShimmerSlider(10);
        } else if (state is ApiError) {
          return ErrorMessage(message: state.message);
        } else if (state is ApiSuccess<List<Movie>>) {
          final movies = state.response;
          return _createSlider(context, movies);
        } else {
          return const Spacer();
        }
      },
    );
  }

  CarouselSlider _createSlider(BuildContext context, List<Movie> movies) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return SliderItemWidget(
          movie: movies[itemIndex],
          onPressed: () => onPressedMovie(movies[itemIndex]),
        );
      },
      options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          pauseAutoPlayOnTouch: true,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            log('cursol page index: $index');
            if (index == movies.length - 1) {
              context.read<UpcomingMoviesCubit>().loadMoreMovies();
            }
          }),
    );
  }

  CarouselSlider _createShimmerSlider(int length) {
    return CarouselSlider.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return const ShimmerSliderItem();
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
  }
}
