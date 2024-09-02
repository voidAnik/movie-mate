
import 'package:movie_mate/core/database/database_constants.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/home/domain/entities/genre.dart';
import 'package:sqflite/sqflite.dart';

class UserSelectedGenreDao {
  final Database _db;

  UserSelectedGenreDao(this._db);

  Future<void> insertUserSelectedGenre(int genreId) async {
    await _db.insert(
      userSelectedGenresTable,
      {userSelectedGenreColumnGenreId: genreId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Genre>> getUserSelectedGenres() async {
    final result = await _db.query(
      userSelectedGenresTable,
      columns: [userSelectedGenreColumnGenreId],
    );
    return result.map((e) => GenreModel.fromJson(e)).toList();
  }
}
