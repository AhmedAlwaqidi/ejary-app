/// Data layer exceptions
class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'An unexpected server error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'An error occurred while reading from cache']);

  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  final String message;
  const ValidationException([this.message = 'Validation failed']);

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException([this.message = 'Requested entity was not found']);

  @override
  String toString() => 'NotFoundException: $message';
}
