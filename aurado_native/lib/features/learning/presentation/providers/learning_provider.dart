import 'package:aurado/core/di/provider_registry.dart';
import 'package:aurado/features/learning/domain/models/subject_model.dart';
import 'package:aurado/features/learning/domain/repositories/curriculum_repository.dart';
import 'package:aurado/features/learning/data/repositories/supabase_curriculum_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'learning_provider.g.dart';

@riverpod
CurriculumRepository curriculumRepository(Ref ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return SupabaseCurriculumRepository(supabase);
}

@riverpod
FutureOr<List<SubjectModel>> curriculum(Ref ref, String courseId) {
  return ref.watch(curriculumRepositoryProvider).getFullCurriculum(courseId);
}
