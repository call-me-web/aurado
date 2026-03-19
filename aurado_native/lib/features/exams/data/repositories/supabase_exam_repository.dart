import 'dart:io';
import 'package:aurado/features/exams/domain/models/exam_model.dart';
import 'package:aurado/features/exams/domain/models/exam_attempt_model.dart';
import 'package:aurado/features/exams/domain/models/question_response_model.dart';
import 'package:aurado/features/exams/domain/repositories/exam_repository.dart';
import 'package:aurado/core/constants/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p;

class SupabaseExamRepository implements ExamRepository {
  final SupabaseClient _supabase;

  SupabaseExamRepository(this._supabase);

  @override
  Future<List<ExamModel>> getExamsByTarget(String targetType, String targetId) async {
    final response = await _supabase
        .from('exams')
        .select('*, questions(*)')
        .eq('target_type', targetType)
        .eq('target_id', targetId)
        .eq('status', 'published'); 

    // Because questions has options as jsonb, the model automatically parses it.
    return (response as List).map((json) => ExamModel.fromJson(json)).toList();
  }

  @override
  Future<ExamModel> getExamById(String examId) async {
    final response = await _supabase
        .from('exams')
        .select('*, questions(*)')
        .eq('id', examId)
        .single();

    return ExamModel.fromJson(response);
  }

  @override
  Future<ExamAttemptModel> getOrStartExamAttempt(String examId, String userId) async {
    // Check if an attempt already exists
    final existing = await _supabase
        .from('exam_attempts')
        .select()
        .eq('exam_id', examId)
        .eq('user_id', userId)
        .maybeSingle();

    if (existing != null) {
      return ExamAttemptModel.fromJson(existing);
    }

    // Start a new attempt
    final response = await _supabase.from('exam_attempts').insert({
      'exam_id': examId,
      'user_id': userId,
      'status': 'started',
      'attempt_type': 'live',
      'start_time': DateTime.now().toIso8601String(),
    }).select().single();

    return ExamAttemptModel.fromJson(response);
  }

  @override
  Future<void> submitExamAttempt(String attemptId, int totalScore) async {
    await _supabase.from('exam_attempts').update({
      'status': 'submitted',
      'end_time': DateTime.now().toIso8601String(),
      'total_score': totalScore,
    }).eq('id', attemptId);
  }

  @override
  Future<void> upsertQuestionResponse(QuestionResponseModel response) async {
    await _supabase.from('question_responses').upsert(
      response.toJson(),
      onConflict: 'attempt_id, question_id',
    );
  }

  @override
  Future<String> uploadCqAnswerImage(
    File file,
    String tenantSlug,
    String attemptId,
    String questionId,
  ) async {
    final extension = p.extension(file.path);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '${questionId}_$timestamp$extension';
    
    // Path: {tenant_slug}/exams_paper/{attemptId}/{fileName}
    final storagePath = '$tenantSlug/exams_paper/$attemptId/$fileName';

    await _supabase.storage
        .from(AppConstants.r2CourseMaterialsBucket)
        .upload(storagePath, file);

    return '${AppConstants.r2PublicDomain}/$storagePath';
  }

  @override
  Future<void> syncProctoringLog(
    String eventType,
    String? metadata,
    String attemptId,
  ) async {
    await _supabase.from('proctoring_logs').insert({
      'attempt_id': attemptId,
      'event_type': eventType,
      'metadata': metadata,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> syncEngagementHeartbeat(
    String attemptId,
    String questionId,
    int totalTimeSpentMs,
  ) async {
    await _supabase.rpc('upsert_exam_engagement', params: {
      'p_attempt_id': attemptId,
      'p_question_id': questionId,
      'p_total_time_spent_ms': totalTimeSpentMs,
    });
  }
}
