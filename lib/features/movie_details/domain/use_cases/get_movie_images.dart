import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/use_cases/use_case.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_image_model.dart';
import 'package:movie_mate/features/movie_details/domain/repositories/movie_detail_repository.dart';

class GetMovieImages extends UseCase<List<MovieImageModel>, int>{
  final MovieDetailRepository repository;

  GetMovieImages(this.repository);

  @override
  Future<Either<Failure, List<MovieImageModel>>> call({required int params}) {
    return repository.getMovieImages(movieId: params);
  }
}