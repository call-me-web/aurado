import 'package:aurado/features/marketplace/presentation/widgets/marketplace_course_card.dart';
import 'package:aurado/features/marketplace/providers/marketplace_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class MarketplaceScreen extends ConsumerStatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  ConsumerState<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends ConsumerState<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tenantsAsync = ref.watch(marketplaceTenantsProvider);
    final coursesAsync = ref.watch(discoveryCoursesProvider());

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Marketplace', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search courses or #hashtags',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    ref.read(discoveryCoursesProvider().notifier).search('');
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              onSubmitted: (value) {
                ref.read(discoveryCoursesProvider().notifier).search(value);
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(marketplaceTenantsProvider);
          ref.invalidate(discoveryCoursesProvider());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Universities & Institutions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Gap(16),
              tenantsAsync.when(
                data: (tenants) => _buildTenantsGrid(context, tenants),
                loading: () => _buildTenantsShimmer(),
                error: (e, s) => Text('Error: $e'),
              ),
              const Gap(32),
              const Text('Available Courses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Gap(16),
              coursesAsync.when(
                data: (courses) => _buildVerticalCourseList(courses),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text('Error: $e'),
              ),
              const Gap(80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenantsGrid(BuildContext context, tenants) {
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
          return Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: tenant.logoUrl != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: tenant.logoUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.grey.shade100,
                              child: Container(color: Colors.white),
                            ),
                          ),
                        )
                      : const Icon(Icons.business, color: Colors.grey),
                ),
              ),
              const Gap(8),
              Text(
                tenant.name,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVerticalCourseList(courses) {
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
        return SizedBox(
          width: double.infinity,
          child: MarketplaceCourseCard(course: courses[index]),
        );
      },
    );
  }

  Widget _buildTenantsShimmer() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const Gap(20),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Container(width: 64, height: 64, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
              const Gap(8),
              Container(width: 40, height: 10, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
