import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/favorites/domain/repositories/favorite_movie_repository.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

class GetFavoriteMovies extends UseCase<List<MovieModel>, NoParams>{
  final FavoriteMovieRepository repository;

  GetFavoriteMovies(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call({required NoParams params}) {
    return repository.getFavoriteMovies();
  }

}