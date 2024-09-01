import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../error/exceptions.dart';

class ReturnResponse<T> {
  T call(Response<dynamic> response, T Function(dynamic json) fromJsonFunc) {
    /*try {*/
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return fromJsonFunc(response.data);
    } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
      throw ApiException(error: 'temp');
    } else {
      throw ServerException();
    }
    /*} catch (e) {
      debugPrint('Exception: $e');
      throw FormatException();
    }*/
  }
}
