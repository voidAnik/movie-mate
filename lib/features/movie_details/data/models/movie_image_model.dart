

import 'package:movie_mate/core/constants/api_url.dart';
import 'package:movie_mate/features/movie_details/domain/entities/movie_image.dart';

class MovieImageModel extends MovieImage {
  MovieImageModel({
    required super.aspectRatio,
    required super.height,
    super.iso6391,
    required super.filePath,
    required super.voteAverage,
    required super.voteCount,
    required super.width,
  });

  factory MovieImageModel.fromJson(Map<String, dynamic> json) {
    return MovieImageModel(
      aspectRatio: json['aspect_ratio']?.toDouble() ?? 0.0,
      height: json['height'] ?? 0,
      iso6391: json['iso_639_1'],
      filePath: '${ApiUrl.imagePrefix}${json['file_path']}', // adding image prefix
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      width: json['width'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aspect_ratio': aspectRatio,
      'height': height,
      'iso_639_1': iso6391,
      'file_path': filePath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'width': width,
    };
  }
}
