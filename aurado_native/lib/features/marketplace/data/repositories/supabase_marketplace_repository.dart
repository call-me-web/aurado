import 'package:aurado/core/constants/app_constants.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMarketplaceRepository implements MarketplaceRepository {
  final SupabaseClient _supabase;

  SupabaseMarketplaceRepository(this._supabase);

  @override
  Future<List<TenantModel>> getFeaturedTenants() async {
    final response = await _supabase
        .from('tenants')
        .select()
        .limit(10);
    
    return (response as List).map((json) {
      final map = Map<String, dynamic>.from(json);
      map['logo_url'] = _normalizeR2Url(map['logo_url'] as String?);
      map['cover_url'] = _normalizeR2Url(map['cover_url'] as String?);
      return TenantModel.fromJson(map);
    }).toList();
  }

  @override
  Future<TenantModel?> getTenantById(String id) async {
    final response = await _supabase
        .from('tenants')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    final map = Map<String, dynamic>.from(response);
    map['logo_url'] = _normalizeR2Url(map['logo_url'] as String?);
    map['cover_url'] = _normalizeR2Url(map['cover_url'] as String?);
    return TenantModel.fromJson(map);
  }

  @override
  Future<List<DiscoveryCourseModel>> getDiscoveryCourses({String? tenantId, String? search}) async {
    var query = _supabase.from('courses').select('''
      *,
      tenants (
        name,
        logo_url
      )
    ''').eq('status', 'published');

    if (tenantId != null) {
      query = query.eq('tenant_id', tenantId);
    }

    if (search != null && search.isNotEmpty) {
      query = query.or(
        'title.ilike.%$search%,'
        'description.ilike.%$search%,'
        'hashtags.cs.{"$search"},'
        'course_category.cs.{"$search"}'
      );
    }

    final response = await query.limit(20);
    
    return (response as List).map((json) {
      final tenantData = json['tenants'] as Map<String, dynamic>?;
      final map = Map<String, dynamic>.from(json);
      
      // Map and Normalize tenant data
      map['tenant_name'] = tenantData?['name'];
      map['tenant_logo_url'] = _normalizeR2Url(tenantData?['logo_url'] as String?);
      
      // Normalize thumbnail
      map['thumbnail_url'] = _normalizeR2Url(map['thumbnail_url'] as String?);
      
      // Handle the numeric price potentially being returned as int or double
      if (map['price'] != null) {
        map['price'] = (map['price'] as num).toDouble();
      }
      
      return DiscoveryCourseModel.fromJson(map);
    }).toList();
  }

  /// Base URL for the public R2 platform-assets bucket.
  /// Read from [AppConstants.r2PublicDomain] which is backed by `.env`.
  static String get _r2PublicBaseUrl => AppConstants.r2PublicDomain;

  /// Normalizes private R2 storage URLs to the correct public domain.
  ///
  /// Strips `https://[accountId].r2.cloudflarestorage.com/[bucket]/[path]`
  /// down to `[path]` and prepends the public base URL.
  /// Already-public URLs (pub-*.r2.dev) are returned unchanged.
  String? _normalizeR2Url(String? url) {
    if (url == null || url.isEmpty) return url;

    // Already on the public domain — no change needed.
    if (url.startsWith(_r2PublicBaseUrl)) return url;

    // Convert old private endpoint to public.
    if (url.contains('r2.cloudflarestorage.com')) {
      try {
        final uri = Uri.parse(url);
        // pathSegments: ['platform-assets', 'fix-academ', 'file.webp']
        // We drop the first segment which is the bucket name.
        final pathSegments = List<String>.from(uri.pathSegments);
        if (pathSegments.isNotEmpty) {
          pathSegments.removeAt(0); // remove bucket name
        }
        final publicPath = pathSegments.join('/');
        return '$_r2PublicBaseUrl/$publicPath';
      } catch (e) {
        debugPrint('_normalizeR2Url: failed to parse "$url": $e');
        return url;
      }
    }

    return url;
  }
}
