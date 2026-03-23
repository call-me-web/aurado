import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../performance/performance_provider.dart';

class AuradoCard extends ConsumerWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double blur;
  final double borderRadius;
  final VoidCallback? onTap;

  const AuradoCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.blur = 10,
    this.borderRadius = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performance = ref.watch(performanceProvider);
    final theme = Theme.of(context);
    final cardColor = color ?? theme.colorScheme.surface;

    Widget cardContent = Material(
      color: performance.enableGlassmorphism 
          ? cardColor.withValues(alpha: 0.8)
          : cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );

    if (performance.enableGlassmorphism) {
      cardContent = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: cardContent,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      ),
    );
  }
}
