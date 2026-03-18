abstract class IntelligenceRepository {
  /// Updates mastery for a specific topic based on a learning outcome.
  Future<void> updateTopicMastery({
    required String studentId,
    required String topicType,
    required String topicId,
    required String topicTag,
    required bool isCorrect,
    double? timeSec,
  });

  /// Schedules or updates a content item in the spaced-repetition review queue.
  Future<void> updateReviewQueue({
    required String studentId,
    required String contentType,
    required String contentId,
    String? topicTag,
    required bool wasCorrect,
    DateTime? examDate,
  });

  /// Updates the daily learning summary for the current day.
  Future<void> updateDailySummary({
    required String studentId,
    int lessonsWatched = 0,
    int lessonsCompleted = 0,
    int questionsAttempted = 0,
    int minutesStudied = 0,
    double accuracy = 0.0,
  });

  /// Records a student note for a specific timestamp in a lesson.
  Future<void> addNote({
    required String studentId,
    required String lessonId,
    required String tenantId,
    required String content,
    int? timestampSec,
  });

  /// Adds a bookmark for a content item.
  Future<void> addBookmark({
    required String studentId,
    required String tenantId,
    required String contentType,
    required String contentId,
    String? note,
  });
}
