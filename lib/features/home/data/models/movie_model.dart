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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'adult': adult,
      'video': video,
      'original_language': originalLanguage,
    };
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, genreIds: $genreIds, popularity: $popularity, releaseDate: $releaseDate, voteAverage: $voteAverage, voteCount: $voteCount, adult: $adult, video: $video, originalLanguage: $originalLanguage}';
  }
}