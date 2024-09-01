
class ServerException implements Exception {
}
class ApiException implements Exception {
  final String error;

  ApiException({required this.error});
}

class CacheException implements Exception {}

class FormatException implements Exception {}
class InternalException implements Exception {
  final String error;

  InternalException({required this.error});
}
