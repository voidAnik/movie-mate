import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_image_model.dart';

abstract class MovieDetailRepository{
  Future<Either<Failure, List<MovieImageModel>>> getMovieImages({required int movieId});
  Future<Either<Failure, MovieDetailsModel>> getMovieDetails({required int movieId});
}