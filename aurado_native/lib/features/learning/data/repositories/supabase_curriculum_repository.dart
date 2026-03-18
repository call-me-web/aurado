import 'package:aurado/features/learning/domain/models/chapter_model.dart';
import 'package:aurado/features/learning/domain/models/lesson_model.dart';
import 'package:aurado/features/learning/domain/models/subject_model.dart';
import 'package:aurado/features/learning/domain/repositories/curriculum_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCurriculumRepository implements CurriculumRepository {
  final SupabaseClient _supabase;

  SupabaseCurriculumRepository(this._supabase);

  @override
  Future<List<SubjectModel>> getFullCurriculum(String courseId) async {
    // 1. Fetch Subjects, Chapters, and Lessons in parallel for the course
    final subjectsFuture = _supabase
        .from('subjects')
        .select()
        .eq('course_id', courseId)
        .order('order');

    final chaptersFuture = _supabase
        .from('chapters')
        .select()
        .eq('course_id', courseId)
        .order('order');

    final lessonsFuture = _supabase
        .from('lessons')
        .select()
        .eq('course_id', courseId)
        .order('order');

    final results = await Future.wait([
      subjectsFuture,
      chaptersFuture,
      lessonsFuture,
    ]);

    final rawSubjects = (results[0] as List);
    final rawChapters = (results[1] as List);
    final rawLessons = (results[2] as List);

    // 2. Parse into models
    final lessons = rawLessons.map((l) => LessonModel.fromJson(l)).toList();
    final chaptersList = rawChapters.map((c) => ChapterModel.fromJson(c)).toList();
    final subjectsList = rawSubjects.map((s) => SubjectModel.fromJson(s)).toList();

    // 3. Organise Hierarchy
    // To accommodate direct course chapters/lessons, we might need a "Virtual" root or handle them specifically.
    // For now, let's group lessons into chapters and chapters into subjects.
    
    final finalChapters = chaptersList.map((chapter) {
      return chapter.copyWith(
        lessons: lessons.where((l) => l.chapterId == chapter.id).toList(),
      );
    }).toList();

    final finalSubjects = subjectsList.map((subject) {
      return subject.copyWith(
        chapters: finalChapters.where((c) => c.subjectId == subject.id).toList(),
      );
    }).toList();

    return finalSubjects;
  }
}
