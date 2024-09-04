import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/network/return_failure.dart';
import 'package:movie_mate/core/utils/network_info.dart';
import 'package:movie_mate/features/favorites/data/data_sources/favorite_local_data_provider.dart';
import 'package:movie_mate/features/favorites/data/data_sources/favorite_remote_data_provider.dart';
import 'package:movie_mate/features/favorites/domain/repositories/favorite_movie_repository.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

class FavoriteMovieRepositoryImpl extends FavoriteMovieRepository {
  final FavoriteRemoteDataProvider remoteDataProvider;
  final FavoriteLocalDataProvider localDataProvider;
  final NetworkInfo networkInfo;

  FavoriteMovieRepositoryImpl(
      this.remoteDataProvider, this.localDataProvider, this.networkInfo);

  @override
  Future<Either<Failure, void>> deleteFavoriteMovie(
      {required int movieId}) async {
    String remoteFailedMessage = '';
    try {
      final movies = await remoteDataProvider.deleteFavorite(movieId: movieId);
    } on ApiException catch (e) {
      remoteFailedMessage = e.error;
    }
    try {
      await localDataProvider.deleteFavorite(movieId: movieId);
      if (remoteFailedMessage.isNotEmpty) {
        return Left(ApiFailure(error: remoteFailedMessage));
      }
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getFavoriteMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataProvider.getFavoriteMovies();
        return Right(movies);
      } catch (e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      try {
        final movies = await localDataProvider.getFavoriteMovies();
        log('movies from cache: $movies');
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> saveFavoriteMovie(
      {required MovieModel movie}) async {
    String remoteFailedMessage = '';
    try {
      await remoteDataProvider.saveFavorite(movie: movie);
    } on ApiException catch (e) {
      remoteFailedMessage = e.error;
    }
    try {
      await localDataProvider.saveFavorite(movie: movie);
      if (remoteFailedMessage.isNotEmpty) {
        return Left(ApiFailure(error: remoteFailedMessage));
      }
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite({required int movieId}) async {
    try {
      final isFavoriteLocally = await localDataProvider.isFavorite(movieId);
      if (isFavoriteLocally) return const Right(true);

      // Optionally, checking remotely in firebase
      final isFavoriteRemotely = await remoteDataProvider.isFavorite(movieId);
      return Right(isFavoriteRemotely);
    } catch (e) {
      // Handle error if needed
      return Left(CacheFailure());
    }
  }
}
