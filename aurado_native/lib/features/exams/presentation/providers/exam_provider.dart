import 'dart:async';
import 'package:aurado/core/di/service_locator.dart';
import 'package:aurado/features/exams/domain/models/exam_model.dart';
import 'package:aurado/features/exams/domain/models/exam_attempt_model.dart';
import 'package:aurado/features/exams/domain/models/question_response_model.dart';
import 'package:aurado/features/exams/domain/repositories/exam_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exam_provider.g.dart';

@riverpod
Future<List<ExamModel>> exams(Ref ref, String targetType, String targetId) {
  return sl<ExamRepository>().getExamsByTarget(targetType, targetId);
}

@riverpod
Future<ExamModel> exam(Ref ref, String examId) {
  return sl<ExamRepository>().getExamById(examId);
}

@riverpod
class ActiveExamSession extends _$ActiveExamSession {
  Timer? _heartbeatTimer;
  final _stopwatch = Stopwatch();
  String? _currentQuestionId;
  int _currentQuestionTimeMs = 0;

  @override
  FutureOr<ExamAttemptModel?> build() {
    ref.onDispose(() {
      _heartbeatTimer?.cancel();
    });
    return null;
  }

  Future<void> startSession(String examId, String userId) async {
    state = const AsyncLoading();
    try {
      final attempt = await sl<ExamRepository>().getOrStartExamAttempt(examId, userId);
      state = AsyncData(attempt);

      _stopwatch.start();
      _heartbeatTimer = Timer.periodic(const Duration(seconds: 10), (_) => _syncHeartbeat());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void setCurrentQuestion(String questionId) {
    if (_currentQuestionId != questionId) {
      _syncHeartbeat();
      _currentQuestionId = questionId;
      _currentQuestionTimeMs = 0;
      _stopwatch.reset();
      _stopwatch.start();
    }
  }

  Future<void> updateAnswer(String questionId, Map<String, dynamic> answerObject) async {
    final attempt = state.value;
    if (attempt == null) return;

    final response = QuestionResponseModel(
      attemptId: attempt.id,
      questionId: questionId,
      answer: answerObject,
    );

    await sl<ExamRepository>().upsertQuestionResponse(response);
  }

  Future<void> attachCqImage(String questionId, String imageUrl) async {
    final attempt = state.value;
    if (attempt == null) return;

    final response = QuestionResponseModel(
      attemptId: attempt.id,
      questionId: questionId,
      uploadUrls: [imageUrl], 
    );

    await sl<ExamRepository>().upsertQuestionResponse(response);
  }

  void recordProctoringEvent(String eventType, {String? metadata}) {
    final attempt = state.value;
    if (attempt == null) return;

    sl<ExamRepository>().syncProctoringLog(eventType, metadata, attempt.id);
  }

  Future<void> _syncHeartbeat() async {
    final attempt = state.value;
    if (attempt == null || _currentQuestionId == null) return;
    
    final elapsedMs = _stopwatch.elapsedMilliseconds;
    if (elapsedMs > 0) {
      _currentQuestionTimeMs += elapsedMs;
      _stopwatch.reset();
      _stopwatch.start();

      await sl<ExamRepository>().syncEngagementHeartbeat(
        attempt.id,
        _currentQuestionId!,
        _currentQuestionTimeMs,
      );
      _currentQuestionTimeMs = 0;
    }
  }

  Future<void> submit() async {
    final attempt = state.value;
    if (attempt == null) return;
    
    _syncHeartbeat();

    final totalScore = 0; // Handled backend or future implementation
    await sl<ExamRepository>().submitExamAttempt(attempt.id, totalScore);
    
    _heartbeatTimer?.cancel();
    _stopwatch.stop();
    state = const AsyncData(null);
  }
}
