import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../presentation/components/aurado_navigation_bar.dart';

/// The main scaffold for the application using [StatefulShellRoute].
/// This maintains state across the bottom navigation tabs.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  /// The navigation shell and state for the branches.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: AuradoNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          AuradoNavItem(icon: HugeIcons.strokeRoundedHome03, label: 'Home'),
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedDiscoverCircle,
            label: 'Discover',
          ),
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedAudioBook01,
            label: 'Courses',
          ),
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedFolderLibrary,
            label: 'Library',
          ),
          AuradoNavItem(icon: HugeIcons.strokeRoundedUser, label: 'Profile'),
        ],
      ),
    );
  }
}
