import 'package:aurado/core/di/provider_registry.dart';
import 'package:aurado/features/auth/providers/auth_provider.dart';
import 'package:aurado/features/home/domain/models/dashboard_data.dart';
import 'package:aurado/features/home/domain/repositories/dashboard_repository.dart';
import 'package:aurado/features/home/data/repositories/drift_dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftDashboardRepository(db);
}

@riverpod
class Dashboard extends _$Dashboard {
  DashboardRepository get _repository => ref.watch(dashboardRepositoryProvider);

  @override
  FutureOr<DashboardData> build() async {
    // Watch auth state — if user logs out/in, dashboard should reset/reload.
    final authState = ref.watch(authProvider);
    
    if (authState.status == AuthStatus.authenticated && authState.user != null) {
      final user = authState.user!;
      return _fetchData(user.id, user.name, user.streakCount);
    }
    
    return const DashboardData();
  }

  Future<DashboardData> _fetchData(String userId, String? name, int streak) async {
    final data = await _repository.getDashboardData(userId);
    return data.copyWith(
      studentName: name ?? 'Learner',
      streakCount: streak,
    );
  }

  /// Manually refresh the dashboard data.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authState = ref.read(authProvider);
      if (authState.status == AuthStatus.authenticated && authState.user != null) {
        final user = authState.user!;
        return _fetchData(user.id, user.name, user.streakCount);
      }
      return const DashboardData();
    });
  }
}
