import 'package:aurado/core/local_storage/drift_database.dart';
import 'package:aurado/features/home/domain/models/dashboard_data.dart';
import 'package:aurado/features/home/domain/repositories/dashboard_repository.dart';
import 'package:drift/drift.dart';

class DriftDashboardRepository implements DashboardRepository {
  final AppDatabase _db;

  DriftDashboardRepository(this._db);

  @override
  Future<DashboardData> getDashboardData(String studentId) async {
    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);

    // 1. Fetch Today's Summary
    final summary = await (_db.select(_db.localDailyLearningSummary)
          ..where((t) => t.studentId.equals(studentId) & t.summaryDate.equals(dateOnly)))
        .getSingleOrNull();

    // 2. Fetch Reviews Due Today
    final reviewQuery = _db.select(_db.localSmartReviewQueue)
      ..where((t) => t.studentId.equals(studentId) & t.nextReviewAt.isSmallerOrEqualValue(DateTime.now()));
    final reviewsDue = await reviewQuery.get();

    return DashboardData(
      recentLessons: await getRecentLessons(studentId),
      todayWatchProgress: (summary?.minutesStudied ?? 0) / 30.0, // Assuming 30m goal
      todayWatchMinutes: summary?.minutesStudied ?? 0,
      reviewsDueCount: reviewsDue.length,
      streakCount: 0, // Profile notifier will overlay this
    );
  }

  @override
  Future<List<RecentLesson>> getRecentLessons(String studentId, {int limit = 10}) async {
    final query = _db.select(_db.localLessonMastery)
      ..where((t) => t.studentId.equals(studentId))
      ..orderBy([(t) => OrderingTerm(expression: t.lastAccessedAt, mode: OrderingMode.desc)])
      ..limit(limit);

    final results = await query.get();

    return results.map((row) => RecentLesson(
      lessonId: row.lessonId,
      watchPercentage: row.watchPercentage,
      lastAccessedAt: row.lastAccessedAt,
      // Metadata like title/thumb would ideally come from a joined Lessons table
      // or a separate repository. For now, we use placeholders.
      title: 'Lesson ${row.lessonId.length > 5 ? row.lessonId.substring(0, 5) : row.lessonId}...', 
      thumbnailUrl: '',
    )).toList();
  }
}
