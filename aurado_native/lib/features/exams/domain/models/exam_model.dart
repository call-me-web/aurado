import 'package:aurado/features/exams/domain/models/question_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
abstract class ExamModel with _$ExamModel {
  const ExamModel._();

  const factory ExamModel({
    required String id,
    @JsonKey(name: 'tenant_id') required String tenantId,
    required String title,
    String? description,
    @JsonKey(name: 'duration_minutes') @Default(30) int durationMinutes,
    @JsonKey(name: 'available_from') DateTime? availableFrom,
    @JsonKey(name: 'available_until') DateTime? availableUntil,
    @JsonKey(name: 'passing_score') @Default(0) int passingScore,
    @JsonKey(name: 'total_marks') @Default(0) int totalMarks,
    @JsonKey(name: 'target_type') required String targetType,
    @JsonKey(name: 'target_id') required String targetId,
    @Default({}) Map<String, dynamic> config,
    @Default('draft') String status,
    @Default([]) List<QuestionModel> questions,
  }) = _ExamModel;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);
}
