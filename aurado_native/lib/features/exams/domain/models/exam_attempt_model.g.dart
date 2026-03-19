// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_attempt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExamAttemptModel _$ExamAttemptModelFromJson(Map<String, dynamic> json) =>
    _ExamAttemptModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      status: json['status'] as String? ?? 'started',
      attemptType: json['attempt_type'] as String? ?? 'live',
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      totalScore: (json['total_score'] as num?)?.toInt() ?? 0,
      feedback: json['feedback'] as String?,
    );

Map<String, dynamic> _$ExamAttemptModelToJson(_ExamAttemptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'exam_id': instance.examId,
      'status': instance.status,
      'attempt_type': instance.attemptType,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'total_score': instance.totalScore,
      'feedback': instance.feedback,
    };
