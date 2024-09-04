import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/favorites/domain/repositories/favorite_movie_repository.dart';

class DeleteFavoriteMovie extends UseCase<void, int>{
  final FavoriteMovieRepository repository;

  DeleteFavoriteMovie(this.repository);

  @override
  Future<Either<Failure, void>> call({required int params}) {
    return repository.deleteFavoriteMovie(movieId: params);
  }

}