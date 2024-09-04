import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class FavoriteMovieRepository{
  Future<Either<Failure, List<MovieModel>>> getFavoriteMovies();
  Future<Either<Failure, void>> saveFavoriteMovie({required MovieModel movie});
  Future<Either<Failure, void>> deleteFavoriteMovie({required int movieId});
  Future<Either<Failure, bool>> isFavorite({required int movieId});
}