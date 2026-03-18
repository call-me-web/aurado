// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    _DashboardData(
      studentName: json['studentName'] as String? ?? '',
      streakCount: (json['streakCount'] as num?)?.toInt() ?? 0,
      reviewsDueCount: (json['reviewsDueCount'] as num?)?.toInt() ?? 0,
      todayWatchProgress:
          (json['todayWatchProgress'] as num?)?.toDouble() ?? 0.0,
      todayWatchMinutes: (json['todayWatchMinutes'] as num?)?.toInt() ?? 0,
      recentLessons:
          (json['recentLessons'] as List<dynamic>?)
              ?.map((e) => RecentLesson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DashboardDataToJson(_DashboardData instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'streakCount': instance.streakCount,
      'reviewsDueCount': instance.reviewsDueCount,
      'todayWatchProgress': instance.todayWatchProgress,
      'todayWatchMinutes': instance.todayWatchMinutes,
      'recentLessons': instance.recentLessons,
    };

_RecentLesson _$RecentLessonFromJson(Map<String, dynamic> json) =>
    _RecentLesson(
      lessonId: json['lessonId'] as String,
      title: json['title'] as String? ?? 'Untitled Lesson',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      watchPercentage: (json['watchPercentage'] as num?)?.toInt() ?? 0,
      lastAccessedAt: json['lastAccessedAt'] == null
          ? null
          : DateTime.parse(json['lastAccessedAt'] as String),
    );

Map<String, dynamic> _$RecentLessonToJson(_RecentLesson instance) =>
    <String, dynamic>{
      'lessonId': instance.lessonId,
      'title': instance.title,
      'thumbnailUrl': instance.thumbnailUrl,
      'watchPercentage': instance.watchPercentage,
      'lastAccessedAt': instance.lastAccessedAt?.toIso8601String(),
    };
