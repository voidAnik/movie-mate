
import 'package:movie_mate/core/database/database_constants.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/home/domain/entities/genre.dart';
import 'package:sqflite/sqflite.dart';

class GenreDao {
  final Database _db;

  GenreDao(this._db);

  Future<void> insertGenres(List<Genre> genres) async {

    final batch = _db.batch();

    for (var genre in genres) {
      batch.insert(
        genresTable,
        {
          genreColumnId: genre.id,
          genreColumnName: genre.name,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<Genre>> getAllGenres() async {
    final result = await _db.query(genresTable);
    return result.map((e) => GenreModel.fromJson(e)).toList();
  }
}
