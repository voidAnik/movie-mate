import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_details.dart';
import 'package:movie_mate/features/movie_details/domain/use_cases/get_movie_details.dart';

class MovieDetailsCubit extends CommonApiCubit<MovieDetails>{
  final GetMovieDetails getMovieDetails;

  MovieDetailsCubit(this.getMovieDetails);

  Future<void> fetchInfo({required int movieId}) async {
    performApiCall(() => getMovieDetails(params: movieId));
  }
}