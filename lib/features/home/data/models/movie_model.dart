import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/features/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.backdropPath,
    required super.genreIds,
    required super.popularity,
    required super.releaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.adult,
    required super.video,
    required super.originalLanguage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: '${ApiUrl.imagePrefix}${json['poster_path']}',
      backdropPath: '${ApiUrl.imagePrefix}${json['backdrop_path']}',
      genreIds: List<int>.from(json['genre_ids']),
      popularity: json['popularity'].toDouble(),
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      adult: json['adult'],
      video: json['video'],
      originalLanguage: json['original_language'],
    );
  }

  factory MovieModel.fromCache(Map<String, dynamic> json) {
    // Handle conversion from SQL & firebase
    return MovieModel(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genreIds: (json['genre_ids'] as String).split(',').map(int.parse).toList(),  // Convert from comma-separated string to List<int>
      popularity: json['popularity'].toDouble(),
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      adult: json['adult'] == 1,  // Convert from integer to boolean
      video: json['video'] == 1,  // Convert from integer to boolean
      originalLanguage: json['original_language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds.join(','),  // Convert from List<int> to comma-separated string
      'popularity': popularity,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult ? 1 : 0,  // Convert from boolean to integer
      'video': video ? 1 : 0,  // Convert from boolean to integer
      'original_language': originalLanguage,
    };
  }

  factory MovieModel.fromEntity(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      genreIds: movie.genreIds,
      popularity: movie.popularity,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      adult: movie.adult,
      video: movie.video,
      originalLanguage: movie.originalLanguage,
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, genreIds: $genreIds, popularity: $popularity, releaseDate: $releaseDate, voteAverage: $voteAverage, voteCount: $voteCount, adult: $adult, video: $video, originalLanguage: $originalLanguage}';
  }
}
