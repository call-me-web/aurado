import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';

/// Performance-optimized Dio client.
///
/// Interceptors:
/// - [InternalInterceptor]: always active — handles global request/response hooks.
/// - [LogInterceptor]: **debug builds only** — never logs in release to prevent
///   Authorization headers and response bodies from appearing in logcat/console.
class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.networkTimeout,
        receiveTimeout: AppConstants.networkTimeout,
        sendTimeout: AppConstants.networkTimeout,
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(InternalInterceptor());

    // SECURITY: Only log in debug mode. Release builds must never expose
    // Authorization headers or response payloads to the system log.
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
        ),
      );
    }
  }

  late final Dio _dio;

  Dio get instance => _dio;
}

/// Custom interceptor for global request/response handling.
class InternalInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['User-Agent'] = 'Aurado-Native/1.0.0';
    // Add other persistent headers here
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Handle globally successful but logically failed responses if needed
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Map Dio errors to AppFailures here if needed for global logging
    super.onError(err, handler);
  }
}
