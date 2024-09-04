
import 'package:movie_mate/core/database/database_constants.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class MovieDao {
  final Database _db;

  MovieDao(this._db);

  Future<void> insertMovies(List<MovieModel> movies, String type, int pageNumber) async {
    final batch = _db.batch();

    for (var movie in movies) {
      batch.insert(
        moviesTable,
        movie.toJson()..addAll({
          movieColumnType: type,
          movieColumnPageNumber: pageNumber,
        }),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<MovieModel>> getMovies(String type, int pageNumber) async {
    final result = await _db.query(
      moviesTable,
      where: '$movieColumnType = ? AND $movieColumnPageNumber = ?',
      whereArgs: [type, pageNumber],
    );

    return result.map((e) => MovieModel.fromSql(e)).toList();
  }

  Future<List<MovieModel>> searchMovies(String query) async {

    final List<Map<String, dynamic>> results = await _db.query(
      moviesTable,
      where: 'title LIKE ? OR overview LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );

    return results.map((json) => MovieModel.fromJson(json)).toList();
  }
}
