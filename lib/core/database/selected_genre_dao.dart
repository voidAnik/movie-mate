import 'package:movie_mate/core/database/database_constants.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/home/domain/entities/genre.dart';
import 'package:sqflite/sqflite.dart';

class UserSelectedGenreDao {
  final Database _db;

  UserSelectedGenreDao(this._db);

  Future<void> insertUserSelectedGenres(List<int> genreIds) async {
    final batch = _db.batch();

    for (var genreId in genreIds) {
      batch.insert(
        userSelectedGenresTable,
        {userSelectedGenreColumnGenreId: genreId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<int>> getUserSelectedGenres() async {
    final result = await _db.query(
      userSelectedGenresTable,
      columns: [userSelectedGenreColumnGenreId],
    );

    return result.map((e) => e[userSelectedGenreColumnGenreId] as int).toList();
  }
}
