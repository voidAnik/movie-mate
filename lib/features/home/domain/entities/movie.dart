class Movie {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;
  final double popularity;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final bool adult;
  final bool video;
  final String originalLanguage;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
    required this.video,
    required this.originalLanguage,
  });

}