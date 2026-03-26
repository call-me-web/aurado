import 'package:flutter_test/flutter_test.dart';
import 'package:aurado/core/errors/failures.dart';

void main() {
  group('AppFailure hierarchy', () {
    group('AuthFailure', () {
      test('uses default message when none is provided', () {
        const failure = AuthFailure();
        expect(failure.message, 'Authentication failed.');
      });

      test('accepts a custom message', () {
        const failure = AuthFailure('Session expired.');
        expect(failure.message, 'Session expired.');
      });

      test('toString includes type and message', () {
        const failure = AuthFailure('Bad token.');
        expect(failure.toString(), contains('AuthFailure'));
        expect(failure.toString(), contains('Bad token.'));
      });

      test('chains an inner cause', () {
        final inner = Exception('inner error');
        final failure = AuthFailure('Outer.', inner);
        expect(failure.cause, inner);
      });

      test('is an Exception', () {
        expect(const AuthFailure(), isA<Exception>());
      });
    });

    group('NetworkFailure', () {
      test('uses default message when none is provided', () {
        const failure = NetworkFailure();
        expect(failure.message, 'No internet connection.');
      });

      test('accepts a custom message', () {
        const failure = NetworkFailure('DNS resolution failed.');
        expect(failure.message, 'DNS resolution failed.');
      });
    });

    group('ServerFailure', () {
      test('stores statusCode', () {
        const failure = ServerFailure('Not Found', statusCode: 404);
        expect(failure.statusCode, 404);
        expect(failure.message, 'Not Found');
      });

      test('allows null statusCode', () {
        const failure = ServerFailure('Unknown server error.');
        expect(failure.statusCode, isNull);
      });

      test('chains cause alongside statusCode', () {
        final inner = Exception('raw http error');
        final failure = ServerFailure('Backend down', statusCode: 503, cause: inner);
        expect(failure.cause, inner);
        expect(failure.statusCode, 503);
      });
    });

    group('StorageFailure', () {
      test('uses default message when none is provided', () {
        const failure = StorageFailure();
        expect(failure.message, 'Local storage error.');
      });
    });

    group('OfflineSecurityFailure', () {
      test('uses default message when none is provided', () {
        const failure = OfflineSecurityFailure();
        expect(failure.message, 'Offline content is expired or tampered.');
      });
    });

    group('ValidationFailure', () {
      test('stores the provided message', () {
        const failure = ValidationFailure('Email is required.');
        expect(failure.message, 'Email is required.');
      });

      test('toString includes ValidationFailure type', () {
        const failure = ValidationFailure('Invalid input.');
        expect(failure.toString(), contains('ValidationFailure'));
      });
    });

    group('NotFoundFailure', () {
      test('uses default message when none is provided', () {
        const failure = NotFoundFailure();
        expect(failure.message, 'Resource not found.');
      });

      test('accepts a custom message', () {
        const failure = NotFoundFailure('Course not found.');
        expect(failure.message, 'Course not found.');
      });
    });

    group('Type safety', () {
      test('all failure types are distinct subtypes of AppFailure', () {
        expect(const AuthFailure(), isA<AppFailure>());
        expect(const NetworkFailure(), isA<AppFailure>());
        expect(const ServerFailure('err'), isA<AppFailure>());
        expect(const StorageFailure(), isA<AppFailure>());
        expect(const OfflineSecurityFailure(), isA<AppFailure>());
        expect(const ValidationFailure('err'), isA<AppFailure>());
        expect(const NotFoundFailure(), isA<AppFailure>());
      });

      test('AuthFailure is not a NetworkFailure', () {
        expect(const AuthFailure(), isNot(isA<NetworkFailure>()));
      });
    });
  });
}
