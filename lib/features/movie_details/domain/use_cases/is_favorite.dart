import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/favorites/domain/repositories/favorite_movie_repository.dart';

class IsFavorite extends UseCase<bool, int>{
  final FavoriteMovieRepository repository;

  IsFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call({required int params}) {
    return repository.isFavorite(movieId: params);
  }
}