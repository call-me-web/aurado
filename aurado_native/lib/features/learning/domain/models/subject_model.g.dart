// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) =>
    _SubjectModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      title: json['title'] as String,
      order: (json['order'] as num?)?.toInt() ?? 0,
      chapters:
          (json['chapters'] as List<dynamic>?)
              ?.map((e) => ChapterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SubjectModelToJson(_SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'title': instance.title,
      'order': instance.order,
      'chapters': instance.chapters,
    };
