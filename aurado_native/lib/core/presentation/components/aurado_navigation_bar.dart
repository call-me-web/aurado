import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../theme/aurado_theme.dart';

/// A custom, floating navigation bar with glassmorphism and an organic "blob" indicator.
///
/// Matches the design referenced by the user with a custom-shaped indicator
/// that slides smoothly between positions.
import '../../performance/performance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A custom, floating navigation bar with optional glassmorphism and an organic "blob" indicator.
class AuradoNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<AuradoNavItem> items;

  const AuradoNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final navTheme = theme.extension<NavBarTheme>();
    final activeColor = navTheme?.activeColor ?? theme.colorScheme.primary;
    final unselectedColor = navTheme?.unselectedColor ?? theme.colorScheme.onSurfaceVariant;
    
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final barWidth = (screenWidth - 40).clamp(0.0, double.infinity);
    final itemWidth = items.isEmpty ? 0.0 : barWidth / items.length;
    final performance = ref.watch(performanceProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding > 0 ? bottomPadding * 0.5 : 10),
      child: Container(
        height: 75, // Sleek, reduced height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias, // Critical for masking the blob
        child: Stack(
          children: [
            // 1. Background layer (Glass or Solid)
            Positioned.fill(
              child: _buildBackground(context, navTheme, performance.enableGlassmorphism),
            ),
            
            // 2. Animated Pointed Blob Indicator (Sharper, larger, triangular)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              curve: Curves.elasticOut,
              left: (currentIndex * itemWidth) + (itemWidth / 2) - 25,
              bottom: -2, // Push slightly below to ensure masking at the edge
              child: CustomPaint(
                size: const Size(50, 20), // Larger size
                painter: _BlobPainter(color: activeColor),
              ),
            ),
            
            // 3. Icons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final isSelected = currentIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        transform: Matrix4.translationValues(0, isSelected ? -4 : 0, 0),
                        child: HugeIcon(
                          icon: items[index].icon,
                          color: isSelected ? activeColor : unselectedColor,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(BuildContext context, NavBarTheme? navTheme, bool enableGlass) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final blur = navTheme?.blur ?? 10.0;
    final glassOpacity = navTheme?.glassOpacity ?? 0.8;
    
    if (enableGlass) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: surfaceColor.withAlpha((glassOpacity * 255).toInt()),
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      );
    }
    
    // Fallback: Solid background for better performance
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }
}

/// Paints the triangular, pointed "blob" indicator.
class _BlobPainter extends CustomPainter {
  final Color color;

  _BlobPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
      // Removed blur to keep it "sharp" as requested

    final path = Path();
    // Start from bottom left
    path.moveTo(0, size.height);
    
    // Create a pointed triangle shape with slightly rounded top
    path.lineTo(size.width * 0.2, size.height); // Base
    
    // Up to the point
    path.conicTo(
      size.width / 2, 
      0, // Pointed at the top center
      size.width * 0.8, 
      size.height,
      1.5, // Curvature weight
    );
    
    path.lineTo(size.width, size.height); // Base
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuradoNavItem {
  final dynamic icon;
  final String label;

  const AuradoNavItem({
    required this.icon,
    required this.label,
  });
}
