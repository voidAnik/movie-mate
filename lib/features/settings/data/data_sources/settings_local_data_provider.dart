import 'package:movie_mate/core/database/selected_genre_dao.dart';
import 'package:movie_mate/core/error/exceptions.dart';

abstract class SettingsLocalDataProvider{
  Future<void> saveSelectedGenres({required List<int> genreIds});
  Future<List<int>> getSelectedGenres();
}

class SettingsLocalDataProviderImpl extends SettingsLocalDataProvider{
  final UserSelectedGenreDao _selectedGenreDao;

  SettingsLocalDataProviderImpl(this._selectedGenreDao);

  @override
  Future<List<int>> getSelectedGenres() async {
    try {
      final genreIds = await _selectedGenreDao.getUserSelectedGenres();
      return genreIds;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveSelectedGenres({required List<int> genreIds}) async {
    try {
      await _selectedGenreDao.insertUserSelectedGenres(genreIds);
    } catch (e) {
      throw CacheException();
    }
  }
}