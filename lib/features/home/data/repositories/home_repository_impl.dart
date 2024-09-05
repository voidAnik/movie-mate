import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/core/error/failures.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/network/return_failure.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/utils/network_info.dart';
import 'package:movie_mate/features/home/data/data_sources/home_local_data_provider.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/repositories/home_repository.dart';
import 'package:movie_mate/features/settings/data/data_sources/settings_local_data_provider.dart';

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

        // filtering movies by genre selection
        final filteredMovies = await _filterMoviesByGenre(movies);
        return Right(filteredMovies);
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
        await _fetchAndCacheGenres();
        final movies = await remoteDataProvider.getUpcomingMovies(page);
        localDataProvider.cacheMovies(movies: movies, type: upcomingType, page: page);

        // filtering movies by genre selection
        final filteredMovies = await _filterMoviesByGenre(movies);
        return Right(filteredMovies);
        return Right(movies);
      } catch(e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      try {
        final genres = await localDataProvider.getGenres();
        getIt<GenreService>().updateGenres(genres);

        final movies = await localDataProvider.getMovies(type: upcomingType, page: page);
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<void> _fetchAndCacheGenres() async {
    final genres = await remoteDataProvider.getGenres();
    getIt<GenreService>().updateGenres(genres);
    localDataProvider.cacheGenres(genres: genres);
  }

  @override
  Future<Either<Failure, List<MovieModel>>> searchMovies({required String query}) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataProvider.searchMovies(query);
        return Right(movies);
      } catch(e) {
        return ReturnFailure<List<MovieModel>>()(e as Exception);
      }
    } else {
      try {
        final movies = await localDataProvider.searchMovies(query: query);
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<List<MovieModel>> _filterMoviesByGenre(List<MovieModel> movies) async {
    final selectedGenres = await getIt<SettingsLocalDataProvider>().getSelectedGenres();
    log('selected genre ids: $selectedGenres');

    if (selectedGenres.isEmpty) {
      // If no genres are selected, return the full list
      return movies;
    }

    // Filter movies that have at least one matching genre with the selected genres
    return movies.where((movie) {
      return movie.genreIds.any((genreId) => selectedGenres.contains(genreId));
    }).toList();
  }

}