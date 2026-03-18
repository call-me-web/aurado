import 'package:flutter_test/flutter_test.dart';
import 'package:aurado/core/network/dio_client.dart';

void main() {
  group('DioClient Verification', () {
    test('should initialize Dio with base options', () {
      final client = DioClient();
      expect(client.instance.options.connectTimeout, const Duration(seconds: 30));
      expect(client.instance.options.receiveTimeout, const Duration(seconds: 30));
    });

    test('should contain InternalInterceptor and LogInterceptor', () {
      final client = DioClient();
      final interceptors = client.instance.interceptors;

      expect(interceptors.any((i) => i is InternalInterceptor), isTrue);
      expect(interceptors.any((i) => i.runtimeType.toString() == 'LogInterceptor'), isTrue);
    });
  });
}
