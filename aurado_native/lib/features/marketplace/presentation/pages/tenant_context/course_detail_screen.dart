import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';

// Height of the hero image banner at the top.
const double _kHeroHeight = 280.0;

class CourseDetailScreen extends ConsumerWidget {
  final String tenantId;
  final String courseId;

  const CourseDetailScreen({
    super.key,
    required this.tenantId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(discoveryCoursesProvider(tenantId: tenantId));

    final enrollmentState = ref.watch(enrollmentControllerProvider);
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final isLoading = enrollmentState.isLoading;

    // Listen to enrollment status changes to react to success/payment.
    ref.listen(enrollmentControllerProvider, (previous, next) {
      final urlOrStatus = next.asData?.value;
      if (urlOrStatus == null) return;
      if (urlOrStatus == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully enrolled!')),
        );
        context.pushReplacement('/platform/$tenantId/course/$courseId/overview');
      } else {
        final uri = Uri.tryParse(urlOrStatus);
        if (uri != null && (uri.hasScheme || urlOrStatus.startsWith('http'))) {
          launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    });

    final isEnrolled = enrolledCoursesAsync.when(
      data: (courses) => courses.any((c) => c.id == courseId),
      loading: () => false,
      error: (error, stack) => false,
    );

    return coursesAsync.when(
      data: (courses) {
        final course = courses.where((c) => c.id == courseId).firstOrNull;

        if (course == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Course not found')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('This course could not be found.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        return _CourseDetailBody(
          course: course,
          isLoading: isLoading,
          isEnrolled: isEnrolled,
          tenantId: tenantId,
          courseId: courseId,
          ref: ref,
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}

/// Extracted body widget to avoid rebuilding the entire tree unnecessarily.
class _CourseDetailBody extends StatelessWidget {
  final DiscoveryCourseModel course;
  final bool isLoading;
  final bool isEnrolled;
  final String tenantId;
  final String courseId;
  final WidgetRef ref;

  const _CourseDetailBody({
    required this.course,
    required this.isLoading,
    required this.isEnrolled,
    required this.tenantId,
    required this.courseId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // ── Scrollable content ──────────────────────────────────────────
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero image with gradient and title overlay ──────────
                _HeroBanner(
                  course: course,
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                  onBack: () => context.pop(),
                ),
                // ── Main content ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(24),
                      _buildHeaderActionRow(context, course, colorScheme, textTheme),
                      const Gap(32),
                      _buildDescription(course, colorScheme, textTheme),
                      const Gap(32),
                      if (course.whatYouWillLearn.isNotEmpty)
                        _buildSection(
                          'What you will learn',
                          _buildLearningPoints(course, colorScheme, textTheme),
                          textTheme,
                        ),
                      const Gap(32),
                      if (course.requirements.isNotEmpty)
                        _buildSection(
                          'Requirements',
                          _buildRequirementsList(course, colorScheme, textTheme),
                          textTheme,
                        ),
                      const Gap(32),
                      if (course.learningMaterials.isNotEmpty)
                        _buildSection(
                          'This course includes',
                          _buildMaterialsGrid(course, colorScheme, textTheme),
                          textTheme,
                        ),
                      const Gap(120),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ── Floating back button pinned over the hero ────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: _FloatingBackButton(onTap: () => context.pop()),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderActionRow(
    BuildContext context,
    DiscoveryCourseModel course,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final priceStr = course.price <= 0
        ? 'Free'
        : '${course.currency} ${course.price.toStringAsFixed(0)}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Course Price',
                style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              Text(
                priceStr,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (isEnrolled) {
                      context.push('/platform/$tenantId/course/$courseId/overview');
                    } else {
                      ref.read(enrollmentControllerProvider.notifier).handleEnrollment(course);
                    }
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(
                    isEnrolled ? 'Continue' : (course.price <= 0 ? 'Enroll Now' : 'Buy Now'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(DiscoveryCourseModel course, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About this course', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        Text(
          course.description ?? 'No description available for this course.',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Widget content, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(12),
        content,
      ],
    );
  }

  Widget _buildLearningPoints(DiscoveryCourseModel course, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: course.whatYouWillLearn.map((point) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle_rounded, size: 18, color: Colors.green.shade600),
            const Gap(10),
            Expanded(child: Text(point, style: textTheme.bodyMedium)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildRequirementsList(DiscoveryCourseModel course, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: course.requirements.map((req) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.circle, size: 6, color: colorScheme.onSurfaceVariant),
            const Gap(12),
            Expanded(child: Text(req, style: textTheme.bodyMedium)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildMaterialsGrid(DiscoveryCourseModel course, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      children: course.learningMaterials.map((material) {
        final iconData = _getMaterialIcon(material);
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              HugeIcon(icon: iconData, color: colorScheme.primary, size: 24),
              const Gap(16),
              Expanded(
                child: Text(
                  material,
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  dynamic _getMaterialIcon(String material) {
    final m = material.toLowerCase();
    if (m.contains('video') || m.contains('lesson')) return HugeIcons.strokeRoundedAudioBook01;
    if (m.contains('pdf') || m.contains('resource') || m.contains('note')) return HugeIcons.strokeRoundedFolderLibrary;
    if (m.contains('quiz') || m.contains('exam') || m.contains('test')) return HugeIcons.strokeRoundedDiscoverCircle;
    if (m.contains('certificate')) return HugeIcons.strokeRoundedUser;
    if (m.contains('lifetime') || m.contains('access')) return HugeIcons.strokeRoundedHome03;
    return HugeIcons.strokeRoundedFolderLibrary;
  }
}

/// Hero image banner with gradient and course title.
///
/// Uses [CachedNetworkImage] which shares an in-memory cache with the
/// course cards — so if the user tapped a card, the thumbnail is already
/// in cache and renders instantly with zero flicker.
class _HeroBanner extends StatelessWidget {
  final DiscoveryCourseModel course;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onBack;

  const _HeroBanner({
    required this.course,
    required this.colorScheme,
    required this.textTheme,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final hasValidThumbnail =
        course.thumbnailUrl != null && course.thumbnailUrl!.isNotEmpty;

    return SizedBox(
      height: _kHeroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Thumbnail image (loads from cache instantly if card was shown) ─
          if (hasValidThumbnail)
            CachedNetworkImage(
              imageUrl: course.thumbnailUrl!,
              fit: BoxFit.cover,
              // CachedNetworkImage returns the cached image synchronously on
              // the next frame — no flicker when navigating from the card.
              fadeInDuration: Duration.zero,
              placeholderFadeInDuration: Duration.zero,
              placeholder: (context, url) => Container(
                color: colorScheme.surfaceContainerHighest,
              ),
              errorWidget: (context, url, error) => Container(
                color: colorScheme.surfaceContainerHighest,
                child: Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedImage01,
                    color: colorScheme.onSurfaceVariant,
                    size: 40,
                  ),
                ),
              ),
            )
          else
            Container(
              color: colorScheme.surfaceContainerHighest,
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedImage01,
                  color: colorScheme.onSurfaceVariant,
                  size: 40,
                ),
              ),
            ),

          // ── Gradient overlay for readability ───────────────────────────
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black26, Colors.transparent, Colors.transparent, Colors.black54],
                stops: [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),

          // ── Course title and badges at the bottom ─────────────────────
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        course.courseCategory.isNotEmpty ? course.courseCategory.first : 'General',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (course.courseType != null) ...[
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          course.courseType!.toUpperCase(),
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Gap(8),
                Text(
                  course.title,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small circular back button floating over the hero banner.
class _FloatingBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FloatingBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
