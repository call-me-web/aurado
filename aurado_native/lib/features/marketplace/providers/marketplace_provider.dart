import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:aurado/features/marketplace/data/repositories/supabase_marketplace_repository.dart';
import 'package:aurado/core/di/provider_registry.dart';
import 'package:aurado/core/errors/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'marketplace_provider.g.dart';

@riverpod
MarketplaceRepository marketplaceRepository(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final dio = ref.watch(dioProvider);
  return SupabaseMarketplaceRepository(supabase, dio);
}

@riverpod
class MarketplaceTenants extends _$MarketplaceTenants {
  @override
  FutureOr<List<TenantModel>> build() {
    return ref.watch(marketplaceRepositoryProvider).getFeaturedTenants();
  }
}

@riverpod
FutureOr<TenantModel?> tenant(Ref ref, String id) {
  return ref.watch(marketplaceRepositoryProvider).getTenantById(id);
}

@riverpod
class DiscoveryCourses extends _$DiscoveryCourses {
  @override
  FutureOr<List<DiscoveryCourseModel>> build({String? tenantId}) {
    return ref.watch(marketplaceRepositoryProvider).getDiscoveryCourses(tenantId: tenantId);
  }
  
  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => 
      ref.read(marketplaceRepositoryProvider).getDiscoveryCourses(search: query)
    );
  }
}

@riverpod
class EnrolledCourses extends _$EnrolledCourses {
  @override
  FutureOr<List<DiscoveryCourseModel>> build() {
    return ref.watch(marketplaceRepositoryProvider).getEnrolledCourses();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(marketplaceRepositoryProvider).getEnrolledCourses(),
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
    error: (error, stackTrace) => [],
  );
}

@riverpod
class EnrollmentController extends _$EnrollmentController {
  @override
  AsyncValue<String?> build() => const AsyncValue.data(null);

  Future<void> handleEnrollment(DiscoveryCourseModel course) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(marketplaceRepositoryProvider);
      
      if (course.price <= 0) {
        final success = await repository.enrollFree(courseId: course.id);
        if (!success) {
          throw const ServerFailure('Free enrollment failed', statusCode: 500);
        }
        // Force refresh and wait for it to complete to prevent race conditions in router redirects
        await ref.read(enrolledCoursesProvider.notifier).refresh();
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
