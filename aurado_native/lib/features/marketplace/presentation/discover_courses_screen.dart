import 'package:aurado/features/marketplace/domain/models/discovery_course_model.dart';
import 'package:aurado/features/marketplace/domain/models/tenant_model.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:aurado/features/marketplace/presentation/widgets/marketplace_course_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../shared/widgets/performance_blur.dart';
import '../../../core/performance/performance_provider.dart';
import '../../../core/theme/theme_config.dart';
import 'package:aurado/features/marketplace/presentation/widgets/marketplace_institution_card.dart';

class DiscoverCoursesScreen extends ConsumerStatefulWidget {
  const DiscoverCoursesScreen({super.key});

  @override
  ConsumerState<DiscoverCoursesScreen> createState() =>
      _DiscoverCoursesScreenState();
}

class _DiscoverCoursesScreenState extends ConsumerState<DiscoverCoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool get _isSearching => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final tenantsAsync = ref.watch(marketplaceTenantsProvider);
    final coursesAsync = ref.watch(discoveryCoursesProvider(
      category: _isSearching ? null : (_selectedCategory == 'All' ? null : _selectedCategory),
    ));
    final featuredCoursesAsync = ref.watch(featuredCoursesProvider);
    final searchTenantsAsync = _isSearching 
        ? ref.watch(searchTenantsProvider(_searchController.text))
        : const AsyncValue<List<TenantModel>>.data([]);

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
                fontWeight: ThemeConfig.weightExtraBold,
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
          ref.invalidate(featuredCoursesProvider);
          ref.invalidate(popularCategoriesProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top + 70,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          // Single gate: show the full-page skeleton when any primary provider is loading.
          // This prevents 2-4 fragmented shimmer sections appearing simultaneously.
          child: _isPageLoading(coursesAsync, featuredCoursesAsync, tenantsAsync)
              ? _buildPageSkeleton(colorScheme)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Horizontal Categories Navigation - Hidden when searching
                    if (!_isSearching) ...[
                      popularCategoriesAsync.maybeWhen(
                        data: (categories) => _buildHorizontalCategories(context, categories),
                        orElse: () => _buildCategoryShimmer(colorScheme),
                      ),
                      const Gap(24),

                      // Featured Section
                      featuredCoursesAsync.maybeWhen(
                        data: (courses) => _buildFeaturedSection(context, courses),
                        orElse: () => const SizedBox.shrink(),
                      ),
                      const Gap(32),

                      // Institutions Section
                      tenantsAsync.maybeWhen(
                        data: (tenants) => _buildInstitutionsSection(context, tenants, colorScheme),
                        orElse: () => const SizedBox.shrink(),
                      ),
                      const Gap(32),

                      // Available Courses Section Header
                      Text(
                        'Available Courses',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: ThemeConfig.sectionHeaderWeight,
                          letterSpacing: ThemeConfig.sectionHeaderLetterSpacing,
                        ),
                      ),
                    ] else ...[
                      // Search Results Header
                      Text(
                        'Search Results',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: ThemeConfig.sectionHeaderWeight,
                          letterSpacing: ThemeConfig.sectionHeaderLetterSpacing,
                        ),
                      ),
                    ],
                    const Gap(16),
                    
                    // Main Feed (Mixed when searching)
                    if (_isSearching)
                      _buildMixedSearchResults(coursesAsync, searchTenantsAsync, colorScheme)
                    else
                      coursesAsync.maybeWhen(
                        data: (courses) => _buildVerticalCourseList(courses),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    
                    const Gap(80),
                  ],
                ),
        ),
      ),
    );
  }

  /// Returns true when any of the three primary data providers are still loading.
  bool _isPageLoading(AsyncValue courses, AsyncValue featured, AsyncValue tenants) {
    return courses.isLoading || featured.isLoading || tenants.isLoading;
  }

  /// A single full-page skeleton that mirrors the real layout.
  /// Shown while any primary data provider is fetching.
  Widget _buildPageSkeleton(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final baseShimmer = isDark ? colorScheme.surfaceContainerLow : colorScheme.surfaceContainerHighest;
    final highlightShimmer = isDark ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainerLow;

    return Shimmer.fromColors(
      baseColor: baseShimmer,
      highlightColor: highlightShimmer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chips row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(5, (i) => _skeletonBox(
                width: 70 + (i % 2) * 20.0,
                height: 36,
                radius: 100,
                marginRight: 12,
                color: colorScheme.surfaceContainerHighest,
              )),
            ),
          ),
          const Gap(24),

          // Featured section header + cards
          _skeletonBox(width: 160, height: 16, radius: 8, color: colorScheme.surfaceContainerHighest),
          const Gap(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(3, (i) => _skeletonBox(
                width: 220,
                height: 190,
                radius: 16,
                marginRight: 12,
                color: colorScheme.surfaceContainerHighest,
              )),
            ),
          ),
          const Gap(32),

          // Institutions header + rows
          _skeletonBox(width: 140, height: 16, radius: 8, color: colorScheme.surfaceContainerHighest),
          const Gap(16),
          _buildInstitutionSkeletonRow(colorScheme),
          const Gap(24),
          _buildInstitutionSkeletonRow(colorScheme),
          const Gap(32),

          // "Available Courses" header
          _skeletonBox(width: 180, height: 16, radius: 8, color: colorScheme.surfaceContainerHighest),
          const Gap(16),

          // Course card skeletons
          ...List.generate(4, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(ThemeConfig.radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(ThemeConfig.radiusLg)),
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _skeletonBox(height: 12, radius: 6, color: colorScheme.surfaceContainerLow),
                          const Gap(8),
                          _skeletonBox(width: 160, height: 12, radius: 6, color: colorScheme.surfaceContainerLow),
                          const Spacer(),
                          _skeletonBox(width: 80, height: 10, radius: 6, color: colorScheme.surfaceContainerLow),
                        ],
                      ),
                    ),
                  ),
                  const Gap(12),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInstitutionSkeletonRow(ColorScheme colorScheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: List.generate(5, (i) => Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
              ),
              const Gap(8),
              Container(
                width: 40, 
                height: 8, 
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _skeletonBox({
    double? width,
    double height = 16,
    double radius = 8,
    double marginRight = 0,
    Color? color,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(right: marginRight),
      decoration: BoxDecoration(
        color: color ?? Colors.white, // Fallback but parameter is used
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }


  Widget _buildHorizontalCategories(BuildContext context, List<String> categories) {
    if (categories.isEmpty) return const SizedBox.shrink();
    
    // Using a list that includes "All" as the first option
    final allCategories = ['All', ...categories.take(8)]; // Limit to popular as requested

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const Gap(12),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = _selectedCategory == category;

          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (val) {
              setState(() {
                _selectedCategory = val ? category : 'All';
              });
            },
            backgroundColor: Colors.transparent,
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? ThemeConfig.weightBold : ThemeConfig.weightMedium,
              fontSize: ThemeConfig.chipLabelSize,
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected 
                  ? Colors.transparent 
                  : Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            showCheckmark: false,
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection(BuildContext context, List<DiscoveryCourseModel> courses) {
    if (courses.isEmpty) return const SizedBox.shrink();
    
    final featuredCourses = courses.take(5).toList();
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Courses',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: ThemeConfig.sectionHeaderWeight,
                    letterSpacing: ThemeConfig.sectionHeaderLetterSpacing,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('See All', style: TextStyle(fontSize: ThemeConfig.actionLinkSize, fontWeight: ThemeConfig.actionLinkWeight)),
            ),
          ],
        ),
        const Gap(8),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: featuredCourses.length,
            separatorBuilder: (context, index) => const Gap(12),
            itemBuilder: (context, index) {
              final course = featuredCourses[index];
              return _buildFeaturedCard(context, course, colorScheme);
            },
          ),
        ),
      ],
    );
  }

  /// Mirrors the navigation logic in [MarketplaceCourseCard._handleTap].
  /// Enrolled users go straight to the course overview; others see the details page.
  void _handleFeaturedCourseTap(
    BuildContext context,
    DiscoveryCourseModel course,
  ) {
    final enrolledAsync = ref.read(enrolledCoursesProvider);
    if (enrolledAsync.isLoading) {
      // Enrollment state unknown — fall back to details page gracefully.
      context.push('/app/discover-courses/details/${course.tenantId}/${course.id}');
      return;
    }
    final isEnrolled =
        enrolledAsync.asData?.value.any((c) => c.id == course.id) ?? false;
    if (isEnrolled) {
      context.push('/platform/${course.tenantId}/course/${course.id}/overview');
    } else {
      context.push('/app/discover-courses/details/${course.tenantId}/${course.id}');
    }
  }

  Widget _buildFeaturedCard(
    BuildContext context,
    DiscoveryCourseModel course,
    ColorScheme colorScheme,
  ) {
    return GestureDetector(
      onTap: () => _handleFeaturedCourseTap(context, course),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail — fill using Expanded so it never overflows
            Expanded(
              flex: 7,
              child: SizedBox.expand(
                child: (course.thumbnailUrl != null && course.thumbnailUrl!.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: course.thumbnailUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        errorWidget: (context, url, err) => Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(Icons.school_outlined, color: colorScheme.onSurfaceVariant, size: 32),
                        ),
                      )
                    : Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(Icons.school_outlined, color: colorScheme.onSurfaceVariant, size: 32),
                      ),
              ),
            ),
            // Info
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: ThemeConfig.cardTitleWeight,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      course.price <= 0 ? 'Free' : '৳${course.price.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: ThemeConfig.cardPriceWeight,
                        fontSize: ThemeConfig.cardPriceSize,
                        color: ThemeConfig.textPrice,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutionsSection(
    BuildContext context,
    List<TenantModel> tenants,
    ColorScheme colorScheme,
  ) {
    if (tenants.isEmpty) return const SizedBox.shrink();

    // Split into two groups as requested
    final row1 = tenants.take(5).toList();
    final row2 = tenants.skip(5).take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Institutions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: ThemeConfig.sectionHeaderWeight,
                letterSpacing: ThemeConfig.sectionHeaderLetterSpacing,
              ),
        ),
        const Gap(16),
        _buildInstitutionRow(context, row1, colorScheme),
        if (row2.isNotEmpty) ...[
          const Gap(24),
          _buildInstitutionRow(context, row2, colorScheme),
        ],
      ],
    );
  }

  Widget _buildInstitutionRow(BuildContext context, List<TenantModel> tenants, ColorScheme colorScheme) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tenants.length,
        separatorBuilder: (context, index) => const Gap(24),
        itemBuilder: (context, index) {
          final tenant = tenants[index];
          return InkWell(
            onTap: () => context.push('/platform/${tenant.id}'),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.1), // Decreased border as requested
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.03),
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
                              width: 44,
                              height: 44,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: colorScheme.surfaceContainerHighest,
                                highlightColor: colorScheme.surface,
                                child: Container(color: colorScheme.surface),
                              ),
                              errorWidget: (context, url, err) => Icon(
                                Icons.business,
                                size: 20,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.business,
                            size: 20,
                            color: colorScheme.onSurfaceVariant,
                          ),
                  ),
                ),
                const Gap(8),
                SizedBox(
                  width: 64,
                  child: Text(
                    tenant.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: ThemeConfig.institutionLabelWeight,
                      fontSize: ThemeConfig.institutionLabelSize,
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
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const Gap(20),
      itemBuilder: (context, index) {
        return MarketplaceCourseCard(
          course: courses[index],
        );
      },
    );
  }

  Widget _buildMixedSearchResults(
    AsyncValue<List<DiscoveryCourseModel>> coursesAsync,
    AsyncValue<List<TenantModel>> tenantsAsync,
    ColorScheme colorScheme,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Institutions Results
        tenantsAsync.when(
          data: (tenants) {
            if (tenants.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Institutions',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: ThemeConfig.weightExtraBold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Gap(12),
                ...tenants.map((tenant) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MarketplaceInstitutionCard(institution: tenant),
                )),
                const Gap(12),
              ],
            );
          },
          loading: () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _skeletonBox(width: 100, height: 16, radius: 4),
              const Gap(12),
              _skeletonBox(width: double.infinity, height: 160, radius: ThemeConfig.radiusLg),
              const Gap(20),
            ],
          ),
          error: (e, s) => const SizedBox.shrink(),
        ),

        // Courses Results Header (if institutions were shown)
        if (tenantsAsync.value?.isNotEmpty == true) ...[
          Text(
            'Related Courses',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: ThemeConfig.weightExtraBold,
              color: colorScheme.onSurface,
            ),
          ),
          const Gap(12),
        ],

        // Courses
        coursesAsync.when(
          data: (courses) {
            if (courses.isEmpty && tenantsAsync.value?.isEmpty == true) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text('No results found for your search.'),
                ),
              );
            }
            return _buildVerticalCourseList(courses);
          },
          loading: () => const SizedBox.shrink(),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }

  /// Shimmer row of pill-shaped chips — replaces the blue LinearProgressIndicator.
  Widget _buildCategoryShimmer(ColorScheme colorScheme) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const Gap(12),
        itemBuilder: (context, index) {
          final isDark = colorScheme.brightness == Brightness.dark;
          return Shimmer.fromColors(
            baseColor: isDark ? colorScheme.surfaceContainerLow : colorScheme.surfaceContainerHighest,
            highlightColor: isDark ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainerLow,
            child: Container(
              width: 70 + (index % 2) * 20.0,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          );
        },
      ),
    );
  }
}
