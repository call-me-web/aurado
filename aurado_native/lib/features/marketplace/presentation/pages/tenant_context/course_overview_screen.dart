import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../marketplace/providers/marketplace_provider.dart';

/// Overview screen for enrolled users.
///
/// Uses the same sliver-free [Scaffold] → [Column] → [Expanded]+[ListView]
/// layout pattern as [CourseDetailScreen] to avoid [RenderViewportBase] crashes.
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
        final course = courses.where((c) => c.id == courseId).firstOrNull;
        if (course == null) {
          return const Scaffold(
            body: Center(child: Text('Course not found')),
          );
        }

        final hasValidUrl =
            course.thumbnailUrl != null && course.thumbnailUrl!.isNotEmpty;

        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Fixed-height cover image ───────────────────────────────
              SizedBox(
                height: 200 + MediaQuery.of(context).padding.top,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    hasValidUrl
                        ? CachedNetworkImage(
                            imageUrl: course.thumbnailUrl!,
                            fit: BoxFit.cover,
                            fadeInDuration: Duration.zero,
                            placeholderFadeInDuration: Duration.zero,
                            placeholder: (context, url) => ColoredBox(
                              color: colorScheme.surfaceContainerHighest,
                            ),
                            errorWidget: (context, url, error) => ColoredBox(
                              color: colorScheme.surfaceContainerHighest,
                            ),
                          )
                        : ColoredBox(color: colorScheme.surfaceContainerHighest),
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
                        mainAxisSize: MainAxisSize.min,
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

              // ── Scrollable body ───────────────────────────────────────
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  children: [
                    // Welcome
                    Text(
                      'Welcome back!',
                      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    const Gap(8),
                    Text(
                      'You are doing great. Continue where you left off to reach your goals faster.',
                      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const Gap(32),

                    // Progress card
                    Container(
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
                              _MiniStat('12 / 24 Lessons', colorScheme, textTheme),
                              const Gap(16),
                              _MiniStat('2 Tasks pending', colorScheme, textTheme),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(32),

                    // Quick actions
                    Text(
                      'Quick Actions',
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionTile(
                            label: 'Resume Learning',
                            icon: HugeIcons.strokeRoundedPlayCircle,
                            color: Colors.orange,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: _ActionTile(
                            label: 'Discussion Board',
                            icon: HugeIcons.strokeRoundedMessage01,
                            color: Colors.purple,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),

                    // Instructors
                    Text(
                      'Your Instructors',
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100&auto=format&fit=crop',
                          ),
                        ),
                        const Gap(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. Sarah Chen',
                              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Lead Instructor',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _MiniStat(this.label, this.colorScheme, this.textTheme);

  @override
  Widget build(BuildContext context) {
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
}

class _ActionTile extends StatelessWidget {
  final String label;
  final dynamic icon;
  final Color color;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _ActionTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(label, style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
