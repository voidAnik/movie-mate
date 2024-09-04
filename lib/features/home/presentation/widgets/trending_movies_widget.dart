import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/core/widgets/network_image.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/home/presentation/blocs/trending_movies_cubit.dart';
import 'package:movie_mate/features/home/presentation/widgets/movie_list_item_widget.dart';

class TrendingMoviesWidget extends StatelessWidget {
  final Function(Movie) onPressedMovie;
  const TrendingMoviesWidget({super.key, required this.onPressedMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TrendingMoviesCubit>()..fetchMovies(),
      child: _createView(context),
    );
  }

  _createView(BuildContext context) {
    return BlocBuilder<TrendingMoviesCubit, CommonApiState>(
        builder: (context, state) {
          if (state is ApiInitial || state is ApiLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          } else if (state is ApiError) {
            return ErrorMessage(message: state.message);
          } else if (state is ApiSuccess) {
            final movies = state.response;
            return _createTrendingMovieList(context, movies);
          } else {
            return const Spacer();
          }
        }
    );
  }

  Column _createTrendingMovieList(BuildContext context, movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(LocaleKeys.trendingMovies.tr(),
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
              return MovieListItemWidget(movie: movies[index],onPressed: () => onPressedMovie(movies[index]));
            },
          ),
        ),
      ],
    );
  }


}
