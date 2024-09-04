import 'package:movie_mate/core/database/database_constants.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteMovieDao {
  final Database _db;

  FavoriteMovieDao(this._db);

  Future<void> insertFavoriteMovie(int movieId) async {

    await _db.insert(
      favoriteMoviesTable,
      {favoriteMovieColumnMovieId: movieId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MovieModel>> getAllFavoriteMovies() async {
    final result = await _db.rawQuery('''
      SELECT m.*
      FROM $favoriteMoviesTable f
      INNER JOIN $moviesTable m
      ON f.$favoriteMovieColumnMovieId = m.$movieColumnId
    ''');

    return result.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<void> deleteFavoriteMovie(int movieId) async {
    await _db.delete(
      favoriteMoviesTable,
      where: '$favoriteMovieColumnMovieId = ?',
      whereArgs: [movieId],
    );
  }

  Future<bool> isMovieFavorite(int movieId) async {
    final result = await _db.query(
      favoriteMoviesTable,
      where: '$favoriteMovieColumnMovieId = ?',
      whereArgs: [movieId],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
