import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aurado/core/network/dio_client.dart';

void main() {
  group('DioClient', () {
    test('initialises Dio with the correct base timeouts', () {
      final client = DioClient();
      expect(client.instance.options.connectTimeout, const Duration(seconds: 30));
      expect(client.instance.options.receiveTimeout, const Duration(seconds: 30));
      expect(client.instance.options.sendTimeout, const Duration(seconds: 30));
    });

    test('always registers InternalInterceptor', () {
      final client = DioClient();
      expect(
        client.instance.interceptors.any((i) => i is InternalInterceptor),
        isTrue,
      );
    });

    test('registers LogInterceptor only in debug mode', () {
      final client = DioClient();
      final hasLogInterceptor = client.instance.interceptors
          .any((i) => i.runtimeType.toString() == 'LogInterceptor');

      // flutter test runs in debug mode, so LogInterceptor IS expected.
      // In release builds this assertion would be false — intentionally.
      expect(hasLogInterceptor, kDebugMode);
    });
  });
}
