import 'package:movie_mate/core/database/database_constants.dart';
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

  Future<List<int>> getAllFavoriteMovies() async {
    final result = await _db.query(favoriteMoviesTable);
    return result.map((e) => e[favoriteMovieColumnMovieId] as int).toList();
  }
}
