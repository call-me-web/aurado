import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:aurado/core/di/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'marketplace_provider.g.dart';

@riverpod
class MarketplaceTenants extends _$MarketplaceTenants {
  @override
  FutureOr<List<TenantModel>> build() {
    return sl<MarketplaceRepository>().getFeaturedTenants();
  }
}

@riverpod
FutureOr<TenantModel?> tenant(Ref ref, String id) {
  return sl<MarketplaceRepository>().getTenantById(id);
}

@riverpod
class DiscoveryCourses extends _$DiscoveryCourses {
  @override
  FutureOr<List<DiscoveryCourseModel>> build({String? tenantId}) {
    return sl<MarketplaceRepository>().getDiscoveryCourses(tenantId: tenantId);
  }
  
  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      sl<MarketplaceRepository>().getDiscoveryCourses(search: query)
    );
  }
}

@riverpod
class EnrolledCourses extends _$EnrolledCourses {
  @override
  FutureOr<List<DiscoveryCourseModel>> build() {
    return sl<MarketplaceRepository>().getEnrolledCourses();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => sl<MarketplaceRepository>().getEnrolledCourses(),
    );
  }
}

/// Computes the top popular categories dynamically based on fetched courses.
@riverpod
FutureOr<List<String>> popularCategories(Ref ref) async {
  final coursesAsync = ref.watch(discoveryCoursesProvider());
  
  return coursesAsync.when(
    data: (courses) {
      final categoryCounts = <String, int>{};
      
      for (final course in courses) {
        for (final category in course.courseCategory) {
          categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
        }
      }

      // Sort by frequency (descending) and then alphabetically
      final sortedEntries = categoryCounts.entries.toList()
        ..sort((a, b) {
          final countComparison = b.value.compareTo(a.value);
          if (countComparison != 0) return countComparison;
          return a.key.compareTo(b.key);
        });

      // Return the top 6 categories
      return sortedEntries.take(6).map((e) => e.key).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
}

@riverpod
class EnrollmentController extends _$EnrollmentController {
  @override
  AsyncValue<String?> build() => const AsyncValue.data(null);

  Future<void> handleEnrollment(DiscoveryCourseModel course) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = sl<MarketplaceRepository>();
      
      if (course.price <= 0) {
        final success = await repository.enrollFree(courseId: course.id);
        if (!success) throw Exception('Free enrollment failed');
        ref.invalidate(enrolledCoursesProvider);
        return 'success'; // Indicate success for free enrollment
      } else {
        final paymentUrl = await repository.initializePayment(
          courseId: course.id,
          tenantId: course.tenantId,
        );
        return paymentUrl; // Return the gateway URL for redirection
      }
    });
  }
}
