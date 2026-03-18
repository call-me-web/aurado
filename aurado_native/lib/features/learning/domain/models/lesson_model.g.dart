// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => _LessonModel(
  id: json['id'] as String,
  chapterId: json['chapter_id'] as String?,
  subjectId: json['subject_id'] as String?,
  courseId: json['course_id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  contentUrl: json['content_url'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  pdfUrls:
      (json['pdf_urls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isFree: json['is_free'] as bool? ?? false,
  order: (json['order'] as num?)?.toInt() ?? 0,
  lessonType: json['lesson_type'] as String? ?? 'video',
  durationSec: (json['duration_sec'] as num?)?.toInt(),
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$LessonModelToJson(_LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter_id': instance.chapterId,
      'subject_id': instance.subjectId,
      'course_id': instance.courseId,
      'title': instance.title,
      'description': instance.description,
      'content_url': instance.contentUrl,
      'thumbnail_url': instance.thumbnailUrl,
      'pdf_urls': instance.pdfUrls,
      'is_free': instance.isFree,
      'order': instance.order,
      'lesson_type': instance.lessonType,
      'duration_sec': instance.durationSec,
      'isCompleted': instance.isCompleted,
    };
