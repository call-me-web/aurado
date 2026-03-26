import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurado/core/presentation/components/aurado_card.dart';
import 'package:aurado/features/home/domain/models/dashboard_data.dart';
import 'package:aurado/features/home/providers/dashboard_provider.dart';
import 'package:aurado/features/auth/providers/auth_provider.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: dashboardAsync.when(
        data: (data) => CustomScrollView(
          slivers: [
            _buildAppBar(context, data.studentName, authState, ref),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDailyProgress(context, data),
                    const Gap(24),
                    if (data.recentLessons.isNotEmpty) ...[
                      _buildSectionHeader(
                        context,
                        'Continue Learning',
                        onSeeAll: () {},
                      ),
                      const Gap(12),
                      _buildContinueLearningList(context, data.recentLessons),
                      const Gap(24),
                    ],
                    _buildSectionHeader(
                      context,
                      'Discover Courses',
                      onSeeAll: () {},
                    ),
                    const Gap(12),
                    _buildMarketplaceHighlights(context),
                    const Gap(80), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) =>
            Center(child: Text('Error loading dashboard: $err')),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    String name,
    AuthStateData authState,
    WidgetRef ref,
  ) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Icon(
                  Icons.auto_awesome,
                  size: 150,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              if (authState.canRestore)
                _buildRestoreBanner(ref), // Added restore banner
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'স্বাগতম, $name 👋',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      const Text(
                        'আপনার লার্নিং জার্নি চালিয়ে যান',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        ),
        const Gap(10),
      ],
    );
  }

  Widget _buildRestoreBanner(WidgetRef ref) {
    return Positioned(
      // Wrapped in Positioned to place it correctly
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
        ), // Adjusted margin for SafeArea
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedDownload01,
              color: Colors.purple,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restore Progress?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Found a backup from another device.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () =>
                  ref.read(authProvider.notifier).restoreProgress(),
              child: const Text('Restore'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyProgress(BuildContext context, DashboardData data) {
    return AuradoCard(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Goal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Gap(4),
                Text('৩/৫টি লেসন সম্পন্ন হয়েছে'),
                Gap(12),
                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.white,
                  minHeight: 8,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ],
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 30,
                ),
                Text(
                  '${data.streakCount} দিন',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text('সবগুলো দেখুন')),
      ],
    );
  }

  Widget _buildContinueLearningList(
    BuildContext context,
    List<RecentLesson> lessons,
  ) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: lessons.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Container(
            width: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: lesson.thumbnailUrl.isNotEmpty
                    ? NetworkImage(lesson.thumbnailUrl)
                    : const NetworkImage(
                        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=400&auto=format&fit=crop',
                      ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${lesson.watchPercentage}% completed',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMarketplaceHighlights(BuildContext context) {
    return Column(
      children: [
        _buildMarketplaceItem(
          context,
          'Engineering Admission 2024',
          '10 Minute School',
          '৳ ৫০০০',
        ),
        _buildMarketplaceItem(
          context,
          'HSC Batch 2025',
          'Omanah School',
          '৳ ১৫০০',
        ),
      ],
    );
  }

  Widget _buildMarketplaceItem(
    BuildContext context,
    String title,
    String platform,
    String price,
  ) {
    return AuradoCard(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1434030216411-0bb7c3f35ad7?q=80&w=200&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    platform,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const Gap(8),
                  Text(
                    price,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
          const Gap(12),
        ],
      ),
    );
  }
}
