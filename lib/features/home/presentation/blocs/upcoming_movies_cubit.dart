import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_upcoming_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';

class UpcomingMoviesCubit extends CommonApiCubit<List<MovieModel>> {
  final GetUpcomingMovies getUpcomingMovies;
  int _currentPage = 1;
  bool _hasMoreMovies = true;
  List<MovieModel> _movies = [];

  UpcomingMoviesCubit(this.getUpcomingMovies);

  Future<void> fetchMovies({int page = 1}) async {
    if (!_hasMoreMovies && page != 1) return; // Prevent additional loads if no more movies

   // emit(ApiLoading());
    final Either<Failure, List<MovieModel>> failureOrResponse = await getUpcomingMovies(params: page);

    failureOrResponse.fold(
          (failure) {
        emit(ApiError(message: _mapFailureToMessage(failure)));
      },
          (response) {
        if (page == 1) {
          _movies = response; // Reset the list if it's the first page
        } else {
          _movies.addAll(response); // Append new movies to the existing list
        }

        _hasMoreMovies = response.isNotEmpty; // Update based on response
        emit(ApiSuccess<List<MovieModel>>(response: List.from(_movies)));

        if (response.isNotEmpty) _currentPage++;
        if(_movies.length < 10){
          loadMoreMovies();
        }
      },
    );
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
