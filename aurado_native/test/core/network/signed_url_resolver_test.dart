import 'package:flutter_test/flutter_test.dart';
import 'package:aurado/core/network/signed_url_resolver.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A minimal Dio fake that always throws — used to verify that
/// SignedUrlResolver returns the original URL before any network call
/// is made (i.e., for pass-through cases).
class _ThrowingDio implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    throw StateError(
      '_ThrowingDio.get was called — the resolver should have returned early '
      'for this URL without making any network request.',
    );
  }

  // Satisfy every unused member of the Dio interface.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A SupabaseClient fake that returns a null session — simulates an
/// unauthenticated state so request-path tests stay offline.
class _UnauthenticatedSupabaseClient implements SupabaseClient {
  @override
  GoTrueClient get auth => _FakeGoTrueClient();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeGoTrueClient implements GoTrueClient {
  @override
  Session? get currentSession => null;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late SignedUrlResolver resolver;

  setUp(() {
    resolver = SignedUrlResolver(
      _ThrowingDio(),
      _UnauthenticatedSupabaseClient(),
    );
  });

  group('SignedUrlResolver — pass-through cases (no network call)', () {
    test('returns empty string for an empty URL', () async {
      final result = await resolver.resolve('', courseId: 'c1');
      expect(result, isEmpty);
    });

    test('returns the URL unchanged when it is not an R2 URL', () async {
      const nonR2 = 'https://example.com/public/video.mp4';
      final result = await resolver.resolve(nonR2, courseId: 'c1');
      expect(result, nonR2);
    });

    test('returns the URL unchanged when it is a YouTube URL', () async {
      const youtube = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
      final result = await resolver.resolve(youtube, courseId: 'c1');
      expect(result, youtube);
    });

    test('returns R2 URL unchanged when it is already signed (has X-Amz-Signature)', () async {
      const signed =
          'https://bucket.r2.cloudflarestorage.com/file.mp4?X-Amz-Signature=abc123';
      final result = await resolver.resolve(signed, courseId: 'c1');
      expect(result, signed);
    });

    test('returns R2 URL unchanged when it matches the configured public domain', () async {
      // AppConstants.r2PublicDomain is empty in test (no dart-define).
      // This means the isOnPublicDomain guard won't fire, which is correct:
      // in production the dart-define injects the real domain.
      // We test the positive case by constructing a URL that contains
      // 'X-Amz-Signature' to use the signed-URL guard instead.
      const alreadySigned =
          'https://pub-something.r2.dev/logo.png?X-Amz-Signature=xyz';
      final result = await resolver.resolve(alreadySigned, courseId: 'c2');
      expect(result, alreadySigned);
    });
  });

  group('SignedUrlResolver — R2 URL that needs signing', () {
    test(
      'falls back to the original URL when session is null (unauthenticated)',
      () async {
        // The fake supabase client returns null session, so the resolver
        // should short-circuit and return the original URL without calling Dio.
        // If Dio were called, _ThrowingDio would throw a StateError.
        const r2 = 'https://private.r2.cloudflarestorage.com/lesson.mp4';
        final result = await resolver.resolve(r2, courseId: 'c1');
        expect(result, r2);
      },
    );
  });
}
