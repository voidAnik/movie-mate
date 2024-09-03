import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_details.dart';

import 'models.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.adult,
    required super.backdropPath,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originCountry,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.productionCompanies,
    required super.productionCountries,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.spokenLanguages,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
    required super.videos,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget'],
      genres: (json['genres'] as List<dynamic>).map((item) => GenreModel.fromJson(item)).toList(),
      homepage: json['homepage'] ?? '',
      id: json['id'],
      imdbId: json['imdb_id'] ?? '',
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: '${ApiUrl.imagePrefix}${json['poster_path']}',
      productionCompanies: (json['production_companies'] as List<dynamic>).map((item) => ProductionCompany.fromJson(item)).toList(),
      productionCountries: (json['production_countries'] as List<dynamic>).map((item) => ProductionCountry.fromJson(item)).toList(),
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: (json['spoken_languages'] as List<dynamic>).map((item) => SpokenLanguage.fromJson(item)).toList(),
      status: json['status'],
      tagline: json['tagline'] ?? '',
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      videos: (json['videos']['results'] as List<dynamic>).map((item) => Video.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'budget': budget,
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies.map((company) => company.toJson()).toList(),
      'production_countries': productionCountries.map((country) => country.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages.map((language) => language.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'videos': {
        'results': videos.map((video) => video.toJson()).toList(),
      },
    };
  }

  String get genreNames => genres.map((genre) => genre.name).join(', ');
  String get releasedYear => releaseDate.split('-')[0];
  String get country => originCountry.map((country) => country).join(', ');
}
