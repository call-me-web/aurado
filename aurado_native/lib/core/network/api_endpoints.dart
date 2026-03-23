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
  // Backend mounts storage routes at /api/storage/*
  static const String storagePresign = '/api/storage/presign';
  static const String storageSignUrl = '/api/storage/url';
  static const String storageDelete = '/api/storage/delete';

  // ── Health ──────────────────────────────────────────────────
  static const String healthCheck = '/health';
}
