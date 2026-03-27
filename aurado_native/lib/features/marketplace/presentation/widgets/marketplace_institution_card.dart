import 'package:aurado/core/theme/theme_config.dart';
import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Card for displaying an institution in the mixed search results feed.
///
/// Shows: cover banner, circular logo overlay, institution name, and rating.
/// Tapping navigates to the institution's platform page.
class MarketplaceInstitutionCard extends StatelessWidget {
  final TenantModel institution;

  const MarketplaceInstitutionCard({
    super.key,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/platform/${institution.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header (Cover + Overlapping Logo) ──────────────────────────
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover Banner
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: (institution.coverUrl != null &&
                          institution.coverUrl!.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl: institution.coverUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          ),
                          errorWidget: (context, url, err) => _buildCoverPlaceholder(colorScheme),
                        )
                      : _buildCoverPlaceholder(colorScheme),
                ),
                // Logo (Overlapping)
                Positioned(
                  bottom: -20,
                  left: 16,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.surface,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: (institution.logoUrl != null &&
                              institution.logoUrl!.isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl: institution.logoUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: colorScheme.surfaceContainerHighest,
                              ),
                              errorWidget: (context, url, err) => Icon(
                                Icons.business,
                                size: 24,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            )
                          : Icon(
                              Icons.business,
                              size: 24,
                              color: colorScheme.onSurfaceVariant,
                            ),
                    ),
                  ),
                ),
              ],
            ),

            const Gap(24), // Space for overlapping logo

            // ── Info Content ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          institution.name,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: ThemeConfig.weightExtraBold,
                            color: colorScheme.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                            const Gap(4),
                            Text(
                              '4.9', // TODO: wire to real rating
                              style: textTheme.bodySmall?.copyWith(
                                fontWeight: ThemeConfig.weightBold,
                                color: colorScheme.onSurface,
                                fontSize: ThemeConfig.fontSizeXs,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              '•',
                              style: TextStyle(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
                            ),
                            const Gap(8),
                            Text(
                              'Top Institution',
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.secondary,
                                fontWeight: ThemeConfig.weightSemiBold,
                                fontSize: ThemeConfig.fontSizeXs,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // CTA Link
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(ThemeConfig.radiusFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: ThemeConfig.weightBold,
                          ),
                        ),
                        const Gap(2),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: colorScheme.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverPlaceholder(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.business_outlined,
          size: 36,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
