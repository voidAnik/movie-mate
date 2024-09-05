import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/core/error/exceptions.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/features/home/data/data_sources/home_remote_data_provider.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'home_remote_data_provider_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {

  late MockApiClient mockApiClient;
  late HomeRemoteDataProviderImpl remoteDataProvider;

  setUp(() {
    mockApiClient = MockApiClient();
    remoteDataProvider = HomeRemoteDataProviderImpl(mockApiClient);
  });

  group('getTrendingMovies', () {
    test('should return a list of trending movies when the response is successful', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.trendingMovies),
        statusCode: 200,
        data: {
          'results': [
            json.decode(fixture('trending_movie_info.json')),
          ],
        },
      );

      when(mockApiClient.get(ApiUrl.trendingMovies, queryParameters: {'page': 1}))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await remoteDataProvider.getTrendingMovies(1);

      // Assert
      expect(result, isA<List<MovieModel>>());
      expect(result.first.title, 'Movie 1');
    });

    test('should throw a ServerException when statusCode is 500', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.trendingMovies),
        statusCode: 500,
        data: null,
      );

      when(mockApiClient.get(ApiUrl.trendingMovies, queryParameters: {'page': 1}))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.getTrendingMovies(1), throwsA(isA<ServerException>()));
    });

    test('should throw an ApiException when statusCode is 400 and contains an error message', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.trendingMovies),
        statusCode: 400,
        data: {'status_message': 'Bad Request'},
      );

      when(mockApiClient.get(ApiUrl.trendingMovies, queryParameters: {'page': 1}))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.getTrendingMovies(1), throwsA(isA<ApiException>()));
    });
  });

  group('getUpcomingMovies', () {
    test('should return a list of upcoming movies when the response is successful', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.upcomingMovies),
        statusCode: 200,
        data: {
          'results': [
            json.decode(fixture('upcoming_movie_info.json')),
          ],
        },
      );

      when(mockApiClient.get(ApiUrl.upcomingMovies, queryParameters: {'page': 1}))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await remoteDataProvider.getUpcomingMovies(1);

      // Assert
      expect(result, isA<List<MovieModel>>());
      expect(result.first.title, 'Upcoming Movie 1');
    });

    test('should throw a ServerException when statusCode is 500', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.upcomingMovies),
        statusCode: 500,
        data: null,
      );

      when(mockApiClient.get(ApiUrl.upcomingMovies, queryParameters: {'page': 1}))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.getUpcomingMovies(1), throwsA(isA<ServerException>()));
    });

    test('should throw an ApiException when statusCode is 400 and contains an error message', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.upcomingMovies),
        statusCode: 400,
        data: {'status_message': 'Bad Request'},
      );

      when(mockApiClient.get(ApiUrl.upcomingMovies, queryParameters: {'page': 1}))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.getUpcomingMovies(1), throwsA(isA<ApiException>()));
    });
  });

  group('getGenres', () {
    test('should return a list of genres when the response is successful', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.genreList),
        statusCode: 200,
        data: jsonDecode(fixture('genres.json')),
      );

      when(mockApiClient.get(ApiUrl.genreList))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await remoteDataProvider.getGenres();

      // Assert
      expect(result, isA<List<GenreModel>>());
      expect(result.first.name, 'Action');
    });

    test('should throw a ServerException when statusCode is 500', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.genreList),
        statusCode: 500,
        data: null,
      );

      when(mockApiClient.get(ApiUrl.genreList))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.getGenres(), throwsA(isA<ServerException>()));
    });

    test('should throw an ApiException when statusCode is 400 and contains an error message', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.genreList),
        statusCode: 400,
        data: {'status_message': 'Bad Request'},
      );

      when(mockApiClient.get(ApiUrl.genreList))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.getGenres(), throwsA(isA<ApiException>()));
    });
  });

  group('searchMovies', () {
    test('should return a list of movies when the response is successful', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.movieSearch),
        statusCode: 200,
        data: {
          'results': [
           jsonDecode(fixture('search_movie_info.json')),
          ],
        },
      );

      when(mockApiClient.get(ApiUrl.movieSearch, queryParameters: {'query': 'movie'}))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await remoteDataProvider.searchMovies('movie');

      // Assert
      expect(result, isA<List<MovieModel>>());
      expect(result.first.title, 'Search Movie 1');
    });

    test('should throw a ServerException when statusCode is 500', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.movieSearch),
        statusCode: 500,
        data: null,
      );

      when(mockApiClient.get(ApiUrl.movieSearch, queryParameters: {'query': 'movie'}))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.searchMovies('movie'), throwsA(isA<ServerException>()));
    });

    test('should throw an ApiException when statusCode is 400 and contains an error message', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ApiUrl.movieSearch),
        statusCode: 400,
        data: {'status_message': 'Bad Request'},
      );

      when(mockApiClient.get(ApiUrl.movieSearch, queryParameters: {'query': 'movie'}))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => remoteDataProvider.searchMovies('movie'), throwsA(isA<ApiException>()));
    });
  });
}
