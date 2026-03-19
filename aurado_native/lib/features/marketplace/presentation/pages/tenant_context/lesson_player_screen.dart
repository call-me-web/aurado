import 'package:aurado/features/learning/domain/models/lesson_model.dart';
import 'package:aurado/features/learning/presentation/providers/learning_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

class LessonPlayerScreen extends ConsumerStatefulWidget {
  final String tenantId;
  final String courseId;
  final String lessonId;

  const LessonPlayerScreen({
    super.key,
    required this.tenantId,
    required this.courseId,
    required this.lessonId,
  });

  @override
  ConsumerState<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends ConsumerState<LessonPlayerScreen> {
  PodPlayerController? _controller;
  String? _lastInitializedUrl;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _initializePlayer(String url) {
    if (_lastInitializedUrl == url) return;

    _controller?.dispose();
    _lastInitializedUrl = url;

    _controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(url),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        videoQualityPriority: [720, 480, 360],
      ),
    )..initialise().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final curriculumAsync = ref.watch(curriculumProvider(widget.courseId));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: curriculumAsync.when(
        data: (subjects) {
          // Flatten Subject -> Chapter -> Lesson
          final allLessons = subjects
              .expand((s) => s.chapters)
              .expand((c) => c.lessons)
              .toList();

          final lessonIndex =
              allLessons.indexWhere((l) => l.id == widget.lessonId);

          if (lessonIndex == -1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HugeIcon(icon: HugeIcons.strokeRoundedAlertCircle, color: Colors.white, size: 40),
                  const Gap(16),
                  const Text('Lesson not found', style: TextStyle(color: Colors.white)),
                  const Gap(24),
                  ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Go Back')),
                ],
              ),
            );
          }

          final lesson = allLessons[lessonIndex];
          final isVideo = lesson.lessonType.toLowerCase() == 'video';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Video Player Area
              if (isVideo && lesson.contentUrl != null) ...[
                _buildPlayer(lesson.contentUrl!),
              ] else ...[
                _buildMediaPlaceholder(lesson, theme),
              ],

              // 2. Content Details Area
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                lesson.lessonType.toUpperCase(),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (lesson.durationSec != null)
                              Text(
                                '${(lesson.durationSec! / 60).floor()} min',
                                style: theme.textTheme.bodySmall,
                              ),
                          ],
                        ),
                        const Gap(16),
                        Text(
                          lesson.title,
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(12),
                        const Divider(),
                        const Gap(12),
                        Text(
                          lesson.description ??
                              'No description available for this lesson.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const Gap(32),
                        if (lesson.pdfUrls.isNotEmpty) ...[
                          Text('Learning Materials',
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const Gap(12),
                          ...lesson.pdfUrls.map((url) => _buildPdfLink(url, theme)),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, s) => Center(
            child:
                Text('Error: $e', style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildPlayer(String url) {
    _initializePlayer(url);
    if (_controller != null) {
      return Stack(
        children: [
          PodVideoPlayer(
            controller: _controller!,
            frameAspectRatio: 16 / 9,
            videoAspectRatio: 16 / 9,
          ),
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.3),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
  }

  Widget _buildMediaPlaceholder(LessonModel lesson, ThemeData theme) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          Container(
            color: Colors.grey.shade900,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(
                    icon: lesson.lessonType == 'pdf'
                        ? HugeIcons.strokeRoundedFile01
                        : HugeIcons.strokeRoundedMusicNote01,
                    size: 64,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  const Gap(16),
                  Text(
                    '${lesson.lessonType.toUpperCase()} Content',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.3),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfLink(String url, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const HugeIcon(icon: HugeIcons.strokeRoundedFile01, color: Colors.red),
        title: const Text('Lecture Note / PDF', style: TextStyle(fontSize: 14)),
        trailing: const HugeIcon(icon: HugeIcons.strokeRoundedDownload01, size: 20, color: Colors.black),
        onTap: () {
          // TODO: Open PDF
        },
      ),
    );
  }
}
