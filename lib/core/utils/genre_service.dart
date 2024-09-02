import 'package:movie_mate/features/home/data/models/genre_model.dart';

class GenreService {
  final Map<int, String> _genreMap = {};

  void updateGenres(List<GenreModel> genres) {
    _genreMap.clear();
    for (var genre in genres) {
      _genreMap[genre.id] = genre.name;
    }
  }

  String getGenreName(int id) {
    return _genreMap[id] ?? 'Unknown';
  }
}