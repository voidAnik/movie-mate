import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/core/blocs/common_api_state.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/use_cases/get_trending_movies.dart';
import 'package:movie_mate/features/home/domain/use_cases/search_movies.dart';

class MovieSearchCubit extends CommonApiCubit<List<MovieModel>>{
  final SearchMovies searchMovies;


  MovieSearchCubit(this.searchMovies);

  Future<void> search({required String query}) async {
    performApiCall(() => searchMovies(params: query));
  }
  void reset(){
    emit(ApiInitial());
  }
}