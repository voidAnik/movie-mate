import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/repositories/home_repository.dart';

class GetUpcomingMovies extends UseCase<List<MovieModel>, int>{
  final HomeRepository repository;

  GetUpcomingMovies(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call({required int params}) {
    return repository.getUpcomingMovies(page: params);
  }

}