import 'package:aurado/core/di/service_locator.dart';
import 'package:aurado/features/learning/domain/models/chapter_model.dart';
import 'package:aurado/features/learning/domain/repositories/curriculum_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'learning_provider.g.dart';

@riverpod
FutureOr<List<ChapterModel>> curriculum(Ref ref, String courseId) {
  return sl<CurriculumRepository>().getCurriculum(courseId);
}
