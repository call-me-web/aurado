import 'package:aurado/features/exams/domain/models/exam_model.dart';
import 'package:aurado/features/exams/domain/models/exam_attempt_model.dart';
import 'package:aurado/features/exams/domain/models/question_response_model.dart';
import 'dart:io';

abstract class ExamRepository {
  Future<List<ExamModel>> getExamsByTarget(String targetType, String targetId);
  Future<ExamModel> getExamById(String examId);
  Future<ExamAttemptModel> getOrStartExamAttempt(String examId, String userId); 
  Future<void> submitExamAttempt(String attemptId, int totalScore); 
  Future<void> upsertQuestionResponse(QuestionResponseModel response);
  Future<String> uploadCqAnswerImage(File file, String tenantSlug, String attemptId, String questionId);
  Future<void> syncProctoringLog(String eventType, String? metadata, String attemptId);
  Future<void> syncEngagementHeartbeat(String attemptId, String questionId, int totalTimeSpentMs);
}
