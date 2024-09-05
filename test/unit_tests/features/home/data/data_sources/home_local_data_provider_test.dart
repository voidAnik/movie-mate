import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/features/home/data/data_sources/home_local_data_provider.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/core/database/genre_dao.dart';
import 'package:movie_mate/core/database/movie_dao.dart';

import 'home_local_data_provider_test.mocks.dart';

@GenerateMocks([MovieDao, GenreDao])
void main() {
  late HomeLocalDataProviderImpl localDataProvider;
  late MockMovieDao mockMovieDao;
  late MockGenreDao mockGenreDao;

  setUp(() {
    mockMovieDao = MockMovieDao();
    mockGenreDao = MockGenreDao();
    localDataProvider = HomeLocalDataProviderImpl(mockMovieDao, mockGenreDao);
  });

  final tMovieModel = MovieModel(
    id: 1,
    title: 'Test Movie',
    originalTitle: 'Test Movie Original',
    overview: 'Test Overview',
    posterPath: 'test_poster_path',
    backdropPath: 'test_backdrop_path',
    genreIds: [1, 2],
    popularity: 10.0,
    releaseDate: '2024-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    adult: false,
    video: false,
    originalLanguage: 'en',
  );
  final tGenreModel = GenreModel(id: 1, name: 'Action');

  group('getMovies', () {
    test('should return a list of movies when the call to movieDao is successful', () async {
      // Arrange
      when(mockMovieDao.getMovies(any, any)).thenAnswer((_) async => [tMovieModel]);

      // Act
      final result = await localDataProvider.getMovies(type: 'trending', page: 1);

      // Assert
      expect(result, [tMovieModel]);
      verify(mockMovieDao.getMovies('trending', 1));
    });

    test('should throw CacheException when the call to movieDao is unsuccessful', () async {
      // Arrange
      when(mockMovieDao.getMovies(any, any)).thenThrow(Exception());

      // Act
      final call = localDataProvider.getMovies(type: 'trending', page: 1);

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cacheMovies', () {
    test('should call movieDao.insertMovies when caching movies', () async {
      // Arrange
      when(mockMovieDao.insertMovies(any, any, any)).thenAnswer((_) async {});

      // Act
      await localDataProvider.cacheMovies(movies: [tMovieModel], type: 'trending', page: 1);

      // Assert
      verify(mockMovieDao.insertMovies([tMovieModel], 'trending', 1));
    });

    test('should throw CacheException when the call to movieDao is unsuccessful', () async {
      // Arrange
      when(mockMovieDao.insertMovies(any, any, any)).thenThrow(Exception());

      // Act
      final call = localDataProvider.cacheMovies(movies: [tMovieModel], type: 'trending', page: 1);

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('getGenres', () {
    test('should return a list of genres when the call to genreDao is successful', () async {
      // Arrange
      when(mockGenreDao.getAllGenres()).thenAnswer((_) async => [tGenreModel]);

      // Act
      final result = await localDataProvider.getGenres();

      // Assert
      expect(result, [tGenreModel]);
      verify(mockGenreDao.getAllGenres());
    });

    test('should throw CacheException when the call to genreDao is unsuccessful', () async {
      // Arrange
      when(mockGenreDao.getAllGenres()).thenThrow(Exception());

      // Act
      final call = localDataProvider.getGenres();

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cacheGenres', () {
    test('should call genreDao.insertGenres when caching genres', () async {
      // Arrange
      when(mockGenreDao.insertGenres(any)).thenAnswer((_) async {});

      // Act
      await localDataProvider.cacheGenres(genres: [tGenreModel]);

      // Assert
      verify(mockGenreDao.insertGenres([tGenreModel]));
    });

    test('should throw CacheException when the call to genreDao is unsuccessful', () async {
      // Arrange
      when(mockGenreDao.insertGenres(any)).thenThrow(Exception());

      // Act
      final call = localDataProvider.cacheGenres(genres: [tGenreModel]);

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('searchMovies', () {
    test('should return a list of movies when the call to movieDao is successful', () async {
      // Arrange
      when(mockMovieDao.searchMovies(any)).thenAnswer((_) async => [tMovieModel]);

      // Act
      final result = await localDataProvider.searchMovies(query: 'test query');

      // Assert
      expect(result, [tMovieModel]);
      verify(mockMovieDao.searchMovies('test query'));
    });

    test('should throw CacheException when the call to movieDao is unsuccessful', () async {
      // Arrange
      when(mockMovieDao.searchMovies(any)).thenThrow(Exception());

      // Act
      final call = localDataProvider.searchMovies(query: 'test query');

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
