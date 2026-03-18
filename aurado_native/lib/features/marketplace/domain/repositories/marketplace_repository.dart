import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';

abstract class MarketplaceRepository {
  Future<List<TenantModel>> getFeaturedTenants();
  Future<List<DiscoveryCourseModel>> getDiscoveryCourses({String? tenantId, String? search});
}
