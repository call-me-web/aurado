// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamModel _$ExamModelFromJson(Map<String, dynamic> json) => _ExamModel(
  id: json['id'] as String,
  tenantId: json['tenant_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 30,
  availableFrom: json['available_from'] == null
      ? null
      : DateTime.parse(json['available_from'] as String),
  availableUntil: json['available_until'] == null
      ? null
      : DateTime.parse(json['available_until'] as String),
  passingScore: (json['passing_score'] as num?)?.toInt() ?? 0,
  totalMarks: (json['total_marks'] as num?)?.toInt() ?? 0,
  targetType: json['target_type'] as String,
  targetId: json['target_id'] as String,
  config: json['config'] as Map<String, dynamic>? ?? const {},
  status: json['status'] as String? ?? 'draft',
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ExamModelToJson(_ExamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'title': instance.title,
      'description': instance.description,
      'duration_minutes': instance.durationMinutes,
      'available_from': instance.availableFrom?.toIso8601String(),
      'available_until': instance.availableUntil?.toIso8601String(),
      'passing_score': instance.passingScore,
      'total_marks': instance.totalMarks,
      'target_type': instance.targetType,
      'target_id': instance.targetId,
      'config': instance.config,
      'status': instance.status,
      'questions': instance.questions,
    };
