import 'package:aurado/core/constants/app_constants.dart';
import 'package:aurado/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service to resolve playable URLs for private course content.
///
/// If a URL points to a private Cloudflare R2 bucket, it requests
/// a short-lived (1 hour) signed URL from the Aurado Express backend.
class SignedUrlResolver {
  final Dio _dio;
  final SupabaseClient _supabase;

  SignedUrlResolver(this._dio, this._supabase);

  /// Resolves a raw URL into a playable/viewable URL.
  /// 
  /// - [url]: The raw content URL from the database.
  /// - [courseId]: Mandatory for private assets to verify enrollment.
  /// - [tenantId]: Optional context for admin/editor access checks.
  Future<String> resolve(
    String url, {
    required String courseId,
    String? tenantId,
    String? lessonTitle,
  }) async {
    // 1. Skip if empty, local, or already a signed/public URL
    if (url.isEmpty) return url;
    
    final isR2 = url.contains('r2.cloudflarestorage.com') || 
                 url.contains('r2.dev') ||
                 url.contains('.r2.'); // Catch-all for most R2 patterns
    
    final publicDomain = AppConstants.r2PublicDomain;
    final isOnPublicDomain = publicDomain.isNotEmpty && url.contains(publicDomain);
    
    // Check if it's already a signed URL (has signature params)
    final isAlreadySigned = url.contains('X-Amz-Signature=');
    
    // If it's not R2, or it's public, or it's already signed, return as is.
    if (!isR2 || isOnPublicDomain || isAlreadySigned) return url;

    // 2. Request a signed URL from the backend
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return url; // Fallback to original

      final queryParams = {
        'url': url,
        'courseId': courseId,
      };
      if (tenantId != null) queryParams['tenantId'] = tenantId;
      if (lessonTitle != null) queryParams['lessonTitle'] = lessonTitle;

      final response = await _dio.get(
        '${AppConstants.apiBaseUrl}${ApiEndpoints.storageSignUrl}',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${session.accessToken}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final signedUrl = response.data['signedUrl'] as String?;
        return signedUrl ?? url;
      }
    } on DioException catch (e) {
      // Log errors but return original URL as fallback
      print('[SignedUrlResolver] Error: ${e.response?.statusCode} ${e.response?.data}');
    } catch (e) {
      print('[SignedUrlResolver] Unexpected error: $e');
    }

    return url;
  }
}
