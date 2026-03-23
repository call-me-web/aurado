import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:aurado/features/marketplace/presentation/widgets/marketplace_course_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../shared/widgets/performance_blur.dart';
import '../../../core/performance/performance_provider.dart';

class DiscoverCoursesScreen extends ConsumerStatefulWidget {
  const DiscoverCoursesScreen({super.key});

  @override
  ConsumerState<DiscoverCoursesScreen> createState() =>
      _DiscoverCoursesScreenState();
}

class _DiscoverCoursesScreenState extends ConsumerState<DiscoverCoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tenantsAsync = ref.watch(marketplaceTenantsProvider);
    final coursesAsync = ref.watch(discoveryCoursesProvider());

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final performance = ref.watch(performanceProvider);

    final popularCategoriesAsync = ref.watch(popularCategoriesProvider);

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
        title: Row(
          children: [
            Text(
              'Discover',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Gap(16),
            Expanded(
              child: TapRegion(
                onTapOutside: (_) {
                  _searchFocusNode.unfocus();
                },
                child: SizedBox(
                  height: 48, // slightly more room for layout stability
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    style: textTheme.bodyMedium,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search....',
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: IconButton(
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedSearch01,
                            size: 22,
                            color: _searchController.text.isNotEmpty
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant.withValues(
                                    alpha: 0.5,
                                  ),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            _searchFocusNode.unfocus();
                            if (_searchController.text.isNotEmpty) {
                              ref
                                  .read(discoveryCoursesProvider().notifier)
                                  .search(_searchController.text);
                            }
                          },
                        ),
                      ),
                      filled: true,
                      fillColor: colorScheme.brightness == Brightness.light
                          ? Colors.white
                          : colorScheme.surfaceContainerHighest,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                    ),
                    onChanged: (val) => setState(() {}),
                    onSubmitted: (value) {
                      _searchFocusNode.unfocus();
                      ref
                          .read(discoveryCoursesProvider().notifier)
                          .search(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(marketplaceTenantsProvider);
          ref.invalidate(discoveryCoursesProvider());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 70, // Start below appbar
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Categories',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              popularCategoriesAsync.when(
                data: (categories) =>
                    _buildCategories(context, theme, categories),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text('Error: $e'),
              ),
              const Gap(32),
              Text(
                'Universities & Institutions',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              tenantsAsync.when(
                data: (tenants) =>
                    _buildTenantsGrid(context, tenants, colorScheme),
                loading: () => _buildTenantsShimmer(colorScheme),
                error: (e, s) => Text(
                  'Error: $e',
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
              const Gap(32),
              Text(
                'Available Courses',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              coursesAsync.when(
                data: (courses) => _buildVerticalCourseList(courses),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text(
                  'Error: $e',
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenantsGrid(
    BuildContext context,
    List<TenantModel> tenants,
    ColorScheme colorScheme,
  ) {
    // Limited to max 10 institutions as per requirement
    final limitedTenants = tenants.take(10).toList();

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: limitedTenants.length,
        separatorBuilder: (context, index) => const Gap(20),
        itemBuilder: (context, index) {
          final tenant = limitedTenants[index];
          return InkWell(
            onTap: () => context.push('/platform/${tenant.id}'),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: (tenant.logoUrl != null && tenant.logoUrl!.isNotEmpty)
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: tenant.logoUrl!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: colorScheme.surfaceContainerHighest,
                                highlightColor: colorScheme.surface,
                                child: Container(color: colorScheme.surface),
                              ),
                              errorWidget: (context, url, err) => Icon(
                                Icons.business,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.business,
                            color: colorScheme.onSurfaceVariant,
                          ),
                  ),
                ),
                const Gap(8),
                SizedBox(
                  width: 72,
                  child: Text(
                    tenant.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Tracks which course index is currently expanded
  int? _expandedIndex;

  Widget _buildVerticalCourseList(List<DiscoveryCourseModel> courses) {
    if (courses.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('No courses found.'),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      separatorBuilder: (context, index) => const Gap(20),
      itemBuilder: (context, index) {
        final isExpanded = _expandedIndex == index;

        return MarketplaceCourseCard(
          course: courses[index],
          isExpanded: isExpanded,
          onToggleExpanded: () {
            setState(() {
              if (isExpanded) {
                // If the user clicks the currently expanded card, close it
                _expandedIndex = null;
              } else {
                // Otherwise expand the new card and auto-close the others
                _expandedIndex = index;
              }
            });
          },
        );
      },
    );
  }

  Widget _buildTenantsShimmer(ColorScheme colorScheme) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const Gap(20),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: colorScheme.surfaceContainerHighest,
          highlightColor: colorScheme.surface,
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                ),
              ),
              const Gap(8),
              Container(width: 40, height: 10, color: colorScheme.surface),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(
    BuildContext context,
    ThemeData theme,
    List<String> categories,
  ) {
    if (categories.isEmpty) {
      return const Text('No categories available.');
    }
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: categories
          .map(
            (cat) => Chip(
              label: Text(cat),
              backgroundColor: theme.colorScheme.surface,
              labelStyle: theme.textTheme.bodyMedium,
              elevation: 0,
              side: BorderSide(color: theme.dividerColor),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          )
          .toList(),
    );
  }
}
