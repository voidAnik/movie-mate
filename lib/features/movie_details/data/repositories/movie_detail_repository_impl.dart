import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/network/return_failure.dart';
import 'package:movie_mate/features/movie_details/data/data_sources/movie_detail_remote_data_provider.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_image_model.dart';
import 'package:movie_mate/features/movie_details/domain/repositories/movie_detail_repository.dart';

class MovieDetailRepositoryImpl extends MovieDetailRepository{
  final MovieDetailRemoteDataProvider remoteDataProvider;

  MovieDetailRepositoryImpl(this.remoteDataProvider);

  @override
  Future<Either<Failure, List<MovieImageModel>>> getMovieImages({required int movieId}) async {
    try {
      final movieImages = await remoteDataProvider.getMovieImages(movieId);
      return Right(movieImages);
    } catch(e) {
      return ReturnFailure<List<MovieImageModel>>()(e as Exception);
    }
  }

  @override
  Future<Either<Failure, MovieDetailsModel>> getMovieDetails({required int movieId}) async {
    try {
      final movieInfo = await remoteDataProvider.getMovieDetails(movieId);
      return Right(movieInfo);
    } catch(e) {
      return ReturnFailure<MovieDetailsModel>()(e as Exception);
    }
  }

}