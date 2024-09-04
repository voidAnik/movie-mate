import 'package:movie_mate/core/database/favorite_movie_dao.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';

abstract class FavoriteLocalDataProvider{
  Future<List<MovieModel>> getFavoriteMovies();
  Future<void> deleteFavorite({required int movieId});
  Future<void> saveFavorite({required MovieModel movie});
  Future<bool> isFavorite(int movieId);
}

class FavoriteLocalDataProviderImpl extends FavoriteLocalDataProvider{
  final FavoriteMovieDao _favoriteMovieDao;

  FavoriteLocalDataProviderImpl(this._favoriteMovieDao);

  @override
  Future<void> deleteFavorite({required int movieId}) async {
    try {
      await _favoriteMovieDao.deleteFavoriteMovie(movieId);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    try {
      final movies = await _favoriteMovieDao.getAllFavoriteMovies();
      return movies;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveFavorite({required Movie movie}) async {
    try {
      await _favoriteMovieDao.insertFavoriteMovie(movie.id);
    } catch (e) {
      throw CacheException();
    }
  }
  @override
  Future<bool> isFavorite(int movieId) async {
    try {
      return await _favoriteMovieDao.isMovieFavorite(movieId);
    } catch(e){
      throw CacheException();
    }
  }

}