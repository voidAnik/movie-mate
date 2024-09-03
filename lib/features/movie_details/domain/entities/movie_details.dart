import 'package:equatable/equatable.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/movie_details/data/models/production_company.dart';
import 'package:movie_mate/features/movie_details/data/models/production_country.dart';
import 'package:movie_mate/features/movie_details/data/models/spoken_language.dart';
import 'package:movie_mate/features/movie_details/data/models/video.dart';

class MovieDetails extends Equatable {
  final bool adult;
  final String backdropPath;
  final int budget;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List<Video> videos;

  const MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.videos,
  });

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originCountry,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    productionCountries,
    releaseDate,
    revenue,
    runtime,
    spokenLanguages,
    status,
    tagline,
    title,
    video,
    voteAverage,
    voteCount,
    videos,
  ];
}
