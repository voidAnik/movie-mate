import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/favorites/domain/repositories/favorite_movie_repository.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';

class SaveFavoriteMovie extends UseCase<void, Movie>{
  final FavoriteMovieRepository repository;

  SaveFavoriteMovie(this.repository);

  @override
  Future<Either<Failure, void>> call({required Movie params}) {
    return repository.saveFavoriteMovie(movie: MovieModel.fromEntity(params));
  }

}