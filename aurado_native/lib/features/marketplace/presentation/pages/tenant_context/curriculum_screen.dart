import 'package:aurado/features/learning/domain/models/subject_model.dart';
import 'package:aurado/features/learning/domain/models/chapter_model.dart';
import 'package:aurado/features/learning/domain/models/lesson_model.dart';
import 'package:aurado/features/learning/presentation/providers/learning_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class CurriculumScreen extends ConsumerWidget {
  final String tenantId;
  final String courseId;

  const CurriculumScreen({
    super.key,
    required this.tenantId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curriculumAsync = ref.watch(curriculumProvider(courseId));

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Content', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: curriculumAsync.when(
        data: (subjects) {
          if (subjects.isEmpty) {
            return const Center(child: Text('No curriculum found for this course.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return _buildSubjectSection(context, subjects[index], colorScheme, textTheme);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildSubjectSection(
    BuildContext context,
    SubjectModel subject,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            subject.title,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
            ),
          ),
        ),
        ...subject.chapters.map((chapter) => _buildChapterTile(context, chapter, colorScheme, textTheme)),
        const Gap(24),
      ],
    );
  }

  Widget _buildChapterTile(
    BuildContext context,
    ChapterModel chapter,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ExpansionTile(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          chapter.title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${chapter.lessons.length} Lessons',
          style: textTheme.bodySmall,
        ),
        children: chapter.lessons
            .map((lesson) => _buildLessonItem(context, lesson, colorScheme, textTheme))
            .toList(),
      ),
    );
  }

  Widget _buildLessonItem(
    BuildContext context,
    LessonModel lesson,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final isVideo = lesson.lessonType.toLowerCase() == 'video';

    return InkWell(
      onTap: () {
        context.push('/platform/$tenantId/course/$courseId/lesson/${lesson.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            HugeIcon(
              icon: isVideo ? HugeIcons.strokeRoundedPlayCircle : HugeIcons.strokeRoundedFile01,
              color: lesson.isCompleted ? Colors.green : colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: lesson.isCompleted ? FontWeight.normal : FontWeight.w500,
                    ),
                  ),
                  Text(
                    isVideo ? 'Video Lesson' : 'Resource',
                    style: textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
            if (lesson.isCompleted)
              const HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkCircle02, color: Colors.green, size: 16)
            else
              const HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
