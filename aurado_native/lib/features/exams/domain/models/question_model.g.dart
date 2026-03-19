// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    _QuestionModel(
      id: json['id'] as String,
      examId: json['exam_id'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      options:
          (json['options'] as List<dynamic>?)
              ?.map(
                (e) => QuestionOptionModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      cqParts:
          (json['cq_parts'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      explanation: json['explanation'] as String?,
      marks: (json['marks'] as num?)?.toInt() ?? 1,
      orderIndex: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QuestionModelToJson(_QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exam_id': instance.examId,
      'type': instance.type,
      'content': instance.content,
      'options': instance.options,
      'cq_parts': instance.cqParts,
      'explanation': instance.explanation,
      'marks': instance.marks,
      'order': instance.orderIndex,
    };

_QuestionOptionModel _$QuestionOptionModelFromJson(Map<String, dynamic> json) =>
    _QuestionOptionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      imageUrl: json['image_url'] as String?,
      isCorrect: json['is_correct'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionOptionModelToJson(
  _QuestionOptionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'image_url': instance.imageUrl,
  'is_correct': instance.isCorrect,
};
