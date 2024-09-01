import 'dart:developer';

import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/core/network/return_response.dart';
import 'package:movie_mate/features/home/data/models/movie_model.dart';

abstract class HomeDataProvider{
  Future<List<MovieModel>> getTrendingMovies(int page);
  Future<List<MovieModel>> getUpcomingMovies(int page);
}

class HomeDataProviderImpl extends HomeDataProvider{
  final ApiClient apiClient;

  HomeDataProviderImpl(this.apiClient);

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

}