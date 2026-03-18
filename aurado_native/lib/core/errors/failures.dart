/// Typed error hierarchy for the Aurado domain layer.
/// Every failure must be a concrete subtype — generic [Exception]s are forbidden.
abstract class AppFailure implements Exception {
  const AppFailure(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '${runtimeType.toString()}: $message';
}

/// The user is not authenticated or their session has expired.
class AuthFailure extends AppFailure {
  const AuthFailure([super.message = 'Authentication failed.', Object? cause]) : super(cause: cause);
}

/// A network request failed (timeout, DNS, unreachable).
class NetworkFailure extends AppFailure {
  const NetworkFailure([super.message = 'No internet connection.', Object? cause]) : super(cause: cause);
}

/// A Supabase / backend request returned an unexpected response.
class ServerFailure extends AppFailure {
  const ServerFailure(super.message, {super.cause, this.statusCode});

  final int? statusCode;
}

/// Local cache, file, or storage operation failure.
class StorageFailure extends AppFailure {
  const StorageFailure([super.message = 'Local storage error.', Object? cause]) : super(cause: cause);
}

/// Offline lesson security violation (tampering or expiry).
class OfflineSecurityFailure extends AppFailure {
  const OfflineSecurityFailure([
    super.message = 'Offline content is expired or tampered.',
    Object? cause,
  ]) : super(cause: cause);
}

/// Generic validation error from user input.
class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

/// The requested resource was not found.
class NotFoundFailure extends AppFailure {
  const NotFoundFailure([super.message = 'Resource not found.']);
}
