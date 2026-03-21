/// Centralized API endpoint constants for the Aurado app.
class ApiEndpoints {
  ApiEndpoints._();

  // ── Base URLs ───────────────────────────────────────────────
  // Note: Most data comes via Supabase client, but Dio is used for
  // specialized external services or custom edge functions.
  static const String baseApiUrl = 'https://api.aurado.com/v1'; // Placeholder

  // ── Auth ────────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';

  // ── Courses & Projects ──────────────────────────────────────
  static const String courses = '/courses';
  static const String tenantBranding = '/branding';
  
  // ── Storage ─────────────────────────────────────────────────
  static const String storagePresign = '/storage/presign';
  static const String storageSignUrl = '/storage/url';
  static const String storageDelete = '/storage/delete';

  // ── Health ──────────────────────────────────────────────────
  static const String healthCheck = '/health';
}
