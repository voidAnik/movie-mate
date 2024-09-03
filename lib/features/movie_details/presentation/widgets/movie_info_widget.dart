import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
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
        return Text(state.message);
      } else if (state is ApiSuccess) {
        return _createMovieBody(context, state.response);
      } else {
        return const Text('not supported');
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black87,
              fontFamily: 'Muli',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Text(
            movieInfo.genreNames,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.black45,
              fontFamily: 'Muli',
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
              Column(
                children: [
                  const Text(
                    'Year',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontFamily: 'Muli',
                    ),
                  ),
                  Text(
                    movieInfo.releasedYear,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontFamily: 'Muli',
                    ),
                  ),
                  Text(
                    movieInfo.country,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Length',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black45,
                      fontFamily: 'Muli',
                    ),
                  ),
                  Text(
                    movieInfo.runtime.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Muli',
                    ),
                  ),
                ],
              ),
              const Text(''),
            ],
          ),
        ),
        _createMovieOverview(context, movieInfo.overview),
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
