import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:aurado/core/theme/theme_config.dart';
import 'package:aurado/core/presentation/components/aurado_button_cta.dart';

class MarketplaceCourseCard extends ConsumerWidget {
  final DiscoveryCourseModel course;
  final VoidCallback? onTap;

  const MarketplaceCourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  String _formatPrice() {
    if (course.price <= 0) return 'Free';
    final hasDecimals =
        course.price.truncateToDouble() != course.price;
    final priceStr = course.price.toStringAsFixed(hasDecimals ? 2 : 0);
    return '${course.currency} $priceStr';
  }

  IconData _getCourseTypeIcon(String type) {
    if (type.toLowerCase().contains('live')) {
      return Icons.videocam_outlined;
    }
    return Icons.ondemand_video_rounded;
  }

  void _handleTap(BuildContext context, WidgetRef ref) {
    if (onTap != null) {
      onTap!();
      return;
    }
    final enrolledAsync = ref.read(enrolledCoursesProvider);
    if (enrolledAsync.isLoading) {
      context.push('/platform/${course.tenantId}/course/${course.id}');
    } else {
      final isEnrolled =
          enrolledAsync.asData?.value.any((c) => c.id == course.id) ?? false;
      if (isEnrolled) {
        context.push('/platform/${course.tenantId}/course/${course.id}/overview');
      } else {
        context.push('/app/discover-courses/details/${course.tenantId}/${course.id}');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => _handleTap(context, ref),
      child: Container(
        width: 320, // Slightly narrower for better grid presentation
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThumbnailArea(colorScheme, textTheme),
              _buildMainContent(context, ref, colorScheme, textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailArea(ColorScheme colorScheme, TextTheme textTheme) {
    final isDark = colorScheme.brightness == Brightness.dark;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: (course.thumbnailUrl != null && course.thumbnailUrl!.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: course.thumbnailUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: colorScheme.surfaceContainerHighest,
                    highlightColor: colorScheme.surface,
                    child: Container(color: colorScheme.surface),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedImage01,
                        color: colorScheme.onSurfaceVariant,
                        size: 32,
                      ),
                    ),
                  ),
                )
              : Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedImage01,
                      color: colorScheme.onSurfaceVariant,
                      size: 32,
                    ),
                  ),
                ),
        ),
        // Course Category Badge
        if (course.courseCategory.isNotEmpty)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(ThemeConfig.radiusSm),
              ),
              child: Text(
                course.courseCategory.first,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        // Course Type Badge
        if (course.courseType != null)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.6)
                    : Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(ThemeConfig.radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getCourseTypeIcon(course.courseType!),
                    color: colorScheme.primary,
                    size: 14,
                  ),
                  const Gap(4),
                  Text(
                    course.courseType!.toUpperCase(),
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context, WidgetRef ref, ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tenant Info
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
                ),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  backgroundImage: (course.tenantLogoUrl != null && course.tenantLogoUrl!.isNotEmpty)
                      ? CachedNetworkImageProvider(course.tenantLogoUrl!)
                      : null,
                  child: (course.tenantLogoUrl == null || course.tenantLogoUrl!.isEmpty)
                      ? Icon(
                          Icons.business,
                          size: 10,
                          color: colorScheme.onSurfaceVariant,
                        )
                      : null,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  course.tenantName ?? 'Institution',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Rating Star UI
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                  const Gap(4),
                  Text(
                    '4.8', // Placeholder logic for now
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          // Title
          Text(
            course.title,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.3,
              letterSpacing: -0.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(12),
          // Metadata Row
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              if (course.level != null)
                _buildMetaItem(Icons.bar_chart_rounded, course.level!, colorScheme, textTheme),
              if (course.duration != null)
                _buildMetaItem(Icons.access_time_rounded, course.duration!, colorScheme, textTheme),
              if (course.language != null)
                _buildMetaItem(Icons.language_rounded, course.language!, colorScheme, textTheme),
            ],
          ),
          const Gap(16),
          // Price and View Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _formatPrice(),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              AuradoButton_cta(
                text: 'View',
                onPressed: () => _handleTap(context, ref),
                size: AuradoButtonSize.small,
                width: 80,
                borderRadius: ThemeConfig.radiusSm,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String label, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7)),
        const Gap(4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
