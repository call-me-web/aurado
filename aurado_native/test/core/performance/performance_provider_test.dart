import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aurado/core/performance/performance_provider.dart';

void main() {
  group('PerformanceProvider Tests', () {
    test('initial state has glassmorphism enabled', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(performanceProvider);
      expect(state.enableGlassmorphism, true);
      expect(state.enableComplexAnimations, true);
    });

    test('toggleGlassmorphism updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(performanceProvider.notifier);
      
      notifier.toggleGlassmorphism(false);
      expect(container.read(performanceProvider).enableGlassmorphism, false);

      notifier.toggleGlassmorphism(true);
      expect(container.read(performanceProvider).enableGlassmorphism, true);
    });
  });
}
