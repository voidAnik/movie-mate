import 'package:movie_mate/core/database/database_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $genresTable (
  $genreColumnId INTEGER PRIMARY KEY,
  $genreColumnName TEXT
)
''');

    await db.execute('''
CREATE TABLE $moviesTable (
  $movieColumnId INTEGER PRIMARY KEY,
  $movieColumnTitle TEXT,
  $movieColumnOriginalTitle TEXT,
  $movieColumnOverview TEXT,
  $movieColumnPosterPath TEXT,
  $movieColumnBackdropPath TEXT,
  $movieColumnAdult INTEGER,
  $movieColumnOriginalLanguage TEXT,
  $movieColumnPopularity REAL,
  $movieColumnReleaseDate TEXT,
  $movieColumnVideo INTEGER,
  $movieColumnVoteAverage REAL,
  $movieColumnVoteCount INTEGER,
  $movieColumnGenreIds TEXT,
  $movieColumnType TEXT,
  $movieColumnPageNumber INTEGER
)
''');

    await db.execute('''
CREATE TABLE $favoriteMoviesTable (
  $favoriteMovieColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
  $favoriteMovieColumnMovieId INTEGER,
  FOREIGN KEY ($favoriteMovieColumnMovieId) REFERENCES $moviesTable ($movieColumnId)
)
''');

    await db.execute('''
CREATE TABLE $userSelectedGenresTable (
  $userSelectedGenreColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
  $userSelectedGenreColumnGenreId INTEGER,
  FOREIGN KEY ($userSelectedGenreColumnGenreId) REFERENCES $genresTable ($genreColumnId)
)
''');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
