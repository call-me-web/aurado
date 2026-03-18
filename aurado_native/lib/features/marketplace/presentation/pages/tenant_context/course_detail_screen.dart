import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return coursesAsync.when(
      data: (courses) {
        final course = courses.firstWhere(
          (c) => c.id == courseId,
          orElse: () => throw Exception('Course not found'),
        );

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, course, colorScheme),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderInfo(course, colorScheme, textTheme),
                      const Gap(24),
                      _buildDescription(course, colorScheme, textTheme),
                      const Gap(24),
                      if (course.whatYouWillLearn.isNotEmpty)
                        _buildSection('What you will learn', _buildLearningPoints(course, colorScheme, textTheme), textTheme),
                      const Gap(24),
                      if (course.requirements.isNotEmpty)
                        _buildSection('Requirements', _buildRequirementsList(course, colorScheme, textTheme), textTheme),
                      const Gap(24),
                      if (course.learningMaterials.isNotEmpty)
                        _buildSection('Includes', _buildMaterialsGrid(course, colorScheme, textTheme), textTheme),
                      const Gap(100), // Space for bottom action bar
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: _buildBottomActionBar(context, course, colorScheme, textTheme),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, DiscoveryCourseModel course, ColorScheme colorScheme) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: colorScheme.surface,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.3),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: course.thumbnailUrl != null
            ? CachedNetworkImage(
                imageUrl: course.thumbnailUrl!,
                fit: BoxFit.cover,
              )
            : Container(color: colorScheme.surfaceContainerHighest),
      ),
    );
  }

  Widget _buildHeaderInfo(DiscoveryCourseModel course, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                course.courseCategory.isNotEmpty ? course.courseCategory.first : 'General',
                style: textTheme.labelSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(8),
            if (course.courseType != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  course.courseType!.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(color: colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        const Gap(12),
        Text(
          course.title,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        const Gap(16),
        Row(
          children: [
            _buildMetaInfo(Icons.bar_chart_rounded, course.level ?? 'All Levels', textTheme, colorScheme),
            const Gap(16),
            _buildMetaInfo(Icons.access_time_rounded, course.duration ?? 'Self-paced', textTheme, colorScheme),
            const Gap(16),
            _buildMetaInfo(Icons.language_rounded, course.language ?? 'English', textTheme, colorScheme),
          ],
        ),
      ],
    );
  }

  Widget _buildMetaInfo(IconData icon, String label, TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
        const Gap(6),
        Text(label, style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500)),
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
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: course.learningMaterials.map((material) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_circle_outline_rounded, size: 16, color: colorScheme.onSurfaceVariant),
            const Gap(6),
            Text(material, style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildBottomActionBar(BuildContext context, DiscoveryCourseModel course, ColorScheme colorScheme, TextTheme textTheme) {
    final priceStr = course.price <= 0 ? 'Free' : '${course.currency} ${course.price.toStringAsFixed(0)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price', style: textTheme.bodySmall),
                Text(
                  priceStr,
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: colorScheme.primary),
                ),
              ],
            ),
            const Gap(24),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement enrollment/purchase logic
                  context.push('/platform/$tenantId/course/${course.id}/curriculum');
                },
                child: const Text('Enroll Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
