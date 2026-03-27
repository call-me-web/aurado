import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';

abstract class MarketplaceRepository {
  Future<List<TenantModel>> getFeaturedTenants();
  Future<List<DiscoveryCourseModel>> getDiscoveryCourses({String? tenantId, String? search, String? category});
  Future<List<TenantModel>> searchTenants(String query);
  Future<TenantModel?> getTenantById(String id);

  // ── B2C Payments & Enrollment ──────────────────────────────
  /// Initializes a payment session for a paid course.
  /// Returns the gateway URL (to be opened in browser/webview).
  Future<String> initializePayment({
    required String courseId,
    required String tenantId,
    String? provider,
  });

  /// Enrolls the student in a free course ($0).
  /// Returns true if successful.
  Future<bool> enrollFree({required String courseId});

  /// Fetches the list of courses the current user is enrolled in.
  Future<List<DiscoveryCourseModel>> getEnrolledCourses();
}
