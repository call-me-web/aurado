import 'package:aurado/features/learning/domain/models/chapter_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_model.freezed.dart';
part 'subject_model.g.dart';

@freezed
abstract class SubjectModel with _$SubjectModel {
  const factory SubjectModel({
    required String id,
    @JsonKey(name: 'course_id') required String courseId,
    required String title,
    @Default(0) int order,
    @Default([]) List<ChapterModel> chapters,
  }) = _SubjectModel;

  factory SubjectModel.fromJson(Map<String, dynamic> json) => _$SubjectModelFromJson(json);
}
