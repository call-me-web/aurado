import 'package:aurado/features/marketplace/presentation/widgets/marketplace_course_card.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class PlatformHomeScreen extends ConsumerWidget {
  final String tenantId;

  const PlatformHomeScreen({
    super.key,
    required this.tenantId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantAsync = ref.watch(tenantProvider(tenantId));
    final coursesAsync = ref.watch(discoveryCoursesProvider(tenantId: tenantId));

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return tenantAsync.when(
      data: (tenant) {
        if (tenant == null) {
          return const Scaffold(
            body: Center(child: Text('Platform not found')),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 70,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
                  child: IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedShare01,
                      color: colorScheme.onSurface,
                      size: 20,
                    ),
                    onPressed: () {
                      // TODO: Implement share
                    },
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, tenant, colorScheme, textTheme),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Courses',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(16),
                      coursesAsync.when(
                        data: (courses) => _buildCourseList(courses),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, s) => Text('Error loading courses'),
                      ),
                    ],
                  ),
                ),
                const Gap(40),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    dynamic tenant,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Stack(
      children: [
        // Cover Image with Blur Overlay
        AspectRatio(
          aspectRatio: 16 / 10,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: (tenant.coverUrl != null && tenant.coverUrl!.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: tenant.coverUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(color: colorScheme.surface),
                      )
                    : Container(color: colorScheme.surface),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      colorScheme.surface,
                    ],
                    stops: const [0, 0.5, 1],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Institution Info Overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Logo with Border
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: (tenant.logoUrl != null && tenant.logoUrl!.isNotEmpty)
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: tenant.logoUrl!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) => Icon(
                                Icons.business,
                                color: colorScheme.primary,
                                size: 40,
                              ),
                            ),
                          )
                        : Icon(Icons.business, size: 40, color: colorScheme.onSurfaceVariant),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tenant.name,
                          style: textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Authorized EdTech Partner',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseList(List<dynamic> courses) {
    if (courses.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('No courses offered by this institution.'),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      separatorBuilder: (context, index) => const Gap(16),
      itemBuilder: (context, index) {
        return MarketplaceCourseCard(
          course: courses[index],
          onTap: () {
            // Navigate to Course Details
            context.push('/platform/$tenantId/course/${courses[index].id}');
          },
        );
      },
    );
  }
}
