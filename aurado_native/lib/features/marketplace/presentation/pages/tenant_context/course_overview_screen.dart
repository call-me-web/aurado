import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../marketplace/providers/marketplace_provider.dart';

class CourseOverviewScreen extends ConsumerWidget {
  final String tenantId;
  final String courseId;

  const CourseOverviewScreen({
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
              _buildAppBar(course, colorScheme, textTheme),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeSection(course, textTheme, colorScheme),
                      const Gap(32),
                      _buildProgressCard(colorScheme, textTheme),
                      const Gap(32),
                      _buildActionsGrid(context, colorScheme, textTheme),
                      const Gap(32),
                      _buildInstructorsSection(textTheme, colorScheme),
                      const Gap(100), // Padding for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildAppBar(dynamic course, ColorScheme colorScheme, TextTheme textTheme) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      automaticallyImplyLeading: false, // Shell handles home button
      backgroundColor: colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (course.thumbnailUrl != null && course.thumbnailUrl!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: course.thumbnailUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const SizedBox(),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'ENROLLED',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    course.title,
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(dynamic course, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back!',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const Gap(8),
        Text(
          'You are doing great. Continue where you left off to reach your goals faster.',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildProgressCard(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Overall Progress', style: textTheme.labelLarge),
                  Text(
                    '45%',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const HugeIcon(
                icon: HugeIcons.strokeRoundedAnalytics01,
                color: Colors.blue,
                size: 40,
              ),
            ],
          ),
          const Gap(20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.45,
              minHeight: 12,
              backgroundColor: colorScheme.surface,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              _buildMiniStat('12 / 24 Lessons', colorScheme, textTheme),
              const Gap(16),
              _buildMiniStat('2 Tasks pending', colorScheme, textTheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActionsGrid(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _buildActionItem(
                'Resume Learning',
                HugeIcons.strokeRoundedPlayCircle,
                Colors.orange,
                colorScheme,
                textTheme,
              ),
            ),
            const Gap(16),
            Expanded(
              child: _buildActionItem(
                'Discussion Board',
                HugeIcons.strokeRoundedMessage01,
                Colors.purple,
                colorScheme,
                textTheme,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem(String title, dynamic icon, Color color, ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: color, size: 28),
          const Gap(12),
          Text(
            title,
            style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorsSection(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Instructors', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(16),
        Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop'),
            ),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. Sarah Chen', style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text('Lead Instructor', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
