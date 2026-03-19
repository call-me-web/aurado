import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_attempt_model.freezed.dart';
part 'exam_attempt_model.g.dart';

@freezed
abstract class ExamAttemptModel with _$ExamAttemptModel {
  const ExamAttemptModel._();

  const factory ExamAttemptModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'exam_id') required String examId,
    @Default('started') String status,
    @JsonKey(name: 'attempt_type') @Default('live') String attemptType,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'total_score') @Default(0) int totalScore,
    String? feedback,
  }) = _ExamAttemptModel;

  factory ExamAttemptModel.fromJson(Map<String, dynamic> json) =>
      _$ExamAttemptModelFromJson(json);
}
