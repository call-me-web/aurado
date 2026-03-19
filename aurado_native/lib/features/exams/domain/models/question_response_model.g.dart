// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionResponseModel _$QuestionResponseModelFromJson(
  Map<String, dynamic> json,
) => _QuestionResponseModel(
  id: json['id'] as String?,
  attemptId: json['attempt_id'] as String,
  questionId: json['question_id'] as String,
  answer: json['answer'] as Map<String, dynamic>?,
  uploadUrls:
      (json['upload_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  timeSpentMs: (json['time_spent_ms'] as num?)?.toInt() ?? 0,
  marksObtained: (json['marks_obtained'] as num?)?.toInt() ?? 0,
  isCorrect: json['is_correct'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionResponseModelToJson(
  _QuestionResponseModel instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'attempt_id': instance.attemptId,
  'question_id': instance.questionId,
  'answer': instance.answer,
  'upload_urls': instance.uploadUrls,
  'time_spent_ms': instance.timeSpentMs,
  'marks_obtained': instance.marksObtained,
  'is_correct': instance.isCorrect,
};
