import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Core application-level constants.
/// All environment-specific values are loaded from the `.env` file.
/// Do NOT scatter raw strings or env lookups throughout the codebase.
class AppConstants {
  AppConstants._();

  // ── App Meta ────────────────────────────────────
  static const String appName = 'Aurado';
  static const String appVersion = '1.0.0';

  // ── Supabase ────────────────────────────────────
  static String get supabaseUrl =>
      dotenv.env['VITE_SUPABASE_URL'] ?? '';

  static String get supabaseAnonKey =>
      dotenv.env['VITE_SUPABASE_ANON_KEY'] ?? '';

  // ── Cloudflare R2 ──────────────────────────────
  /// Public base URL for the platform-assets bucket (logos, thumbnails).
  /// Change `CLOUDFLARE_R2_PUBLIC_DOMAIN` in `.env` to switch buckets.
  static String get r2PublicDomain =>
      dotenv.env['CLOUDFLARE_R2_PUBLIC_DOMAIN'] ?? '';

  static String get r2PlatformAssetsBucket =>
      dotenv.env['CLOUDFLARE_R2_PLATFORM_ASSETS_BUCKET'] ?? 'platform-assets';

  static String get r2CourseMaterialsBucket =>
      dotenv.env['CLOUDFLARE_R2_COURSE_MATERIALS_BUCKET'] ?? 'course-materials';

  // ── Offline Policy ───────────────────────────────────────
  /// Max concurrent offline lessons allowed per course.
  static const int offlineMaxLessonsPerCourse = 5;

  /// Offline video expiry in days (enforced client-side via HMAC envelope).
  static const int offlineExpiryDays = 7;

  // ── Network ─────────────────────────────────────────────
  static String get apiBaseUrl =>
      dotenv.env['VITE_API_URL'] ?? 'http://localhost:3000';

  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration cacheStale = Duration(minutes: 15);
}
