import 'dart:math';

import 'package:aurado/core/local_storage/drift_database.dart';
import 'package:aurado/features/learning/domain/repositories/intelligence_repository.dart';
import 'package:drift/drift.dart';

class DriftIntelligenceRepository implements IntelligenceRepository {
  final AppDatabase _db;

  DriftIntelligenceRepository(this._db);

  @override
  Future<void> updateTopicMastery({
    required String studentId,
    required String topicType,
    required String topicId,
    required String topicTag,
    required bool isCorrect,
    double? timeSec,
  }) async {
    // 1. Calculate individual speed score (15s or less = full score)
    double speedScore = 0.0;
    if (isCorrect && timeSec != null) {
      speedScore = (1 - (timeSec / 60.0)).clamp(0.0, 1.0);
    }

    // 2. Fetch existing mastery or create companion
    final existing = await (_db.select(_db.localTopicMastery)
          ..where((t) =>
              t.studentId.equals(studentId) &
              t.topicType.equals(topicType) &
              t.topicId.equals(topicId)))
        .getSingleOrNull();

    final prevMastery = existing?.masteryScore ?? 0.0;
    final totalAttempts = (existing?.totalAttempts ?? 0) + 1;
    final correctAttempts = (existing?.correctAttempts ?? 0) + (isCorrect ? 1 : 0);
    
    // Weighted Average for speed
    final newSpeedScore = existing == null 
        ? speedScore 
        : (existing.speedScore + speedScore) / 2.0;

    // mastery_score = (accuracy * 0.7) + (speed * 0.3)
    final accuracy = correctAttempts / totalAttempts;
    final newMasteryScore = (accuracy * 0.7) + (newSpeedScore * 0.3);

    final companion = LocalTopicMasteryCompanion(
      studentId: Value(studentId),
      topicType: Value(topicType),
      topicId: Value(topicId),
      topicTag: Value(topicTag),
      totalAttempts: Value(totalAttempts),
      correctAttempts: Value(correctAttempts),
      speedScore: Value(newSpeedScore),
      masteryScore: Value(newMasteryScore),
      previousMasteryScore: Value(prevMastery),
      lastAttemptedAt: Value(DateTime.now()),
    );

    await _db.into(_db.localTopicMastery).insertOnConflictUpdate(companion);
  }

  @override
  Future<void> updateReviewQueue({
    required String studentId,
    required String contentType,
    required String contentId,
    String? topicTag,
    required bool wasCorrect,
    DateTime? examDate,
  }) async {
    final existing = await (_db.select(_db.localSmartReviewQueue)
          ..where((t) =>
              t.studentId.equals(studentId) &
              t.contentType.equals(contentType) &
              t.contentId.equals(contentId)))
        .getSingleOrNull();

    int interval = existing?.intervalDays ?? 1;
    double ease = existing?.easeFactor ?? 2.5;

    // SM-2 Algorithm Implementation
    if (wasCorrect) {
      if (existing == null) {
        interval = 1;
      } else if (existing.reviewCount == 1) {
        interval = 6;
      } else {
        interval = (interval * ease).round();
      }
      ease = (ease + 0.1).clamp(1.3, 4.0);
    } else {
      interval = 1;
      ease = (ease - 0.2).clamp(1.3, 4.0);
    }

    // Priority boost if exam is near
    double priority = 0.5;
    if (examDate != null) {
      final daysToExam = examDate.difference(DateTime.now()).inDays;
      if (daysToExam <= 3) {
        priority = 0.95;
      } else if (daysToExam <= 7) {
        priority = 0.8;
      } else if (daysToExam <= 14) {
        priority = 0.65;
      }
    }

    final companion = LocalSmartReviewQueueCompanion(
      studentId: Value(studentId),
      contentType: Value(contentType),
      contentId: Value(contentId),
      topicTag: Value(topicTag),
      intervalDays: Value(interval),
      easeFactor: Value(ease),
      reviewCount: Value((existing?.reviewCount ?? 0) + 1),
      nextReviewAt: Value(DateTime.now().add(Duration(days: interval))),
      priorityScore: Value(priority),
      lastReviewedAt: Value(DateTime.now()),
    );

    await _db.into(_db.localSmartReviewQueue).insertOnConflictUpdate(companion);
  }

  @override
  Future<void> updateDailySummary({
    required String studentId,
    int lessonsWatched = 0,
    int lessonsCompleted = 0,
    int questionsAttempted = 0,
    int minutesStudied = 0,
    double accuracy = 0.0,
  }) async {
    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);

    final existing = await (_db.select(_db.localDailyLearningSummary)
          ..where((t) =>
              t.studentId.equals(studentId) &
              t.summaryDate.equals(dateOnly)))
        .getSingleOrNull();

    final newLessonsWatched = (existing?.lessonsWatched ?? 0) + lessonsWatched;
    final newLessonsCompleted = (existing?.lessonsCompleted ?? 0) + lessonsCompleted;
    final newQuestionsAttempted = (existing?.questionsAttempted ?? 0) + questionsAttempted;
    final newMinutesStudied = (existing?.minutesStudied ?? 0) + minutesStudied;
    final newAccuracy = existing == null ? accuracy : (existing.accuracyToday + accuracy) / 2.0;

    // Quality Score (0-100) for streaks
    final qualityScore = (min(newLessonsCompleted, 3) * 13.3) +
        (min(newAccuracy, 1.0) * 30) +
        (min(newQuestionsAttempted, 10) * 3);
    
    final streakMaintained = qualityScore >= 30;

    final companion = LocalDailyLearningSummaryCompanion(
      studentId: Value(studentId),
      summaryDate: Value(dateOnly),
      lessonsWatched: Value(newLessonsWatched),
      lessonsCompleted: Value(newLessonsCompleted),
      questionsAttempted: Value(newQuestionsAttempted),
      minutesStudied: Value(newMinutesStudied),
      accuracyToday: Value(newAccuracy),
      streakMaintained: Value(streakMaintained),
    );

    await _db.into(_db.localDailyLearningSummary).insertOnConflictUpdate(companion);
  }

  @override
  Future<void> addNote({
    required String studentId,
    required String lessonId,
    required String tenantId,
    required String content,
    int? timestampSec,
  }) async {
    final companion = LocalStudentNotesCompanion.insert(
      studentId: studentId,
      lessonId: lessonId,
      tenantId: tenantId,
      content: content,
      timestampSec: Value(timestampSec),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
    await _db.into(_db.localStudentNotes).insert(companion);
  }

  @override
  Future<void> addBookmark({
    required String studentId,
    required String tenantId,
    required String contentType,
    required String contentId,
    String? note,
  }) async {
    final companion = LocalStudentBookmarksCompanion.insert(
      studentId: studentId,
      tenantId: tenantId,
      contentType: contentType,
      contentId: contentId,
      note: Value(note),
      createdAt: Value(DateTime.now()),
    );
    await _db.into(_db.localStudentBookmarks).insertOnConflictUpdate(companion);
  }
}
