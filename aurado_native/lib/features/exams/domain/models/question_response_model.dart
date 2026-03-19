import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_response_model.freezed.dart';
part 'question_response_model.g.dart';

@freezed
abstract class QuestionResponseModel with _$QuestionResponseModel {
  const QuestionResponseModel._();

  const factory QuestionResponseModel({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: 'attempt_id') required String attemptId,
    @JsonKey(name: 'question_id') required String questionId,
    Map<String, dynamic>? answer,
    @JsonKey(name: 'upload_urls') @Default([]) List<String> uploadUrls,
    @JsonKey(name: 'time_spent_ms') @Default(0) int timeSpentMs,
    @JsonKey(name: 'marks_obtained') @Default(0) int marksObtained,
    @JsonKey(name: 'is_correct') @Default(false) bool isCorrect,
  }) = _QuestionResponseModel;

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseModelFromJson(json);
}
