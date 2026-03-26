import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:aurado/core/theme/theme_config.dart';


/// Course detail screen for non-enrolled users.

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

    // React to enrollment/payment outcomes.
    ref.listen(enrollmentControllerProvider, (previous, next) async {
      final urlOrStatus = next.asData?.value;
      if (urlOrStatus == null) return;
      if (urlOrStatus == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully enrolled!')),
        );
        context.pushReplacement('/platform/$tenantId/course/$courseId/overview');
        return;
      }
      final uri = Uri.tryParse(urlOrStatus);
      if (uri != null && (uri.hasScheme || urlOrStatus.startsWith('http'))) {
        try {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open payment page: $e')),
            );
          }
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
                mainAxisSize: MainAxisSize.min,
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

        return _CourseDetailView(
          course: course,
          isLoading: isLoading,
          isEnrolled: isEnrolled,
          tenantId: tenantId,
          courseId: courseId,
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _CourseDetailView extends StatefulWidget {
  final DiscoveryCourseModel course;
  final bool isLoading;
  final bool isEnrolled;
  final String tenantId;
  final String courseId;

  const _CourseDetailView({
    required this.course,
    required this.isLoading,
    required this.isEnrolled,
    required this.tenantId,
    required this.courseId,
  });

  @override
  State<_CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<_CourseDetailView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CourseHero(course: widget.course),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    ThemeConfig.spacingLg,
                    ThemeConfig.spacingLg,
                    ThemeConfig.spacingLg,
                    0,
                  ),

                  child: Text(
                    widget.course.title.trim(),
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900, // Even bolder for premium look
                      fontSize: 24,
                      color: colorScheme.onSurface,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),

                const Gap(ThemeConfig.spacingSm),
                if (widget.course.courseCategory.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "This course for ${widget.course.courseCategory.join(', ')}",
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const Gap(ThemeConfig.spacingMd),
                const Divider(),

                _AcademyRow(
                  course: widget.course,
                  isLoading: widget.isLoading,
                  isEnrolled: widget.isEnrolled,
                  tenantId: widget.tenantId,
                  courseId: widget.courseId,
                ),
                const Divider(),
                const Gap(8),
                _DetailTabs(
                  selectedIndex: _selectedTab,
                  onSelected: (index) => setState(() => _selectedTab = index),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildTabContent(_selectedTab, colorScheme, textTheme),
                ),
                const Gap(80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(int index, ColorScheme colorScheme, TextTheme textTheme) {
    switch (index) {
      case 0: // Description
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.course.description ?? 'No description available for this course.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        );

      case 1: // Information
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.course.whatYouWillLearn.isNotEmpty) ...[
              _SectionBlock(
                title: 'What you will learn',
                child: _BulletList(
                  items: widget.course.whatYouWillLearn,
                  icon: Icons.check_circle_rounded,
                  iconColor: Colors.green.shade600,
                ),
              ),
              const Gap(32),
            ],
            if (widget.course.requirements.isNotEmpty) ...[
              _SectionBlock(
                title: 'Requirements',
                child: _BulletList(
                  items: widget.course.requirements,
                  icon: Icons.circle,
                  iconColor: colorScheme.onSurfaceVariant,
                  iconSize: 6,
                ),
              ),
              const Gap(32),
            ],
            if (widget.course.learningMaterials.isNotEmpty) ...[
              _SectionBlock(
                title: 'This course includes',
                child: _MaterialsCard(
                  materials: widget.course.learningMaterials,
                ),
              ),
            ],
          ],
        );

      case 2: // Review
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text('No reviews yet.'),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}


class _CourseHero extends StatelessWidget {
  final DiscoveryCourseModel course;

  const _CourseHero({required this.course});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final topPadding = MediaQuery.of(context).padding.top;
    final hasValidUrl = course.thumbnailUrl != null && course.thumbnailUrl!.isNotEmpty;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1280 / 720,
          child: hasValidUrl
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
                    child: const Center(
                      child: Icon(Icons.image_outlined, color: Colors.grey, size: 40),
                    ),
                  ),
                )
              : ColoredBox(
                  color: colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: Icon(Icons.image_outlined, color: Colors.grey, size: 40),
                  ),
                ),
        ),
        // Gradient for back button visibility
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
                stops: const [0.0, 0.4],
              ),
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: topPadding + ThemeConfig.spacingSm,
          left: ThemeConfig.spacingSm + 4,
          child: Material(
            color: Colors.black.withValues(alpha: 0.3),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => context.pop(),
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(ThemeConfig.spacingSm),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),

        // Status Badge (e.g., "Recorded")
        Positioned(
          top: topPadding + ThemeConfig.spacingMd,
          right: ThemeConfig.spacingLg,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingMd,
              vertical: ThemeConfig.spacingXs + 2,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(ThemeConfig.radiusSm),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              course.courseType?.toUpperCase() ?? 'RECORDED',
              style: TextStyle(
                color: colorScheme.primary, // Using primary theme color
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),

          ),
        ),

      ],
    );
  }
}

class _AcademyRow extends ConsumerWidget {
  final DiscoveryCourseModel course;
  final bool isLoading;
  final bool isEnrolled;
  final String tenantId;
  final String courseId;

  const _AcademyRow({
    required this.course,
    required this.isLoading,
    required this.isEnrolled,
    required this.tenantId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: () => context.push('/platform/${course.tenantId}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingLg,
          vertical: ThemeConfig.spacingMd,
        ),
        child: Row(
          children: [
            // Academy Logo
            CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.primaryContainer,
              backgroundImage: course.tenantLogoUrl != null
                  ? CachedNetworkImageProvider(course.tenantLogoUrl!)
                  : null,
              child: course.tenantLogoUrl == null
                  ? Icon(Icons.school, color: colorScheme.primary, size: 20)
                  : null,
            ),
            const Gap(ThemeConfig.spacingMd),

            // Academy Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    course.tenantName ?? 'Academy Name',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'View Profile',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            // Enroll Button
            _EnrollButton(
              course: course,
              isLoading: isLoading,
              isEnrolled: isEnrolled,
              tenantId: tenantId,
              courseId: courseId,
            ),
          ],
        ),
      ),
    );

  }
}

class _EnrollButton extends ConsumerWidget {
  final DiscoveryCourseModel course;
  final bool isLoading;
  final bool isEnrolled;
  final String tenantId;
  final String courseId;

  const _EnrollButton({
    required this.course,
    required this.isLoading,
    required this.isEnrolled,
    required this.tenantId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
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
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: ThemeConfig.spacingLg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusMd),
        ),
        elevation: 2,
        shadowColor: colorScheme.primary.withValues(alpha: 0.3),
      ),
      child: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : Text(
              isEnrolled ? 'Continue' : 'Enroll now',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
    );
  }

}

class _DetailTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _DetailTabs({
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Description', 'Information', 'Review'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ThemeConfig.spacingLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return _TabItem(
            label: tabs[index],
            isSelected: isSelected,
            onTap: () => onSelected(index),
          );
        }),
      ),
    );

  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ThemeConfig.radiusSm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: ThemeConfig.spacingSm,
          horizontal: ThemeConfig.spacingSm,
        ),
        child: Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );


  }
}

class _SectionBlock extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionBlock({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
        const Gap(ThemeConfig.spacingMd),
        child,
      ],
    );
  }

}

class _BulletList extends StatelessWidget {
  final List<String> items;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  const _BulletList({
    required this.items,
    required this.icon,
    required this.iconColor,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: ThemeConfig.spacingSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: iconSize < 10 ? 6 : 4),
                      child: Icon(icon, size: iconSize, color: iconColor),
                    ),
                    const Gap(ThemeConfig.spacingMd),
                    Expanded(
                      child: Text(
                        item, 
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),

    );
  }
}

class _MaterialsCard extends StatelessWidget {
  final List<String> materials;

  const _MaterialsCard({required this.materials});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: materials.map((material) {
        final IconData icon = _getMaterialIcon(material);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6), size: 20),
              const Gap(12),
              Expanded(
                child: Text(
                  material,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );

  }

  IconData _getMaterialIcon(String material) {
    final String m = material.toLowerCase();
    if (m.contains('video') || m.contains('lesson')) return Icons.play_circle_outline;
    if (m.contains('pdf') || m.contains('resource') || m.contains('note')) return Icons.description_outlined;
    if (m.contains('quiz') || m.contains('exam') || m.contains('test')) return Icons.quiz_outlined;
    if (m.contains('certificate')) return Icons.card_membership_outlined;
    if (m.contains('lifetime') || m.contains('access')) return Icons.access_time_outlined;
    return Icons.article_outlined;
  }
}
