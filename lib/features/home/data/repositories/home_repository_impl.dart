import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/network/return_failure.dart';
import 'package:movie_mate/core/utils/network_info.dart';
import 'package:movie_mate/features/home/data/data_sources/home_local_data_provider.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository{
  final HomeRemoteDataProvider remoteDataProvider;
  final HomeLocalDataProvider localDataProvider;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
      this.remoteDataProvider, this.localDataProvider, this.networkInfo);

  @override
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataProvider.getTrendingMovies(page);
       // localDataProvider.cacheMovies(movies);
        return Right(movies);
      } catch(e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      // TODO: implement local data provider
      throw UnimplementedError();
    }

  }

  @override
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataProvider.getUpcomingMovies(page);
        // localDataProvider.cacheMovies(movies);
        return Right(movies);
      } catch(e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      // TODO: implement local data provider
      throw UnimplementedError();
    }
  }

}