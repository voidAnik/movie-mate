// lib/core/constants/database_constants.dart
//
const String databaseName = 'genres';
const int dbVersion = 1;
// Table names
const String genresTable = 'genres';
const String moviesTable = 'movies';
const String favoriteMoviesTable = 'favorite_movies';
const String userSelectedGenresTable = 'user_selected_genres';

// Columns for genres
const String genreColumnId = 'id';
const String genreColumnName = 'name';

// Columns for movies
const String movieColumnId = 'id';
const String movieColumnTitle = 'title';
const String movieColumnOriginalTitle = 'original_title';
const String movieColumnOverview = 'overview';
const String movieColumnPosterPath = 'poster_path';
const String movieColumnBackdropPath = 'backdrop_path';
const String movieColumnAdult = 'adult';
const String movieColumnOriginalLanguage = 'original_language';
const String movieColumnPopularity = 'popularity';
const String movieColumnReleaseDate = 'release_date';
const String movieColumnVideo = 'video';
const String movieColumnVoteAverage = 'vote_average';
const String movieColumnVoteCount = 'vote_count';
const String movieColumnGenreIds = 'genre_ids';
const String movieColumnType = 'type';
const String movieColumnPageNumber = 'page_number';

// Columns for favorite movies
const String favoriteMovieColumnId = 'id';
const String favoriteMovieColumnMovieId = 'movie_id';

// Columns for user selected genres
const String userSelectedGenreColumnId = 'id';
const String userSelectedGenreColumnGenreId = 'genre_id';
