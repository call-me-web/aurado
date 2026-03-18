import 'package:aurado/features/learning/presentation/providers/learning_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:gap/gap.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Lesson Player'),
      ),
      body: curriculumAsync.when(
        data: (chapters) {
          final allLessons = chapters.expand((c) => c.lessons).toList();
          final lessonIndex = allLessons.indexWhere((l) => l.id == widget.lessonId);
          
          if (lessonIndex == -1) {
            return const Center(child: Text('Lesson not found', style: TextStyle(color: Colors.white)));
          }
          
          final lesson = allLessons[lessonIndex];
          final isVideo = lesson.contentType.toLowerCase() == 'video';

          if (isVideo && lesson.videoUrl != null) {
            _initializePlayer(lesson.videoUrl!);
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_controller != null)
                  PodVideoPlayer(
                    controller: _controller!,
                    frameAspectRatio: 16 / 9,
                    videoAspectRatio: 16 / 9,
                  )
                else
                  const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(child: CircularProgressIndicator(color: Colors.white)),
                  ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        Text(
                          'Lesson ${lesson.orderIndex + 1} • Video',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                        ),
                        const Gap(24),
                        const Divider(),
                        const Gap(24),
                        // TODO: Implement description or notes
                        Text(
                          'Enjoy this secure learning session. Screen recording is disabled to protect content intellectual property.',
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (lesson.contentType.toLowerCase() == 'pdf') {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.picture_as_pdf_outlined, size: 80, color: Colors.white),
                    const Gap(24),
                    Text(
                      lesson.title,
                      style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(12),
                    const Text(
                      'PDF Resource Viewer Placeholder',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const Gap(40),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement PDF viewing
                      },
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: const Text('Open PDF'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Unsupported content type', style: TextStyle(color: Colors.white)));
          }
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, s) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
