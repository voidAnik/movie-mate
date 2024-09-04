import 'dart:developer';

import 'package:movie_mate/core/database/genre_dao.dart';
import 'package:movie_mate/core/database/movie_dao.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class HomeLocalDataProvider{
  Future<List<MovieModel>> getMovies({required String type, required int page});
  Future<List<MovieModel>> searchMovies({required String query});
  Future<void> cacheMovies({required List<MovieModel> movies, required String type, required int page});
  Future<List<GenreModel>> getGenres();
  Future<void> cacheGenres({required List<GenreModel> genres});
}

class HomeLocalDataProviderImpl extends HomeLocalDataProvider{
  final MovieDao movieDao;
  final GenreDao genreDao;

  HomeLocalDataProviderImpl(this.movieDao, this.genreDao);

  @override
  Future<List<MovieModel>> getMovies({required String type, required int page}) async {
    try {
      List<MovieModel> movies = await movieDao.getMovies(type, page);
      return movies;
    } catch (e) {
      log('local data fetch error: $e');
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMovies({required List<MovieModel> movies, required String type, required int page}) async {
    try {
      await movieDao.insertMovies(movies, type, page);
    } catch (e) {
      log('local data insert error: $e');
      throw CacheException();
    }
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    try {
      List<GenreModel> movies = await genreDao.getAllGenres();
      return movies;
    } catch (e) {
      log('local data fetch error: $e');
      throw CacheException();
    }
  }

  @override
  Future<void> cacheGenres({required List<GenreModel> genres}) async {
    try {
      await genreDao.insertGenres(genres);
    } catch (e) {
      log('local data insert error: $e');
      throw CacheException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies({required String query}) async {
    try {
      List<MovieModel> movies = await movieDao.searchMovies(query);
      return movies;
    } catch (e) {
      log('local data fetch error: $e');
      throw CacheException();
    }
  }
}