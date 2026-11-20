/// Domain failure representations
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'server_error']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'cache_error']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'validation_error']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'not_found_error']);
}
