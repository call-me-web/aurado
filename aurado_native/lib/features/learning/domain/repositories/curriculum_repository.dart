import 'package:aurado/features/learning/domain/models/chapter_model.dart';

abstract class CurriculumRepository {
  /// Fetches the full curriculum (chapters and lessons) for a given course.
  Future<List<ChapterModel>> getCurriculum(String courseId);
}
