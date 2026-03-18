import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';
part 'dashboard_data.g.dart';

@freezed
abstract class DashboardData with _$DashboardData {
  const DashboardData._();

  const factory DashboardData({
    @Default('') String studentName,
    @Default(0) int streakCount,
    @Default(0) int reviewsDueCount,
    @Default(0.0) double todayWatchProgress, // 0.0 to 1.0
    @Default(0) int todayWatchMinutes,
    @Default([]) List<RecentLesson> recentLessons,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);
}

@freezed
abstract class RecentLesson with _$RecentLesson {
  const RecentLesson._();

  const factory RecentLesson({
    required String lessonId,
    @Default('Untitled Lesson') String title,
    @Default('') String thumbnailUrl,
    @Default(0) int watchPercentage,
    DateTime? lastAccessedAt,
  }) = _RecentLesson;

  factory RecentLesson.fromJson(Map<String, dynamic> json) => _$RecentLessonFromJson(json);
}
