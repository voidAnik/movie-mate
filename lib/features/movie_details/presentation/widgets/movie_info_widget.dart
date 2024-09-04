import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/expand_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_details_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/widgets/shimmer_movie_info.dart';
import 'package:movie_mate/features/movie_details/presentation/widgets/star_rating_widget.dart';


class MovieInfoWidget extends StatelessWidget {
  final Movie movie;

  const MovieInfoWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(create: (_) => ExpandCubit()),
      ],
      child: _createMovieInfo(context),
    );
  }

Widget _createMovieInfo(BuildContext context){
  return BlocBuilder<MovieDetailsCubit, CommonApiState>(
    builder: (context, state) {
      if (state is ApiInitial || state is ApiLoading) {
        return const ShimmerMovieInfo();
      } else if (state is ApiError) {
        return ErrorMessage(message: state.message);
      } else if (state is ApiSuccess) {
        return _createMovieBody(context, state.response);
      } else {
        return ErrorMessage(message: LocaleKeys.unknownError.tr());
      }
    },
  );
}
  Widget _createMovieBody(BuildContext context, MovieDetailsModel movieInfo) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          movieInfo.title ?? '',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: context.textStyle.headlineMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          movieInfo.genreNames,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: context.textStyle.bodyMedium!.copyWith(
            color: context.theme.colorScheme.secondaryFixedDim
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          alignment: Alignment.center,
          child: StarRatingWidget(
            size: 24.0,
            rating: movieInfo.voteAverage / 2,
            starCount: 5,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(''),
            _columnItem(context, title: LocaleKeys.year.tr(), value: movieInfo.releasedYear),
            _columnItem(context, title: LocaleKeys.country.tr(), value: movieInfo.country),
            _columnItem(context, title: LocaleKeys.length.tr(), value: movieInfo.runtime.toString() ?? ''),
            const Text(''),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        _createMovieOverview(context, movieInfo.overview),
      ],
    );
  }

  Column _columnItem(BuildContext context, {required String title, required String value}) {
    return Column(
              children: [
                Text(
                  title,
                  style: context.textStyle.bodyMedium!.copyWith(
                    color: context.theme.colorScheme.secondaryFixedDim,
                  ),
                ),
                Text(
                  value,
                  style: context.textStyle.titleMedium,
                ),
              ],
            );
  }

  Widget _createMovieOverview(BuildContext context, String overview) {
    return BlocBuilder<ExpandCubit, bool>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<ExpandCubit>().toggle();
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
            child: Text(
              overview,
              textAlign: TextAlign.justify,
              maxLines: state ? 100 : 4,
              overflow: TextOverflow.ellipsis,
              style: context.textStyle.bodyMedium!.copyWith(
                color: context.theme.colorScheme.secondaryFixedDim,
              ),
            ),
          ),
        );
      },
    );
  }

}
