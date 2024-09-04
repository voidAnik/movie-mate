import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class HomeRepository{
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies({required int page});
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies({required int page});
  Future<Either<Failure, List<MovieModel>>> searchMovies({required String query});
}