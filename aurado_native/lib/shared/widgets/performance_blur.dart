import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/performance/performance_provider.dart';

/// A wrapper widget that applies [BackdropFilter] ONLY if [performanceProvider] allows it.
/// 
/// This is used to maintain "Glassmorphism" on high-end devices while ensuring
/// smoothness on older devices by falling back to a simple [child].
class PerformanceBlur extends ConsumerWidget {
  final double blur;
  final Widget child;

  const PerformanceBlur({
    super.key,
    this.blur = 10.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performance = ref.watch(performanceProvider);

    if (performance.enableGlassmorphism) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: child,
        ),
      );
    }

    return child;
  }
}
