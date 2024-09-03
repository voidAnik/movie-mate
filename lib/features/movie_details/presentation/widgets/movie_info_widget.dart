import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/error_widget.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_details.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/expand_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/blocs/movie_details_cubit.dart';
import 'package:movie_mate/features/movie_details/presentation/widgets/star_rating_widget.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';


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
        return const Center(child: CircularProgressIndicator());
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
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            movieInfo.title ?? '',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: context.textStyle.headlineMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            movieInfo.genreNames,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: context.textStyle.bodyMedium!.copyWith(
              color: context.theme.colorScheme.secondaryFixedDim
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: StarRatingWidget(
            size: 24.0,
            rating: movieInfo.voteAverage / 2,
            color: Colors.red,
            borderColor: Colors.black54,
            starCount: 5,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(''),
              _columnItem(context, title: LocaleKeys.year.tr(), value: movieInfo.releasedYear),
              _columnItem(context, title: LocaleKeys.country.tr(), value: movieInfo.country),
              _columnItem(context, title: LocaleKeys.length.tr(), value: movieInfo.runtime.toString() ?? ''),
              const Text(''),
            ],
          ),
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
                  style: context.textStyle.headlineMedium,
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
              maxLines: state ? 100 : 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black45,
                fontFamily: 'Muli',
              ),
            ),
          ),
        );
      },
    );
  }

}
