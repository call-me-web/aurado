// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) =>
    _ChapterModel(
      id: json['id'] as String,
      subjectId: json['subject_id'] as String?,
      courseId: json['course_id'] as String?,
      title: json['title'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      lessons:
          (json['lessons'] as List<dynamic>?)
              ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChapterModelToJson(_ChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject_id': instance.subjectId,
      'course_id': instance.courseId,
      'title': instance.title,
      'order': instance.order,
      'lessons': instance.lessons,
    };
