import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../presentation/components/aurado_navigation_bar.dart';
import '../../features/marketplace/presentation/widgets/tenant_theme_observer.dart';
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
  bool _isHovered = false;
  bool _showText = false;
  late AnimationController _glitchController;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void didUpdateWidget(CourseContextShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      // Trigger glitch on navigation
      _triggerGlitch();
    }
  }

  @override
  void dispose() {
    _glitchController.dispose();
    super.dispose();
  }

  void _triggerGlitch() {
    setState(() => _showText = true);
    _glitchController.forward(from: 0).then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_isHovered) {
          setState(() => _showText = false);
        }
      });
    });
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
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
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
              child: _buildHomeButton(context, colorScheme),
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

  Widget _buildHomeButton(BuildContext context, ColorScheme colorScheme) {
    final showExpanded = _isHovered || _showText;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 40, // Fixed height to prevent vertical stretching
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
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedHome01,
                    color: Colors.blue,
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
                          child: _GlitchText(
                            text: 'Aurado home',
                            trigger: _glitchController,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: colorScheme.onSurface,
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

class _GlitchText extends StatelessWidget {
  final String text;
  final Animation<double> trigger;
  final TextStyle style;

  const _GlitchText({
    required this.text,
    required this.trigger,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: trigger,
      builder: (context, child) {
        final value = trigger.value;
        if (value == 0 || value == 1) {
          return Text(
            text,
            style: style,
            softWrap: false,
            overflow: TextOverflow.visible,
          );
        }

        // Simple Glitch Effect: Layered text with offsets and color splits
        final offset1 = (value < 0.3 || (value > 0.6 && value < 0.7)) ? 1.5 : 0.0;
        final offset2 = (value > 0.3 && value < 0.5) ? -1.5 : 0.0;
        final opacity = (value * 10).toInt() % 2 == 0 ? 1.0 : 0.7;

        return Stack(
          children: [
            // Red Split
            Transform.translate(
              offset: Offset(offset1, 0),
              child: Text(
                text,
                softWrap: false,
                style: style.copyWith(
                  color: Colors.red.withValues(alpha: 0.5 * opacity),
                ),
              ),
            ),
            // Blue Split
            Transform.translate(
              offset: Offset(offset2, 0),
              child: Text(
                text,
                softWrap: false,
                style: style.copyWith(
                  color: Colors.blue.withValues(alpha: 0.5 * opacity),
                ),
              ),
            ),
            // Original
            Text(
              text,
              softWrap: false,
              style: style.copyWith(
                  color: style.color?.withValues(alpha: opacity)),
            ),
          ],
        );
      },
    );
  }
}
