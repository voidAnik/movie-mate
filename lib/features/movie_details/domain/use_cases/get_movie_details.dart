import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/domain/repositories/movie_detail_repository.dart';

class GetMovieDetails extends UseCase<MovieDetailsModel, int>{
  final MovieDetailRepository repository;

  GetMovieDetails(this.repository);

  @override
  Future<Either<Failure, MovieDetailsModel>> call({required int params}) {
    return repository.getMovieDetails(movieId: params);
  }
}