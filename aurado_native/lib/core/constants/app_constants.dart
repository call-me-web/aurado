import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  static String _getEnv(String key, {String defaultValue = ''}) {
    // 1. Try runtime .env (Recommended traditional way)
    final value = dotenv.maybeGet(key);
    if (value != null && value.isNotEmpty) return value;

    // 2. Fallback to compile-time injection (Production standard)
    return String.fromEnvironment(key, defaultValue: defaultValue);
  }

  // ── App Meta ────────────────────────────────────
  static const String appName = 'Aurado';
  static const String appVersion = '1.0.0';

  // ── Supabase ────────────────────────────────────
  static String get supabaseUrl => _getEnv('VITE_SUPABASE_URL');
  static String get supabaseAnonKey => _getEnv('VITE_SUPABASE_ANON_KEY');

  // ── Cloudflare R2 ──────────────────────────────
  static String get r2PublicDomain => _getEnv('CLOUDFLARE_R2_PUBLIC_DOMAIN');
  static String get r2PlatformAssetsBucket => 
      _getEnv('CLOUDFLARE_R2_PLATFORM_ASSETS_BUCKET', defaultValue: 'platform-assets');
  static String get r2CourseMaterialsBucket => 
      _getEnv('CLOUDFLARE_R2_COURSE_MATERIALS_BUCKET', defaultValue: 'course-materials');

  // ── Network ─────────────────────────────────────────────
  static String get apiBaseUrl => 
      _getEnv('VITE_API_URL', defaultValue: 'http://localhost:3000');

  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration cacheStale = Duration(minutes: 15);
}
