import 'dart:developer';

import 'package:movie_mate/core/database/movie_dao.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class HomeLocalDataProvider{
  Future<List<MovieModel>> getMovies({required String type, required int page});
  Future<void> cacheMovies({required List<MovieModel> movies, required String type, required int page});
}

class HomeLocalDataProviderImpl extends HomeLocalDataProvider{
  final MovieDao movieDao;

  HomeLocalDataProviderImpl(this.movieDao);

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
}