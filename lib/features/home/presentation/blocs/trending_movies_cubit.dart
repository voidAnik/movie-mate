import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_trending_movies.dart';
import 'package:movie_mate/core/error/failures.dart';

class TrendingMoviesCubit extends CommonApiCubit<List<MovieModel>> {
  final GetTrendingMovies getTrendingMovies;
  int _currentPage = 1;
  bool _hasMoreMovies = true;
  List<MovieModel> _movies = [];

  TrendingMoviesCubit(this.getTrendingMovies);

  Future<void> fetchMovies({int page = 1}) async {
    if (!_hasMoreMovies && page != 1) {
      return; // Prevent additional loads if no more movies
    }

    //emit(ApiLoading());
    final Either<Failure, List<MovieModel>> failureOrResponse =
        await getTrendingMovies(params: page);

    failureOrResponse.fold((failure) {
      emit(ApiError(message: _mapFailureToMessage(failure)));
    }, (response) {
      _movies.addAll(response);
      if (page == 1) {
        _movies = response;
      } else {
        _movies.addAll(response);
      }
      // Append new movies to the existing list
      emit(ApiSuccess(response: List.from(_movies)));

      _hasMoreMovies = response.isNotEmpty;
      if (response.isNotEmpty) _currentPage++;
    });
  }

  Future<void> loadMoreMovies() async {
    fetchMovies(page: _currentPage);
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.error;
    }
    return 'Unknown Exception';
  }
}
