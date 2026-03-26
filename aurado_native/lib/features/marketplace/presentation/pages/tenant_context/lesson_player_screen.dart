import 'package:aurado/features/learning/domain/models/lesson_model.dart';
import 'package:aurado/features/learning/presentation/providers/learning_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:aurado/core/di/provider_registry.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aurado/features/learning/presentation/pages/pdf_viewer_screen.dart';

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
  String? _currentPdfUrl;
  String? _currentPdfTitle;
  bool? _isCurrentPdfDownloadable;
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    // Defer initialization to after the first frame so we have the initial lesson data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndInitialize();
    });
  }

  @override
  void didUpdateWidget(LessonPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lessonId != widget.lessonId) {
      _checkAndInitialize();
    }
  }

  void _checkAndInitialize() {
    final curriculumAsync = ref.read(curriculumProvider(widget.courseId));
    curriculumAsync.whenData((subjects) {
      final allLessons = subjects
          .expand((s) => s.chapters)
          .expand((c) => c.lessons)
          .toList();

      final lessonIndex = allLessons.indexWhere((l) => l.id == widget.lessonId);
      if (lessonIndex != -1) {
        final lesson = allLessons[lessonIndex];
        if (lesson.lessonType.toLowerCase() == 'video' &&
            lesson.contentUrl != null) {
          _initializePlayer(lesson.contentUrl!, lesson.title);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool _isResolving = false;
  String? _errorMessage;

  Future<void> _initializePlayer(String rawUrl, String lessonTitle) async {
    if (_lastInitializedUrl == rawUrl || _isResolving) return;

    setState(() {
      _isResolving = true;
      _errorMessage = null;
    });

    try {
      final resolvedUrl = await ref.read(signedUrlResolverProvider).resolve(
        rawUrl,
        courseId: widget.courseId,
        tenantId: widget.tenantId,
        lessonTitle: lessonTitle,
      );

      if (!mounted) return;

      if (_lastInitializedUrl == rawUrl) {
        setState(() => _isResolving = false);
        return;
      }

      if (_controller != null) {
        _controller!.dispose();
      }
      _lastInitializedUrl = rawUrl;

      final isYoutube =
          resolvedUrl.contains('youtube.com') ||
          resolvedUrl.contains('youtu.be');

      _controller = PodPlayerController(
        playVideoFrom: isYoutube
            ? PlayVideoFrom.youtube(resolvedUrl)
            : PlayVideoFrom.network(resolvedUrl),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          videoQualityPriority: [720, 1080, 480, 360],
        ),
      );

      await _controller!.initialise();
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Video playback failed: $e');
      }
    } finally {
      if (mounted) setState(() => _isResolving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final curriculumAsync = ref.watch(curriculumProvider(widget.courseId));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          curriculumAsync.when(
            data: (subjects) {
          // Flatten Subject -> Chapter -> Lesson
          final allLessons = subjects
              .expand((s) => s.chapters)
              .expand((c) => c.lessons)
              .toList();

          final lessonIndex = allLessons.indexWhere(
            (l) => l.id == widget.lessonId,
          );

          if (lessonIndex == -1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedAlertCircle,
                    color: Colors.white,
                    size: 40,
                  ),
                  const Gap(16),
                  const Text(
                    'Lesson not found',
                    style: TextStyle(color: Colors.white),
                  ),
                  const Gap(24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          final lesson = allLessons[lessonIndex];
          final isVideo = lesson.lessonType.toLowerCase() == 'video';

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Video Player Area
                  if (isVideo && lesson.contentUrl != null) ...[
                    _buildPlayer(lesson.contentUrl!, lesson.title),
                  ] else ...[
                    _buildMediaPlaceholder(lesson, theme),
                  ],
                  // Separator to ensure progress bar is not hidden
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: theme.dividerColor.withValues(alpha: 0.1),
                  ),

                  // 2. Content Details Area
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        // Removed rounded corners to prevent "overlapping" look
                        borderRadius: BorderRadius.zero,
                        border: Border(
                          top: BorderSide(
                            color: theme.dividerColor.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(
                                      alpha: 0.1,
                                    ),
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
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(12),
                            const Divider(),
                            const Gap(12),
                            Text(
                              lesson.description ??
                                  'No description available for this lesson.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Gap(32),
                            if (lesson.pdfUrls.isNotEmpty) ...[
                              Text(
                                'Learning Materials',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(12),
                              ...lesson.pdfUrls.map(
                                (url) => _buildPdfLink(url, lesson, theme),
                              ),
                            ],
                          ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, s) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.white)),
        ),
      ),

          // 3. Draggable PDF Viewer (Persistent at root Stack level)
          DraggableScrollableSheet(
            key: const ValueKey('pdf_draggable_sheet'),
            controller: _sheetController,
            initialChildSize: 0.0,
            minChildSize: 0.0,
            maxChildSize: 0.8,
            snap: true,
            snapSizes: const [0.0, 0.4, 0.7, 0.8],
            builder: (context, scrollController) {
              return ListenableBuilder(
                listenable: _sheetController,
                builder: (context, _) {
                  // Safety check: isAttached must be true before accessing .size
                  if (_currentPdfUrl == null) {
                    return const SizedBox.shrink();
                  }

                  final double size = _sheetController.isAttached
                      ? _sheetController.size
                      : 0.0;

                  if (size < 0.01 && _currentPdfUrl != null) {
                    // Even if size is 0, we need to return the container 
                    // so it's in the tree and can be animated/attached.
                    // But we keep it invisible or zero height.
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      border: Border(
                        top: BorderSide(color: theme.dividerColor, width: 1),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Draggable Area (Header + Toolbar)
                        // Wrapping this in a SingleChildScrollView with the provided controller 
                        // makes this entire top area a drag handle for the sheet.
                        SingleChildScrollView(
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              // Drag Handle
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: colorScheme.surface.withValues(alpha: 0.95),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                              // Toolbar
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _currentPdfTitle ?? 'Learning Materials',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (_isCurrentPdfDownloadable == true)
                                      IconButton(
                                        icon: HugeIcon(
                                          icon: HugeIcons.strokeRoundedDownload01,
                                          color: theme.colorScheme.onSurface,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          final uri = Uri.parse(_currentPdfUrl!);
                                          if (await canLaunchUrl(uri)) {
                                            await launchUrl(
                                              uri,
                                              mode: LaunchMode.externalApplication,
                                            );
                                          }
                                        },
                                      ),
                                    IconButton(
                                      icon: const HugeIcon(
                                        icon: HugeIcons.strokeRoundedMaximize01,
                                        color: Colors.blue,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PdfViewerScreen(
                                              title: _currentPdfTitle ?? '',
                                              url: _currentPdfUrl!,
                                              isDownloadable: _isCurrentPdfDownloadable ?? true,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const HugeIcon(
                                        icon: HugeIcons.strokeRoundedCancel01,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _sheetController.animateTo(
                                          0.0,
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                        Future.delayed(const Duration(milliseconds: 300), () {
                                          if (mounted) {
                                            setState(() {
                                              _currentPdfUrl = null;
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        // 2. PDF Content
                        Expanded(
                          child: size > 0.05
                              ? SfPdfViewer.network(
                                  _currentPdfUrl!,
                                  key: ValueKey(_currentPdfUrl),
                                  canShowScrollHead: true,
                                  canShowScrollStatus: true,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlayer(String url, String title) {
    final theme = Theme.of(context);

    if (_errorMessage != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _lastInitializedUrl = null;
                        _errorMessage = null;
                        setState(() {});
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
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

    if (_controller != null && _controller!.isInitialised) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            PodVideoPlayer(
              controller: _controller!,
              frameAspectRatio: 16 / 9,
              videoAspectRatio: 16 / 9,
              podProgressBarConfig: PodProgressBarConfig(
                playingBarColor: theme.colorScheme.primary,
                circleHandlerColor: theme.colorScheme.primary,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
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

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Center(
        child: CircularProgressIndicator(
          color: theme.colorScheme.primary,
          strokeWidth: 2,
        ),
      ),
    );
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

  Widget _buildPdfLink(String url, LessonModel lesson, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            setState(() => _isResolving = true);
            try {
              final signedUrl = await ref.read(signedUrlResolverProvider).resolve(
                url,
                courseId: widget.courseId,
                tenantId: widget.tenantId,
                lessonTitle: lesson.title,
              );

              if (!mounted) return;

              setState(() {
                _currentPdfUrl = signedUrl;
                _currentPdfTitle = lesson.title;
                _isCurrentPdfDownloadable = lesson.isPdfDownloadable;
                _isResolving = false;
              });

              // Smoothly animate the sheet open
              Future.delayed(const Duration(milliseconds: 150), () {
                if (mounted && _sheetController.isAttached) {
                  _sheetController.animateTo(
                    0.7,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                  );
                }
              });
            } catch (e) {
              if (mounted) {
                setState(() => _isResolving = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to load PDF: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedFile01,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'PDF Document • Study Material',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (lesson.isPdfDownloadable)
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedDownload01,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                const Gap(8),
                HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight01,
                  size: 20,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
