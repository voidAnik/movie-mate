import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_upcoming_movies.dart';

class UpcomingMoviesCubit extends CommonApiCubit<List<MovieModel>>{
  final GetUpcomingMovies getUpcomingMovies;


  UpcomingMoviesCubit(this.getUpcomingMovies);

  Future<void> fetchMovies() async {
    performApiCall(() => getUpcomingMovies(params: 4));
  }
}