import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

/// Performance-optimized Dio client.
/// Uses interceptors for logging and error handling.
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

    _dio.interceptors.addAll([
      InternalInterceptor(),
      LogInterceptor(
        requestHeader: true,
        responseHeader: false,
        requestBody: true,
        responseBody: true,
      ),
    ]);
  }

  late final Dio _dio;

  Dio get instance => _dio;
}

/// Custom interceptor for global request/response handling.
class InternalInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Add global headers (e.g., User-Agent, Tenant-ID if applicable)
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
