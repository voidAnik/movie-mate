import 'dart:developer';

import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/core/network/api_client.dart';
import 'package:movie_mate/core/network/return_response.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_mate/features/movie_details/data/models/movie_image_model.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_image.dart';

abstract class MovieDetailRemoteDataProvider{
  Future<List<MovieImageModel>> getMovieImages(int movieId);
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class MovieDetailRemoteDataProviderImpl extends MovieDetailRemoteDataProvider{
  final ApiClient apiClient;

  MovieDetailRemoteDataProviderImpl(this.apiClient);

  @override
  Future<List<MovieImageModel>> getMovieImages(int movieId) async {
    final response = await apiClient.get(ApiUrl.movieImages.replaceAll('{movie_id}', movieId.toString()));

    return ReturnResponse<List<MovieImageModel>>()(response,
            (data) => (data['backdrops'] as List)
            .map((json) => MovieImageModel.fromJson(json))
            .toList());
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await apiClient.get('${ApiUrl.movieDetails}$movieId', queryParameters: {
      "append_to_response":"videos"
    });

    return ReturnResponse<MovieDetailsModel>()(response,
            (data) => MovieDetailsModel.fromJson(data));
  }

}