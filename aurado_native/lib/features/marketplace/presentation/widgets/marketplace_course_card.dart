import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:go_router/go_router.dart';

class MarketplaceCourseCard extends StatefulWidget {
  final DiscoveryCourseModel course;
  final VoidCallback? onTap;
  final bool isExpanded;
  final VoidCallback? onToggleExpanded;

  const MarketplaceCourseCard({
    super.key,
    required this.course,
    this.onTap,
    this.isExpanded = false,
    this.onToggleExpanded,
  });

  @override
  State<MarketplaceCourseCard> createState() => _MarketplaceCourseCardState();
}

class _MarketplaceCourseCardState extends State<MarketplaceCourseCard> {
  String _formatPrice() {
    if (widget.course.price <= 0) return 'Free';
    final hasDecimals =
        widget.course.price.truncateToDouble() != widget.course.price;
    final priceStr = widget.course.price.toStringAsFixed(hasDecimals ? 2 : 0);
    return '${widget.course.currency} $priceStr';
  }

  IconData _getCourseTypeIcon(String type) {
    if (type.toLowerCase().contains('live')) {
      return Icons.videocam_outlined;
    }
    return Icons.ondemand_video_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () {
        context.push(
          '/platform/${widget.course.tenantId}/course/${widget.course.id}',
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 340,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(9.0),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 2, // Softer border size
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThumbnailArea(colorScheme, textTheme),
              _buildMainContent(colorScheme, textTheme),
              _buildExpandableContent(theme, colorScheme, textTheme),
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
          child: widget.course.thumbnailUrl != null
              ? CachedNetworkImage(
                  imageUrl: widget.course.thumbnailUrl!,
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
        // Course Category Badge (Top Left)
        if (widget.course.courseCategory.isNotEmpty)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.course.courseCategory.first,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        // Course Type Badge (Bottom Right)
        if (widget.course.courseType != null)
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.85)
                    : Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getCourseTypeIcon(widget.course.courseType!),
                    color: colorScheme.primary,
                    size: 14,
                  ),
                  const Gap(4),
                  Text(
                    widget.course.courseType!.toUpperCase(),
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

  Widget _buildMainContent(ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tenant Info
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  backgroundImage: widget.course.tenantLogoUrl != null
                      ? CachedNetworkImageProvider(widget.course.tenantLogoUrl!)
                      : null,
                  child: widget.course.tenantLogoUrl == null
                      ? Icon(
                          Icons.business,
                          size: 12,
                          color: colorScheme.onSurfaceVariant,
                        )
                      : null,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  widget.course.tenantName ?? 'Institution',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(10),
          // Title
          Text(
            widget.course.title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(14),
          // Metadata Row
          Wrap(
            spacing: 16,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (widget.course.level != null)
                _buildMetaItem(
                  Icons.bar_chart_rounded,
                  widget.course.level!,
                  colorScheme,
                  textTheme,
                ),
              if (widget.course.duration != null)
                _buildMetaItem(
                  Icons.access_time_rounded,
                  widget.course.duration!,
                  colorScheme,
                  textTheme,
                ),
              if (widget.course.language != null)
                _buildMetaItem(
                  Icons.language_rounded,
                  widget.course.language!,
                  colorScheme,
                  textTheme,
                ),
            ],
          ),
          const Gap(16),
          // Price and Expand Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    _formatPrice(),
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: widget.onToggleExpanded,
                icon: AnimatedRotation(
                  turns: widget.isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colorScheme.primary,
                    size:
                        28, // slightly larger, visually more impactful since there's no background box anymore
                  ),
                ),
                style: IconButton.styleFrom(padding: const EdgeInsets.all(8)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(
    IconData icon,
    String label,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
        const Gap(6),
        Flexible(
          child: Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableContent(
    ThemeData theme,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return ClipRect(
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        heightFactor: widget.isExpanded ? 1.0 : 0.0,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.brightness == Brightness.dark
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            border: Border(top: BorderSide(color: theme.dividerColor)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.course.description != null &&
                  widget.course.description!.isNotEmpty) ...[
                _buildSectionTitle('About this course', textTheme),
                const Gap(8),
                Text(
                  widget.course.description!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const Gap(20),
              ],

              if (widget.course.whatYouWillLearn.isNotEmpty) ...[
                _buildSectionTitle('What you will learn', textTheme),
                const Gap(10),
                ...widget.course.whatYouWillLearn
                    .take(4)
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: Colors.green.shade600,
                            ),
                            const Gap(10),
                            Expanded(
                              child: Text(
                                item,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                const Gap(10),
              ],

              if (widget.course.requirements.isNotEmpty) ...[
                _buildSectionTitle('Requirements', textTheme),
                const Gap(10),
                ...widget.course.requirements
                    .take(3)
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Icon(
                                Icons.circle,
                                size: 6,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Gap(12),
                            Expanded(
                              child: Text(
                                item,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                const Gap(10),
              ],

              if (widget.course.learningMaterials.isNotEmpty) ...[
                _buildSectionTitle('Includes', textTheme),
                const Gap(10),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: widget.course.learningMaterials.map((material) {
                    final lower = material.toLowerCase();
                    IconData mIcon =
                        Icons.library_books_rounded; // Default fallback

                    if (lower.contains('video') || lower.contains('mp4')) {
                      mIcon = Icons.play_circle_outline_rounded;
                    } else if (lower.contains('pdf') ||
                        lower.contains('reading')) {
                      mIcon = Icons.picture_as_pdf_outlined;
                    } else if (lower.contains('quiz') ||
                        lower.contains('exam')) {
                      mIcon = Icons.quiz_outlined;
                    } else if (lower.contains('certificate')) {
                      mIcon = Icons.emoji_events_outlined;
                    } else if (lower.contains('audio') ||
                        lower.contains('podcast')) {
                      mIcon = Icons.headphones_outlined;
                    } else if (lower.contains('download')) {
                      mIcon = Icons.file_download_outlined;
                    }

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          mIcon,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const Gap(6),
                        Flexible(
                          child: Text(
                            material,
                            style: textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const Gap(24),
              ],

              // Call to Action
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onTap ?? () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Explore Course'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Text(
      title,
      style: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
    );
  }
}
