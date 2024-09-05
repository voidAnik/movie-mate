import 'package:dio/dio.dart';
import 'package:movie_mate/core/error/exceptions.dart';

class ReturnResponse<T> {
  T call(Response<dynamic> response, T Function(dynamic json) fromJsonFunc) {
    final statusCode = response.statusCode;

    if (statusCode == null) {
      throw ServerException(); // or a custom exception to handle null status code
    }

    if (statusCode >= 200 && statusCode <= 300) {
      if (response.data == null) {
        throw FormatException();
      }
      return fromJsonFunc(response.data);
    } else if (statusCode >= 400 && statusCode < 500) {
      final errorMessage = response.data?['status_message'] ?? 'Unknown error';
      throw ApiException(error: errorMessage);
    } else {
      throw ServerException();
    }
  }
}