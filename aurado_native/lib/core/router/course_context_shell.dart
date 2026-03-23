import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../presentation/components/aurado_navigation_bar.dart';
import '../../features/marketplace/presentation/widgets/tenant_theme_observer.dart';
import '../theme/aurado_theme.dart';
import 'app_router.dart';

/// The scaffold for the course context using [StatefulShellRoute].
///
/// This provides a different navbar and a sticky home button at the top.
/// It also wraps everything in [TenantThemeObserver] to apply branding.
class CourseContextShell extends StatefulWidget {
  final Widget child;
  final String tenantId;
  final String courseId;
  final String location;

  const CourseContextShell({
    super.key,
    required this.child,
    required this.tenantId,
    required this.courseId,
    required this.location,
  });

  @override
  State<CourseContextShell> createState() => _CourseContextShellState();
}

class _CourseContextShellState extends State<CourseContextShell>
    with SingleTickerProviderStateMixin {
  int _revealCounter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(CourseContextShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      // Trigger reveal on navigation by incrementing a counter
      setState(() => _revealCounter++);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _calculateSelectedIndex(String location) {
    if (location.contains('/overview')) return 0;
    if (location.contains('/content')) return 1;
    if (location.contains('/leaderboard')) return 2;
    if (location.contains('/progress')) return 3;
    if (location.contains('/academy')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed('courseOverview', pathParameters: {
          'tenantId': widget.tenantId,
          'courseId': widget.courseId,
        });
        break;
      case 1:
        context.goNamed('courseContent', pathParameters: {
          'tenantId': widget.tenantId,
          'courseId': widget.courseId,
        });
        break;
      case 2:
        context.goNamed('courseLeaderboard', pathParameters: {
          'tenantId': widget.tenantId,
          'courseId': widget.courseId,
        });
        break;
      case 3:
        context.goNamed('courseProgress', pathParameters: {
          'tenantId': widget.tenantId,
          'courseId': widget.courseId,
        });
        break;
      case 4:
        context.goNamed('academyProfile', pathParameters: {
          'tenantId': widget.tenantId,
          'courseId': widget.courseId,
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(widget.location);

    return TenantThemeObserver(
      tenantId: widget.tenantId,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Positioned.fill(child: widget.child),
            
            // Sticky Top Bar (Home Button) - Top Right
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 20,
              child: _HomeButton(revealTrigger: _revealCounter),
            ),
          ],
        ),
        bottomNavigationBar: AuradoNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onTap(context, index),
          items: const [
            AuradoNavItem(
              icon: HugeIcons.strokeRoundedDashboardSquare01,
              label: 'Overview',
            ),
            AuradoNavItem(
              icon: HugeIcons.strokeRoundedBookOpen01,
              label: 'Content',
            ),
            AuradoNavItem(
              icon: HugeIcons.strokeRoundedChampion,
              label: 'Leads',
            ),
            AuradoNavItem(
              icon: HugeIcons.strokeRoundedCheckmarkCircle02,
              label: 'Progress',
            ),
            AuradoNavItem(
              icon: HugeIcons.strokeRoundedBuilding02,
              label: 'Academy',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeButton extends StatefulWidget {
  final int revealTrigger;

  const _HomeButton({required this.revealTrigger});

  @override
  State<_HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<_HomeButton> {
  bool _isHovered = false;
  bool _showText = false;
  Timer? _revealTimer;

  @override
  void didUpdateWidget(_HomeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.revealTrigger != widget.revealTrigger) {
      _triggerReveal();
    }
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    super.dispose();
  }

  void _triggerReveal() {
    setState(() => _showText = true);
    _revealTimer?.cancel();
    _revealTimer = Timer(const Duration(seconds: 2), () {
      if (mounted && !_isHovered) {
        setState(() => _showText = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final navTheme = theme.extension<NavBarTheme>();
    final activeColor = navTheme?.activeColor ?? Colors.blue;
    final inactiveColor = navTheme?.unselectedColor ?? colorScheme.onSurface.withValues(alpha: 0.6);
    final showExpanded = _isHovered || _showText;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        // If we were showing text via trigger, start/restart the timer when leaving hover
        if (_showText) {
          _triggerReveal();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 40,
        clipBehavior: Clip.antiAlias,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () => context.go(AppRoutes.home),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedHome01,
                    color: activeColor,
                    size: 20,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    child: SizedBox(
                      width: showExpanded ? null : 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: showExpanded ? 10 : 0),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: showExpanded ? 1 : 0,
                          child: Text(
                            'Aurado home',
                            softWrap: false,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: inactiveColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

