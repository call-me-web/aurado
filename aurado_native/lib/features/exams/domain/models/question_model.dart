import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
abstract class QuestionModel with _$QuestionModel {
  const QuestionModel._();

  const factory QuestionModel({
    required String id,
    @JsonKey(name: 'exam_id') required String examId,
    required String type, // 'mcq', 'cq', etc.
    required String content,
    @Default([]) List<QuestionOptionModel> options,
    @JsonKey(name: 'cq_parts') @Default([]) List<Map<String, dynamic>> cqParts,
    String? explanation,
    @Default(1) int marks,
    @JsonKey(name: 'order') @Default(0) int orderIndex,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}

@freezed
abstract class QuestionOptionModel with _$QuestionOptionModel {
  const QuestionOptionModel._();

  const factory QuestionOptionModel({
    required String id,
    required String text,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_correct') @Default(false) bool isCorrect,
  }) = _QuestionOptionModel;

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionModelFromJson(json);
}
