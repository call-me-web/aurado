import 'package:aurado/features/learning/domain/models/lesson_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_model.freezed.dart';
part 'chapter_model.g.dart';

@freezed
abstract class ChapterModel with _$ChapterModel {
  const factory ChapterModel({
    required String id,
    @JsonKey(name: 'subject_id') String? subjectId,
    @JsonKey(name: 'course_id') String? courseId,
    required String title,
    @Default(0) int order,
    @Default([]) List<LessonModel> lessons,
  }) = _ChapterModel;

  factory ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);
}
