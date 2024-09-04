import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_trending_movies.dart';

class TrendingMoviesCubit extends CommonApiCubit<List<MovieModel>>{
  final GetTrendingMovies getTrendingMovies;


  TrendingMoviesCubit(this.getTrendingMovies);

  Future<void> fetchMovies() async {
    performApiCall(() => getTrendingMovies(params: 2));
  }
}