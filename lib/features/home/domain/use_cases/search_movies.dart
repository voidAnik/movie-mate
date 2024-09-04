import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/repositories/home_repository.dart';

class SearchMovies extends UseCase<List<MovieModel>, String>{
  final HomeRepository repository;

  SearchMovies(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call({required String params}) {
    return repository.searchMovies(query: params);
  }

}