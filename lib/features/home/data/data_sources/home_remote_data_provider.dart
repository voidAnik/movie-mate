import 'dart:developer';

import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/core/network/return_response.dart';
import 'package:movie_mate/features/home/data/models/genre_model.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class HomeRemoteDataProvider{
  Future<List<MovieModel>> getTrendingMovies(int page);
  Future<List<MovieModel>> getUpcomingMovies(int page);
  Future<List<GenreModel>> getGenres();
  Future<List<MovieModel>> searchMovies(String query);
}

class HomeRemoteDataProviderImpl extends HomeRemoteDataProvider{
  final ApiClient apiClient;

  HomeRemoteDataProviderImpl(this.apiClient);

  @override
  Future<List<MovieModel>> getTrendingMovies(int page) async {
    final response = await apiClient.get(ApiUrl.trendingMovies, queryParameters: {
      'page': page,
    });

    return ReturnResponse<List<MovieModel>>()(response,
            (data) => (data['results'] as List)
              .map((json) => MovieModel.fromJson(json))
              .toList());
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies(int page) async {
    final response = await apiClient.get(ApiUrl.upcomingMovies, queryParameters: {
      'page': page,
    });

    return ReturnResponse<List<MovieModel>>()(response,
            (data) => (data['results'] as List)
            .map((json) => MovieModel.fromJson(json))
            .toList());
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await apiClient.get(ApiUrl.genreList);

    return ReturnResponse<List<GenreModel>>()(response,
            (data) => (data['genres'] as List)
            .map((json) => GenreModel.fromJson(json))
            .toList());
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await apiClient.get(ApiUrl.movieSearch, queryParameters: {
      'query': query,
    });

    return ReturnResponse<List<MovieModel>>()(response,
            (data) => (data['results'] as List)
            .map((json) => MovieModel.fromJson(json))
            .toList());
  }

}