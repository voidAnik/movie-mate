import 'package:movie_mate/core/blocs/common_api_cubit.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_image.dart';
import 'package:movie_mate/features/movie_details/domain/use_cases/get_movie_images.dart';

class MovieImagesCubit extends CommonApiCubit<List<MovieImage>>{
  final GetMovieImages getMovieImages;

  MovieImagesCubit(this.getMovieImages);

  Future<void> fetchImages({required int movieId}) async {
    performApiCall(() => getMovieImages(params: movieId));
  }
}