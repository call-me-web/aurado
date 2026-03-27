import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:aurado/core/theme/theme_config.dart';
import 'package:aurado/core/performance/performance_provider.dart';
import 'package:aurado/core/presentation/components/aurado_button_cta.dart';


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

class _CourseDetailView extends ConsumerStatefulWidget {
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
  ConsumerState<_CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends ConsumerState<_CourseDetailView> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // ── Main Content Scrolling Area ────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _CourseHero(course: widget.course),
                    
                    // Title section with premium badge
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'PREMIUM COURSE',
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const Gap(12),
                          Text(
                            widget.course.title.trim(),
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: colorScheme.onSurface,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
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
                    const Gap(120), // More space for bottom bar
                  ],
                ),
              ),
            ],
          ),

          // ── Pinned Back Button ─────────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: Material(
              color: Colors.black.withValues(alpha: 0.3),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),

          // ── Glassmorphic Floating Action Bar ────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: _buildFloatingActionBar(context, colorScheme, textTheme),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionBar(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    final performance = ref.watch(performanceProvider);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 1. Background layer (Glass or Solid)
          Positioned.fill(
            child: performance.enableGlassmorphism
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withAlpha((0.85 * 255).toInt()),
                        border: Border.all(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      border: Border.all(
                        color: colorScheme.onSurface.withValues(alpha: 0.1),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
          ),
          
          // 2. Foreground Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Price Info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COURSE PRICE',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w800,
                          fontSize: 9,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        widget.course.price <= 0 ? 'Free' : '৳${widget.course.price.toStringAsFixed(0)}',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colorScheme.primary,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Add to Cart Icon Button
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: colorScheme.onSurface, size: 22),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    // TODO: Implement cart functionality
                  },
                ),
                const Gap(16),
                
                // Enroll Now Button - adaptive width with constraints
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 120, maxWidth: 140),
                  child: AuradoButton_cta(
                    text: widget.isEnrolled ? 'Continue' : 'Enroll Now',
                    onPressed: () {
                      if (widget.isEnrolled) {
                        context.push('/platform/${widget.tenantId}/course/${widget.courseId}/overview');
                      } else {
                        ref.read(enrollmentControllerProvider.notifier).handleEnrollment(widget.course);
                      }
                    },
                    isLoading: widget.isLoading,
                    color: colorScheme.primary,
                    textColor: Colors.white,
                    borderRadius: 14,
                    size: AuradoButtonSize.medium,
                  ),
                ),
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
          ],
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
