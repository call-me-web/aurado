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
        title: const Text('Course Content'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: curriculumAsync.when(
        data: (chapters) {
          if (chapters.isEmpty) {
            return const Center(child: Text('No curriculum found for this course.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              return _buildChapterTile(context, chapters[index], colorScheme, textTheme);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildChapterTile(
    BuildContext context,
    ChapterModel chapter,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${chapter.orderIndex + 1}',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  chapter.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...chapter.lessons.map((lesson) => _buildLessonItem(context, lesson, colorScheme, textTheme)),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildLessonItem(
    BuildContext context,
    LessonModel lesson,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final isVideo = lesson.contentType.toLowerCase() == 'video';
    
    return InkWell(
      onTap: () {
        // Navigate to Lesson Player
        context.push('/platform/$tenantId/course/$courseId/lesson/${lesson.id}');
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                      decoration: lesson.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (isVideo)
                    Text(
                      'Video Lesson',
                      style: textTheme.bodySmall?.copyWith(fontSize: 10),
                    ),
                ],
              ),
            ),
            if (lesson.isCompleted)
              const Icon(Icons.check_circle, color: Colors.green, size: 16)
            else
              const Icon(Icons.arrow_forward_ios_rounded, size: 14),
          ],
        ),
      ),
    );
  }
}
