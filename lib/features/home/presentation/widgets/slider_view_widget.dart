import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/get_upcoming_movies_cubit.dart';


class SliderView extends StatelessWidget {
  final Function(Movie) actionOpenMovie;

  const SliderView({super.key, required this.actionOpenMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<GetUpcomingMoviesCubit>()..fetch();
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
        actionOpenMovie(movie);
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
                  CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl: movie.backdropPath,
                    width: width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: width,
                    height: double.infinity,
                    padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
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
                    child: Text(
                      movie.title.toUpperCase() ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyle.headlineMedium!.copyWith(
                        color: context.theme.primaryColor,
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
