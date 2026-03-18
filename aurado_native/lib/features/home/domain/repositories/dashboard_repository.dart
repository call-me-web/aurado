import '../models/dashboard_data.dart';

abstract class DashboardRepository {
  /// Fetches aggregated dashboard data for the given student.
  Future<DashboardData> getDashboardData(String studentId);
  
  /// Fetches the list of recently accessed lessons.
  Future<List<RecentLesson>> getRecentLessons(String studentId, {int limit = 10});
}
