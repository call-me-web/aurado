import 'package:aurado/features/learning/domain/models/subject_model.dart';

abstract class CurriculumRepository {
  Future<List<SubjectModel>> getFullCurriculum(String courseId);
}
