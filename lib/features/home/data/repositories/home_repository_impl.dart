import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/exceptions.dart';
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
  final String trendingType = 'trending';
  final String upcomingType = 'upcoming';

  HomeRepositoryImpl(
      this.remoteDataProvider, this.localDataProvider, this.networkInfo);

  @override
  Future<Either<Failure, List<MovieModel>>> getTrendingMovies({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataProvider.getTrendingMovies(page);
        localDataProvider.cacheMovies(movies: movies, type: trendingType, page: page);
        return Right(movies);
      } catch(e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      try {
        final movies = await localDataProvider.getMovies(type: trendingType, page: page);
        log('movies from cache: $movies');
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }

  }

  @override
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies({required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataProvider.getUpcomingMovies(page);
        localDataProvider.cacheMovies(movies: movies, type: upcomingType, page: page);
        return Right(movies);
      } catch(e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      try {
        final movies = await localDataProvider.getMovies(type: upcomingType, page: page);
        log('movies from cache: $movies');
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}