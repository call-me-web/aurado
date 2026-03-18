import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../components/aurado_navigation_bar.dart';

class MainShellScreen extends ConsumerWidget {
  final Widget child;

  const MainShellScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: AuradoNavigationBar(
        currentIndex: _getSelectedIndex(location),
        onTap: (index) => _onTap(context, index),
        items: [
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedHome03,
            label: 'Home',
          ),
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedDiscoverCircle,
            label: 'Marketplace',
          ),
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedAudioBook01,
            label: 'My Courses',
          ),
          AuradoNavItem(
            icon: HugeIcons.strokeRoundedUser,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/marketplace')) return 1;
    if (location.startsWith('/my-courses')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/marketplace');
        break;
      case 2:
        context.go('/my-courses');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
