import 'package:dio/dio.dart';
import 'package:movie_mate/core/constants/api_url.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.baseUrl,
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiODZhMzk4YWIzMzc4MDdmNjA4YWQ4MDAyMDI2NTliNyIsIm5iZiI6MTcyNTE3MDE4NC4wNjk2NDksInN1YiI6IjY2ZDNmZjU1MmE3NTdlMTA0ODc4ZWE5YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2w-AXcVLijsFo3mMPtqPanR3z6Lv37QHqBOVmmQSEJo",
          "Content-Type": "application/json"},
      ),
    );
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.next(options); // Continue to the next interceptor
          },
          onError: ( e, handler) {
            handler.next(e); // Continue to the next error interceptor
          },
          onResponse: (response, handler) {
            handler.next(response); // Continue to the next response interceptor
          },
        ),

    );
  }
  // Simplified HTTP Methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return _dio.delete(path, data: data);
  }

  Dio get dio => _dio; // Accessor for Dio if needed
}
