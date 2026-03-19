import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_model.freezed.dart';
part 'lesson_model.g.dart';

@freezed
abstract class LessonModel with _$LessonModel {
  const factory LessonModel({
    required String id,
    @JsonKey(name: 'chapter_id') String? chapterId,
    @JsonKey(name: 'subject_id') String? subjectId,
    @JsonKey(name: 'course_id') String? courseId,
    required String title,
    String? description,
    @JsonKey(name: 'content_url') String? contentUrl,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'pdf_urls') @Default([]) List<String> pdfUrls,
    @JsonKey(name: 'is_free') @Default(false) bool isFree,
    @Default(0) int order,
    @JsonKey(name: 'lesson_type') @Default('video') String lessonType,
    @JsonKey(name: 'duration_sec') int? durationSec,
    @Default(false) bool isCompleted,
  }) = _LessonModel;

  factory LessonModel.fromJson(Map<String, dynamic> json) => _$LessonModelFromJson(json);
}
