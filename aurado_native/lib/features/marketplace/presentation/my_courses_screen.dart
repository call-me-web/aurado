import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:aurado/features/marketplace/presentation/widgets/marketplace_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../shared/widgets/performance_blur.dart';
import '../../../core/performance/performance_provider.dart';

class MyCoursesScreen extends ConsumerStatefulWidget {
  const MyCoursesScreen({super.key});

  @override
  ConsumerState<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends ConsumerState<MyCoursesScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    debugPrint('MyCoursesScreen: build called');
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final performance = ref.watch(performanceProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: performance.enableGlassmorphism
            ? colorScheme.surface.withValues(alpha: 0.05)
            : colorScheme.surface,
        elevation: 0,
        flexibleSpace: PerformanceBlur(
          child: Container(color: Colors.transparent),
        ),
        title: Text(
          'My Courses',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(enrolledCoursesProvider.notifier).refresh(),
        child: enrolledCoursesAsync.when(
          data: (courses) {
            if (courses.isEmpty) {
              return _buildEmptyState(context, colorScheme, textTheme);
            }
            return ListView.separated(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 70,
                left: 20,
                right: 20,
                bottom: 100,
              ),
              itemCount: courses.length,
              separatorBuilder: (context, index) => const Gap(20),
              itemBuilder: (context, index) {
                final isExpanded = _expandedIndex == index;
                return MarketplaceCourseCard(
                  course: courses[index],
                  isExpanded: isExpanded,
                  onToggleExpanded: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedAlertCircle,
                  size: 48,
                  color: Colors.red,
                ),
                const Gap(16),
                Text('Failed to load courses', style: textTheme.titleMedium),
                const Gap(8),
                Text(e.toString(), style: textTheme.bodySmall),
                const Gap(24),
                ElevatedButton(
                  onPressed: () => ref.invalidate(enrolledCoursesProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedTask01,
              size: 64,
              color: colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          const Gap(24),
          Text(
            'No courses yet',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Explore our marketplace to find courses and start learning today!',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const Gap(32),
          // Link to Discover Courses would be nice, but we are inside the Shell
        ],
      ),
    );
  }
}
