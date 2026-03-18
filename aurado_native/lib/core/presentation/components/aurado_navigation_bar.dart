import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../theme/aurado_theme.dart';

/// A custom, floating navigation bar with glassmorphism and an organic "blob" indicator.
///
/// Matches the design referenced by the user with a custom-shaped indicator
/// that slides smoothly between positions.
class AuradoNavigationBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final navTheme = Theme.of(context).extension<NavBarTheme>()!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final barWidth = screenWidth - 40; // 20 padding on each side
    final itemWidth = barWidth / items.length;

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
            // 1. Glass Background layer
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: navTheme.blur, sigmaY: navTheme.blur),
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withAlpha((navTheme.glassOpacity * 255).toInt()),
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              
              // 2. Animated Pointed Blob Indicator (Sharper, larger, triangular)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.elasticOut,
                left: (currentIndex * itemWidth) + (itemWidth / 2) - 25,
                bottom: -2, // Push slightly below to ensure masking at the edge
                child: CustomPaint(
                  size: const Size(50, 20), // Larger size
                  painter: _BlobPainter(color: navTheme.activeColor),
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
                            color: isSelected ? navTheme.activeColor : navTheme.unselectedColor,
                            size: 28, // Slightly larger icons
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
